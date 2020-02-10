//
//  NowPlayingViewController+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 28/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension NowPlayingViewController: MoviesActivityIndicatorDelegate {
    internal func setupActivityIndicatorDelegate() {
        super.moviesActivityIndicatorDelegate = self
    }
}

extension NowPlayingViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        setCollectionViewContentOffsetToZero()
    }
    
    internal func setupTabBarControllerDelegate() {
        self.tabBarController?.delegate = self
    }
}

extension NowPlayingViewController: CollectionViewContentOffsetDelegate {
    func setCollectionViewContentOffsetToZero() {
        self.collectionView?.setContentOffset(CGPoint.zero, animated: true)
    }
}
