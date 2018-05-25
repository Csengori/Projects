//
//  SwipeControllerExtensions.swift
//  AutoLoveLayot
//
//  Created by Tamas Sagi on 06/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

extension SwipeController{
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            if self.pageViewControl.currentPage == 0 {
                self.collectionView?.contentOffset = .zero
            }else {
                let indexPath = IndexPath(item: self.pageViewControl.currentPage, section: 0)
                self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }, completion: nil)
    }
}
