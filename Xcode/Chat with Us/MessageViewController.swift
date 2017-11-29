//
//  MessageViewController.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 12/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseAuth
import FirebaseDatabase
import Firebase

class MessageViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    
    let databaseServices = DatabaseServices()
    let authServices = AuthServices()
    
    private var avatarSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height: kJSQMessagesCollectionViewAvatarSizeDefault)
    
    override func viewDidLoad() {
        FIRApp.configure()
        super.viewDidLoad()
        
        setupMessageView()
        observeMessages()
    }
    
    func setupMessageView(){
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        title = setDisplayName()
    }
    
    //MARK: db query for username if not available from register segue
    func setDisplayName() -> String {
        
        return ""
    }
    
    //MARK: HANDLE DISPLAY NAME
    private func addNewMessage(senderId: String, text: String){
        let messageItem = ["senderId" : FIRAuth.auth()!.currentUser!.uid,
                           "username" : "testUser",
                           "message" : text]
        
        //        databaseServices.updateDatabaseEntries(withUID: nil, values: messageItem, location: uploadLocationToogle.message)
        JSQSystemSoundPlayer.jsq_playMessageSentAlert()
        self.finishSendingMessage()
    }
    
    //MARK: ADD NEW MESSAGE
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
    }
    
    func observeMessages(){
        
    }
    
    //MARK: Dummy data
    //TODO: load images from storage via DB URL
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        return JSQMessagesAvatarImageFactory.avatarImage(withPlaceholder: UIImage(named: "user-128"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        
        // return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: "?", backgroundColor: UIColor.black, textColor: UIColor.white, font: UIFont.systemFont(ofSize: 14), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        return messages[indexPath.item].senderId == senderId ? setupOngoingMessageBubble() : setupIncomingMessageBubble()
    }
    
    private func setupOngoingMessageBubble() -> JSQMessagesBubbleImage {
        let bubbleImage = JSQMessagesBubbleImageFactory()
        return bubbleImage!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }
    
    private func setupIncomingMessageBubble() -> JSQMessagesBubbleImage {
        let bubbleImage = JSQMessagesBubbleImageFactory()
        return bubbleImage!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func singOutUser(){
        authServices.signOutCurrentUser()
        //let board = UIStoryboard(name: "main", bundle: nil)
        let vc = LoginViewController()
        present(vc, animated: true, completion: nil)
    }
    
}

