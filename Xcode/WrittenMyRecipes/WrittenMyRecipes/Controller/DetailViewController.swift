//
//  DetailViewController.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 26/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let testData = TestData()
    private let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
    }
    
    fileprivate func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: constants.selectedSectionId)
        let headerNib = UINib.init(nibName: "CustomHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: constants.selectedHeaderCellId)
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
        tableView.layoutIfNeeded()
    }
    
    private func setupViews(){
        view.backgroundColor = .grayColor
        self.navigationItem.title = "Selected Item"
        view.addSubview(placeHolderView)
        placeHolderView.addSubview(tableView)
        tableView.tableHeaderView = buttonPlaceHolderView
    }
    
    fileprivate func handleSectionLineBreak(_ indexPath: IndexPath, _ cell: UITableViewCell) {
        if indexPath.section == 1 {
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textAlignment = .justified
        } else {
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.numberOfLines = 1
        }
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.selectedSectionId, for: indexPath)
        handleSectionLineBreak(indexPath, cell)
        cell.textLabel?.text = testData.dummyRecipe[indexPath.section][indexPath.row]
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: constants.selectedHeaderCellId) as! CustomHeaderForDetail
        headerView.headerLabel.text = testData.detailTableViewSections[section]
        return headerView
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height / 8
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.dummyRecipe[section].count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return testData.detailTableViewSections.count
    }
    
    internal func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height / 8
    }
    
    private func setupConstraints(){
        setupViews()
        
        NSLayoutConstraint.activate([
            placeHolderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            placeHolderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            placeHolderView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            placeHolderView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            
            tableView.topAnchor.constraint(equalTo: placeHolderView.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: placeHolderView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: placeHolderView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: placeHolderView.bottomAnchor),
            ])
    }
    
    private let placeHolderView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let buttonPlaceHolderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        tv.allowsSelection = false
        tv.layer.masksToBounds = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
}


