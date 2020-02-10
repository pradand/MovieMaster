//
//  MoviesViewController+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension MoviesViewController: MoviesViewModelDelegate {

    internal func setupViewModelDelegate() {
        self.viewModel?.moviesViewModelDelegate = self
    }

    internal func updateView() {
        self.moviesCollectionView?.reloadData()
    }

}

extension MoviesViewController: UIScrollViewDelegate {
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isDelegateSet {
            let offSetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let movieCurrentPage = viewModel?.getPagination().movieCurrentPage ?? 1
            let movieTotalPages = viewModel?.getPagination().movieTotalPages ?? 1

            if offSetY > contentHeight - scrollView.frame.size.height * Constants.leadingScreensForBatching {

                if (!fetchingMore && (movieCurrentPage + 1 <= movieTotalPages)) {
                    fetchMovies(page: movieCurrentPage + 1, query: searchString)
                }

            }
        }
    }

}

extension MoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieSelected = viewModel?.getMovie(indexPath.row) {
            if let delegate = moviesDelegate {
                delegate.didSelectItemAt(with: movieSelected)
            } else {
                self.movieSelected = movieSelected
                performSegue(withIdentifier: MovieDetailsViewController.segueIdentifier, sender: self)

            }
            
        }
    }

}

extension MoviesViewController: ErrorViewObserver {

    internal func setupErrorViewNotificationCenter() {
        notificationCenter?.addObserver(self, selector: #selector(self.retryOnError), name: .errorViewRetry, object: nil)
    }

    @objc func retryOnError() {
        fetchMovies(query: searchString)
    }

}

extension MoviesViewController: ErrorViewDelegate {

    @objc func setupErrorViewDelegate() {
        hideErrorViewContainer()
        guard moviesDelegate == nil else { return }
        errorViewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(errorViewContainer)
        errorViewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        errorViewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        errorViewContainer.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        errorViewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    func hideErrorViewContainer() {
        self.errorViewContainer.alpha = 0.0
    }

    func hideErrorViewContainer(withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.hideErrorViewContainer()
        }
    }

    func showErrorViewContainer() {
        UIView.animate(withDuration: 0.1) {
            self.errorViewContainer.alpha = 1.0
        }
    }

}
