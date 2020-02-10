//
//  HomeViewController+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension HomeViewController: MoviesDelegate {
    func didSelectItemAt(with movie: Movie) {
        self.movieDetails = movie
        performSegue(withIdentifier: MovieDetailsViewController.segueIdentifier, sender: self)
    }
}

extension HomeViewController: MoviesActivityIndicatorDelegate {
    internal func setupActivityIndicatorDelegate() {
        viewModel.nowPlayingViewModel.moviesActivityIndicatorDelegate = self
        viewModel.popularViewModel.moviesActivityIndicatorDelegate = self
        viewModel.upComingViewModel.moviesActivityIndicatorDelegate = self
    }
}

extension HomeViewController: ErrorViewObserver {

    internal func setupErrorViewNotificationCenter() {
        notificationCenter?.addObserver(notificationCenterDelegate ?? self, selector: #selector(self.retryOnError), name: .errorViewRetry, object: nil)
    }

    @objc func retryOnError() {
        fetchMovies(endPoint: .nowPlaying)
        fetchMovies(endPoint: .popular)
        fetchMovies(endPoint: .upComing)
    }

}

extension HomeViewController: ErrorViewDelegate {
    func setupErrorViewDelegate() {
        errorViewContainer.errorViewDelegate = self
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
