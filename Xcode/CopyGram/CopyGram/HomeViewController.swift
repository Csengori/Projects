//
//  HomeViewController.swift
//  CopyGram
//
//  Created by Tamas Sagi on 02/06/2017.
//  Copyright © 2017 Tamas Sagi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        loadPost()
    }
    
    func loadPost(){
        FIRDatabase.database().reference().child(FirebaseReferences.posts).observe(.value, with: { (snapshot) in
            print(snapshot.value)
        })
    }
    
    
    
    
    
    
    
}
extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainFeedTableViewCell", for: indexPath)
        let random = CGFloat(arc4random_uniform(150))
        cell.backgroundColor = UIColor(red: random / 255, green: random / 255, blue: random / 255, alpha: 1)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
}

