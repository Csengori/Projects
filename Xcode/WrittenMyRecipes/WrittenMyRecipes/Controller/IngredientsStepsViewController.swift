//
//  DetailViewController.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 26/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class IngredientsStepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let testData = TestData()
    private let constants = Constants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
        self.navigationController?.navigationBar.barTintColor = .white      
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
        view.addSubview(tableView)
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
        return tableView.bounds.height  / 8
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData.dummyRecipe[section].count
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return testData.detailTableViewSections.count
    }
    
    private func setupConstraints(){
        setupViews()
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.showsVerticalScrollIndicator = false
        tv.contentInsetAdjustmentBehavior = .never
        tv.showsHorizontalScrollIndicator = false
        tv.separatorStyle = .none
        tv.allowsSelection = false
        tv.layer.masksToBounds = false
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        return tv
    }()
    
}


