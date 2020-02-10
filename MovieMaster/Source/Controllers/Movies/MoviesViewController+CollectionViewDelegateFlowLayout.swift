//
//  MoviesViewController+CollectionViewDelegateFlowLayout.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 15/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension MoviesViewController: UICollectionViewDelegateFlowLayout {

    internal func setCollectionViewHeight() {
        collectionViewHeight = view.frame.height
    }

    internal func getCollectionViewHeight() -> CGFloat {
        return collectionViewHeight ?? 130
    }

    private var insetForSections: UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }

    private var minimumInteritemSpacingForSectionAt: CGFloat {
        return 5
    }

    private var minimumLineSpacingForSectionAt: CGFloat {
        return 5
    }

    internal func collectionViewFlowDirection() {
        if let layout = moviesCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = isDelegateSet ? .horizontal : .vertical
            layout.sectionInsetReference = .fromSafeArea
        }

        moviesCollectionView?.showsHorizontalScrollIndicator = isDelegateSet ? true : false
        moviesCollectionView?.showsVerticalScrollIndicator = isDelegateSet ? false : true

        moviesCollectionView?.alwaysBounceHorizontal = isDelegateSet ? true : false
        moviesCollectionView?.alwaysBounceVertical = isDelegateSet ? false : true
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let numberOfItems: CGFloat = UIScreen.main.isLandscape ? 5 : 3
        let aspectRatio: CGFloat = 1.9
        let insets = (insetForSections.top + insetForSections.bottom + minimumLineSpacingForSectionAt + minimumInteritemSpacingForSectionAt)
        let width = isDelegateSet ? (getCollectionViewHeight() - insets) / aspectRatio : collectionView.frame.width/numberOfItems - 10
        let height = isDelegateSet ? (getCollectionViewHeight() - insets) : width * aspectRatio
        let cellSize = CGSize(width: width, height: height)

        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInteritemSpacingForSectionAt
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacingForSectionAt
    }
}
