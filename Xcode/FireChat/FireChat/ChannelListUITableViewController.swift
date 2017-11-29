//
//  ChannelViewController.swift
//  FireChat
//
//  Created by Tamas Sagi on 17/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase

class ChannelListUITableViewController: UITableViewController {
    
    enum Section: Int {
        case createNewChannelSection = 0
        case currentChannelSection
    }
    
    var senderDisplayName: String?
    var newChannelTextField: UITextField?
    private var channels: [Channel] = []
    private lazy var channelRef: FIRDatabaseReference = FIRDatabase.database().reference().child("channels")
    private var channelRefHandle: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "FireChat"
        observeChannel()
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    
    @IBAction func createChannel(_ sender: UIButton){
        if let name = newChannelTextField?.text{
            let newChannelRef = channelRef.childByAutoId()
            let channelItem = ["name" : name]
            newChannelRef.setValue(channelItem)
            newChannelTextField?.text = nil
        }
    }
    
    private func observeChannel() {
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot)  in
            let channelData = snapshot.value as! Dictionary<String, AnyObject>
            let id = snapshot.key
            if let name = channelData["name"] as? String, name.characters.count > 0 {
                self.channels.append(Channel(id: id, name: name))
                self.tableView.reloadData()
            }else {
                print("Error! Could not decode channel data")
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let currentSection = Section(rawValue: section) {
            switch currentSection {
            case .createNewChannelSection:
                return 1
            case .currentChannelSection:
                return channels.count
            }
        }
        else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.currentChannelSection.rawValue {
            let channel = channels[(indexPath as NSIndexPath).row]
            self.performSegue(withIdentifier: "ShowChannel", sender: channel)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = (indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue ? "NewChannel" : "ExistingChannel"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if(indexPath as NSIndexPath).section == Section.createNewChannelSection.rawValue {
            if let createNewChannelCell = cell as? CreateChannelCellTableViewCell {
                newChannelTextField = createNewChannelCell.newChannelNameField
            }
        }else if (indexPath as NSIndexPath).section == Section.currentChannelSection.rawValue{
            cell.textLabel?.text = channels[(indexPath as NSIndexPath).row].name
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let channel = sender as? Channel {
            let chatViewController = segue.destination as! ChatViewController
            
            chatViewController.senderDisplayName = senderDisplayName
            chatViewController.channel = channel
            chatViewController.channelRef = channelRef.child(channel.id)
        }
    }
}
