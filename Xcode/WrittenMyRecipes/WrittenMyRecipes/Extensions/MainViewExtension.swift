//
//  MainViewExtension.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 12/06/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import Foundation
import  UIKit

extension FeedViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
        }, completion: nil)
    }
}
