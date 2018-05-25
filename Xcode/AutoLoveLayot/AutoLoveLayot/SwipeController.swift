//
//  SwipeController.swift
//  AutoLoveLayot
//
//  Created by Tamas Sagi on 06/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "forest", headerText: "Random message 1", descriptionText: "another random message 1"),
        Page(imageName: "Forest-2", headerText: "Random message 2", descriptionText: "another random message 2"),
        Page(imageName: "tree", headerText: "Random message 3", descriptionText: "another random message 3"),
        Page(imageName: "treecartoon", headerText: "Random message 4", descriptionText: "another random message 4"),
        Page(imageName: "Forest-2", headerText: "Random message 2", descriptionText: "another random message 2"),
        Page(imageName: "tree", headerText: "Random message 3", descriptionText: "another random message 3"),
        ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Previous", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)
            ,NSAttributedStringKey.foregroundColor : UIColor.gray])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedString = NSMutableAttributedString(string: "Next", attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18),NSAttributedStringKey.foregroundColor : UIColor.pink])
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
     lazy var pageViewControl: UIPageControl = {
        let pageView = UIPageControl()
        pageView.currentPageIndicatorTintColor = .red
        pageView.pageIndicatorTintColor = UIColor(displayP3Red: 249 / 255, green: 207 / 255, blue: 224 / 255, alpha: 0.9)
        pageView.currentPage = 0
        pageView.numberOfPages = pages.count
        pageView.translatesAutoresizingMaskIntoConstraints = false
        return pageView
    }()
    
    private func setupBottomControls(){
        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton,pageViewControl,nextButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlStackView)
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    @objc func handleNext(_ sender: UIButton){
        let nextIndex = min(pageViewControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageViewControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc func handlePrevious(_ sender: UIButton){
        let previousIndex = max(pageViewControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageViewControl.currentPage = previousIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.isPagingEnabled = true
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        setupBottomControls()
    }
    
}
