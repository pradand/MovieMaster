//
//  BaseViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 26/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Internal Methods
    func setupBaseNavigationBar(
        title: Constants.MovieSection? = nil,
        titleColor: UIColor = UIColor.orange,
        tintColor: UIColor = UIColor.orange,
        barStyle: UIBarStyle = .default,
        barColor: UIColor? = nil,
        isLargeTitle: Bool = false
    ) {

        guard let navigationController = self.navigationController else { return }

        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: titleColor]
        navigationController.navigationBar.tintColor = tintColor
        navigationController.navigationBar.barStyle = barStyle
        navigationController.navigationBar.barTintColor = barColor
        navigationController.navigationBar.prefersLargeTitles = isLargeTitle
        navigationController.navigationItem.largeTitleDisplayMode = .never
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor: titleColor]

        if let title = title {
            self.navigationItem.title = title.rawValue
        }
    }

    func registerNib(_ collectionView: UICollectionView?, _ collectionViewCellName: String?) {
        if let cvCellName = collectionViewCellName {
            let nibName = UINib(nibName: cvCellName, bundle: nil)
            if let cv = collectionView {
                cv.register(nibName, forCellWithReuseIdentifier: Constants.StringIdentifier.CollectionViewCell.cell)
            } else {
                self.showAlertView(title: MessagesUtils.General.oops, message: MessagesUtils.General.somethingWentWrong)
            }
        }
    }

}
