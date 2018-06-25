//
//  ShoppingListTableViewController.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 21/06/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UINavigationController, UITableViewDelegate, UITableViewDataSource {
    
    private let constants = Constants()
    let cellHeightHack = UIScreen.main.bounds.height / 14
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.shoppingListTableId, for: indexPath) as! ShoppingCellDividerTableViewCell
        cell.itemIdLabel?.text = String(indexPath.row)
        cell.quantityLabel?.text = String(drand48())
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeightHack
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            itemsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            itemsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant :  -self.cellHeightHack),
            itemsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            itemsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    private func setupTableView(){
        registerTableviewCells()
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
    }
    
    private func registerTableviewCells(){
        let shoppingNimb = UINib(nibName: "ShoppingCellDividerTableViewCell", bundle: nil)
        itemsTableView.register(shoppingNimb, forCellReuseIdentifier: constants.shoppingListTableId)
    }
    
    private func setupViews(){
        view.addSubview(itemsTableView)
        view.backgroundColor = .white
        setupTableView()
        setupConstraints()
    }
    
    private let itemsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.allowsSelection = false
        tv.isUserInteractionEnabled = true
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
}
