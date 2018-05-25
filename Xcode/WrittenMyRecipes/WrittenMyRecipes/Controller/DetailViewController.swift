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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        let headerNib = UINib.init(nibName: "CustomHeaderView", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "header")
        tableView.layoutIfNeeded()
    }
    
    private func setupViews(){
        view.backgroundColor = .grayColor
        self.navigationItem.title = "Selected Item"
        view.addSubview(placeHolderView)
        placeHolderView.addSubview(tableView)
        tableView.tableHeaderView = buttonPlaceHolderView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = testData.dummyRecipe[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CustomHeaderForDetail
        headerView.headerLabel.text = testData.detailTableViewSections[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.height / 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if section < testData.detailTableViewSections[section].count && section <= 1 {
            row = testData.detailTableViewSections[section].count
        }
        return row
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return testData.detailTableViewSections.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return view.frame.height / 4
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
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    private let topArrowButton: UIButton = {
//        let btn = UIButton()
//        
//        btn.setBackgroundImage(#imageLiteral(resourceName: "upArrow"), for: .normal)
//        btn.addTarget(self, action: #selector(handleTopArrow), for: .touchUpInside)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        return btn
//    }()
//    
    private let buttonPlaceHolderView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
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


