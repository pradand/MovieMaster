//
//  CastViewController+CollectionViewDelegateFlowLayout.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 05/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension CastViewController: UICollectionViewDelegateFlowLayout {

    internal func setCollectionViewHeight() {
        collectionViewHeight = view.frame.height
    }

    internal func getCollectionViewHeight() -> CGFloat? {
        return collectionViewHeight
    }

    private var insetForSections: UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 0.0, bottom: 5.0, right: 0.0)
    }

    private var minimumInteritemSpacingForSectionAt: CGFloat {
        return 5
    }

    private var minimumLineSpacingForSectionAt: CGFloat {
        return 5
    }

    internal func collectionViewFlowDirection() {
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.sectionInsetReference = .fromSafeArea
        }

        collectionView?.showsHorizontalScrollIndicator = true
        collectionView?.showsVerticalScrollIndicator = false

        collectionView?.alwaysBounceHorizontal = true
        collectionView?.alwaysBounceVertical = false
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insetForSections
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let aspectRatio: CGFloat = 1.5
        let height = ((getCollectionViewHeight() ?? 180) - (insetForSections.top + insetForSections.bottom + minimumInteritemSpacingForSectionAt + minimumLineSpacingForSectionAt))
        let width = height / aspectRatio
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

