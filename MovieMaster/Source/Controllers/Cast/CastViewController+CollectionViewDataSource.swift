//
//  CastViewController+CollectionViewDataSource.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 05/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension CastViewController: UICollectionViewDataSource {

    internal func setupCollectionView() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }

    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getCastCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.StringIdentifier.CollectionViewCell.cell, for: indexPath) as? CastsCollectionViewCell, let castCrew = viewModel?.getAllCastCrew() {
            cell.cast = castCrew.cast[indexPath.row]
            return cell
        }

        return UICollectionViewCell()
    }

}
