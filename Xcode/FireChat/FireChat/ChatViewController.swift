//
//  ChatViewController.swift
//  FireChat
//
//  Created by Tamas Sagi on 17/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController
import Photos

final class ChatViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    var channelRef: FIRDatabaseReference?
    var channel: Channel? {
        didSet{
            title = channel?.name
        }
    }
    private var updatedMessagesRefHandle: FIRDatabaseHandle?
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOngoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    private lazy var messageRef: FIRDatabaseReference = self.channelRef!.child("messages")
    private var newMessageRefHandle: FIRDatabaseHandle?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        observeMessages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeTyping()
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text){
            messages.append(message)
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    private func setupOngoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage{
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        }else {
            return incomingBubbleImageView
        }
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef.childByAutoId()
        let messageItem = ["senderId" : senderId,
                           "senderName" : senderDisplayName,
                           "text" : text]
        itemRef.setValue(messageItem)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
        isTyping = false
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        
        if message.senderId == senderId{
            cell.textView.textColor = UIColor.white
        }else {
            cell.textView.textColor = UIColor.black
        }
        return cell
    }
    
    private func observeMessages() {
        messageRef = channelRef!.child("messages")
        let messageQuery = messageRef.queryLimited(toLast:25)
        
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                self.addMessage(withId: id, name: name, text: text)
                self.finishReceivingMessage()
            } else if let id = messageData["senderId"] as String!, let photoURL = messageData["photoURL"] as String! {
                if let mediaItem = JSQPhotoMediaItem(maskAsOutgoing: id == self.senderId) {
                    self.addPhotoMessage(withId: id, key: snapshot.key, mediaItem: mediaItem)
                    
                    if photoURL.hasPrefix("gs://") {
                        self.fetchImageDataAtUrl(photoURL, forMediaItem: mediaItem, clearsPhotoMessageMapOnsuccesForKey: "")
                    }
                }
            } else {
                print("Error! Could not decode message data")
            }
        })
        

        updatedMessagesRefHandle = messageRef.observe(.childChanged, with: { (snapshot) in
            let key = snapshot.key
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let photoURL = messageData["photoURL"] as String! {
                // The photo has been updated.
                if let mediaItem = self.photoMessageMap[key] {
                    self.fetchImageDataAtUrl(photoURL, forMediaItem: mediaItem, clearsPhotoMessageMapOnsuccesForKey: key)
                }
            }
        })
    }
    
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        isTyping = textView.text != ""
    }
    
    private lazy var userIsTypingRef: FIRDatabaseReference = self.channelRef!.child("typingIndicator").child(self.senderId)
    private lazy var iserIsTypingQuery: FIRDatabaseQuery = self.channelRef!.child("typingIndicator").queryOrderedByValue().queryEqual(toValue: true)
    
    
    private var localTyping = false
    
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    private func observeTyping(){
        let typingIndicatorRef = channelRef!.child("typingIndicator")
        userIsTypingRef = typingIndicatorRef.child(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        
        iserIsTypingQuery.observe(.value) { (data: FIRDataSnapshot) in
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottom(animated: true)
        }
    }
    
    
    lazy var storageReference: FIRStorageReference = FIRStorage.storage().reference(forURL: "gs://friendlychat-ee80c.appspot.com/")
    
    private let imageURLNotSetKey = "NOTSET"
    
    func sendPhotoMessage() -> String? {
        let itemRef = messageRef.childByAutoId()
        let messageItem = ["photoURL" : imageURLNotSetKey,
                           "senderId" : senderId]
        print(imageURLNotSetKey)
        itemRef.setValue(messageItem)
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        finishSendingMessage()
        return itemRef.key
    }
    
    func setImageUrl(_ url: String, forPhotoMessageWithKey key: String) {
        let itemRef = messageRef.child(key)
        itemRef.updateChildValues(["photoURL" : url])
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        let picker = UIImagePickerController()
        picker.delegate = self
        if (UIImagePickerController.isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
        }else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    
    private var photoMessageMap = [String : JSQPhotoMediaItem]()
    
    private func addPhotoMessage(withId id: String, key: String, mediaItem: JSQPhotoMediaItem) {
        if let message = JSQMessage(senderId: id, displayName: "", media: mediaItem){
            messages.append(message)
            
            if (mediaItem.image == nil) {
                photoMessageMap[key] = mediaItem
            }
            collectionView.reloadData()
        }
    }
    
    private func fetchImageDataAtUrl(_ photoURL: String, forMediaItem mediaItem: JSQPhotoMediaItem, clearsPhotoMessageMapOnsuccesForKey key:String) {
        let storageRef = FIRStorage.storage().reference(forURL: photoURL)
        
        
        storageRef.data(withMaxSize: INT64_MAX) { (data, error) in
            if let err = error {
                print("error Downloading image data: \(err)")
                return
            }
            
            storageRef.metadata(completion: { (metadata, error) in
                if let err = error {
                    print("error downloading metadata: \(err)")
                }
                
//                if (metadata?.contentType == "image/gif"){
//                    mediaItem.image = UIImage.gifWithData(data!)
//                } else {
//                    mediaItem.image = UIImage.init(data: data!)
//                }
                
                mediaItem.image = UIImage.init(data: data!)
                self.collectionView.reloadData()
                
                guard key != nil else {
                    return
                }
                
                self.photoMessageMap.removeValue(forKey: key)
            })
        }
    }
    
    deinit {
        if let refHandle = newMessageRefHandle{
            messageRef.removeObserver(withHandle: refHandle)
        }
        
        if let refHandle = updatedMessagesRefHandle{
            messageRef.removeObserver(withHandle: refHandle)
        }
    }

}

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion:nil)
        if let photoReferenceUrl = info[UIImagePickerControllerReferenceURL] as? URL {
            let assets = PHAsset.fetchAssets(withALAssetURLs: [photoReferenceUrl], options: nil)
            let asset = assets.firstObject
            
            // 3
            if let key = sendPhotoMessage() {
                // 4
                asset?.requestContentEditingInput(with: nil, completionHandler: { (contentEditingInput, info) in
                    let imageFileURL = contentEditingInput?.fullSizeImageURL
                    let path = "\(String(describing: FIRAuth.auth()?.currentUser?.uid))/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\(photoReferenceUrl.lastPathComponent)"
                    self.storageReference.child(path).putFile(imageFileURL!, metadata: nil) { (metadata, error) in
                        if let error = error {
                            print("Error uploading photo: \(error.localizedDescription)")
                            return
                        }
                        // 7
                        self.setImageUrl(self.storageReference.child((metadata?.path)!).description, forPhotoMessageWithKey: key)
                    }
                })
            }
        } else {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            if let key = sendPhotoMessage() {
                let imageData = UIImageJPEGRepresentation(image, 1.0)
                let imagePath = (FIRAuth.auth()?.currentUser!.uid)! + "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
                let metadata = FIRStorageMetadata()
                metadata.contentType = "image/jpeg"
                storageReference.child(imagePath).put(imageData!, metadata: metadata) { metadata, error in
                    if let err = error {
                        print("error uploading photo: \(err)")
                        return
                    }
                    self.setImageUrl(self.storageReference.child((metadata?.path)!).description, forPhotoMessageWithKey: key)
            }
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion:nil)
    
    }
}
}
