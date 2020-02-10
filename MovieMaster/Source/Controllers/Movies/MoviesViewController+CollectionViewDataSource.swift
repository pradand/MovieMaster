//
//  MoviesViewController+CollectionViewDataSource.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension MoviesViewController: UICollectionViewDataSource {

    internal func setupCollectionView() {
        moviesCollectionView?.delegate = self
        moviesCollectionView?.dataSource = self
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        moviesCollectionView?.collectionViewLayout.invalidateLayout()
    }

    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getMoviesCount() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.StringIdentifier.CollectionViewCell.cell, for: indexPath) as? MoviesCollectionViewCell, let movies = viewModel?.getMovies() {
            cell.movieCover = movies[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }

}
