//
//  NewMessageViewController.swift
//  Chat with Us
//
//  Created by Tamas Sagi on 13/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import Foundation
import JSQMessagesViewController
import JSQSystemSoundPlayer

class NewMessageViewController: JSQMessagesViewController {
    private var databaseServices = DatabaseServices()
    private var storageServices = StorageServices()
    private var messages = [JSQMessage]()
    private var avatarSize = CGSize(width: kJSQMessagesCollectionViewAvatarSizeDefault, height: kJSQMessagesCollectionViewAvatarSizeDefault)
    
    //TODO: setup message observation and message view
    override func viewDidLoad() {
        
    }
    
    private func setupMessageView(){
        
    }
    
    private func observeMessages(){
        
    }
    
    private func setTitleAsUsername(){
        
    }
    
    private func addNewMessage(){
        
    }
    
    //MARK: JSQMESSAGEVIEWCONTROLLER PROTOCOLS
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named: ""), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    //MARK: cosmetic stuff
    
    private func setupOngoingMessageBubble() -> JSQMessagesBubbleImage {
        let bubbleImage = JSQMessagesBubbleImageFactory()
        return bubbleImage!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleGreen())
    }
    
    private func setupIncomingMessageBubble() -> JSQMessagesBubbleImage {
        let bubbleImage = JSQMessagesBubbleImageFactory()
        return bubbleImage!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    
    
}
