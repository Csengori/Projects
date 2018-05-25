//
//  ViewController.swift
//  BuildCompanies
//
//  Created by Tamas Sagi on 06/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let cellId = "indexPath"
    
    let twoDimensionalArray = [["Zac","Steve","John","Jordan"],
                               ["Johnatan","Katy","Abigal","Jamal"],
                               ["David","Dan"],
                               ["Kiara"]
    ]
    
    var showIndexPath = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Companies"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Press me", style: .plain, target: self, action: #selector(handleShowIndexPath))
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    @objc func handleShowIndexPath(){
        var indexPathsToReload = [IndexPath]()
        
        for sections in twoDimensionalArray.indices {
            for rows in twoDimensionalArray[sections].indices{
                let indexPath = IndexPath(row: rows, section: sections)
                indexPathsToReload.append(indexPath)
            }
        }
        
        showIndexPath = !showIndexPath
        let animationStyle = showIndexPath ? UITableViewRowAnimation.right : .left
         tableView.reloadRows(at:  indexPathsToReload, with: animationStyle)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.text = "Header Section: \(section)"
        return label
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return twoDimensionalArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId,for: indexPath)
        let name = twoDimensionalArray[indexPath.section][indexPath.row]
       
        cell.textLabel?.text = name
        
        if showIndexPath {
            cell.textLabel?.text = "Name: \(name) Section: \(indexPath.section) Row: \(indexPath.row)"
        }
        
        return cell
    }
}

