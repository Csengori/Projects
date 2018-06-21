//
//  AppDelegate.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 23/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        setupTabbar()
        
        return true
    }
    
    func setupTabbar(){
        let tabBarController  = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .white
        
        let navigationController = UINavigationController(rootViewController: FeedViewController(collectionViewLayout: setupCollectionView()))
        let tempVC = TempVC()
        
        let shoppingListViewController = ShoppingListTableViewController()
        
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        tempVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        shoppingListViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 3)
        
        let viewControllers = [navigationController,tempVC,shoppingListViewController]
        tabBarController.viewControllers = viewControllers
        
        window?.rootViewController = tabBarController
    }
    
    func setupCollectionView() -> UICollectionViewLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 16
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.scrollDirection = .vertical
        return collectionViewLayout
    }
    
}

