//
//  UpComingViewController+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 28/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension UpComingViewController: MoviesActivityIndicatorDelegate {
    internal func setupActivityIndicatorDelegate() {
        super.moviesActivityIndicatorDelegate = self
    }
}

extension UpComingViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        self.collectionView?.setContentOffset(CGPoint.zero, animated: true)
    }

    internal func setupTabBarControllerDelegate() {
        self.tabBarController?.delegate = self
    }
}
