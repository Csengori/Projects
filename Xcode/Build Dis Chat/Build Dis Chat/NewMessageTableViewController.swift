//
//  NewMessageTableViewController.swift
//  Build Dis Chat
//
//  Created by Tamas Sagi on 18/05/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import Firebase

class NewMessageTableViewController: UITableViewController {
    
    let cellID = "cellId"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        
        fetchUser()
    }
    
    func handleCancel()  {
        dismiss(animated: true, completion: nil)
    }
    
    func fetchUser() {
        FIRDatabase.database().reference().child("user").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String : AnyObject] {
                let user = User(dictionary : dictionary)
                self.users.append(user)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    //var messagesController: MessagesViewController?
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        dismiss(animated: true, completion: nil)
    //     let user = self.users[indexPath.row]
    //        self.messagesController?.showChatControllerForUser(users)
    //    }
    
    
    
    
}

class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
