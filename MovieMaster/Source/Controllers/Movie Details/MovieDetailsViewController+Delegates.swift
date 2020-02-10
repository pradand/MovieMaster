//
//  MovieDetailsViewController+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 02/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension MovieDetailsViewController: MoviesActivityIndicatorDelegate {

    internal func setupActivityIndicatorDelegate() {
        self.viewModel?.moviesActivityIndicatorDelegate = self
    }

}

extension MovieDetailsViewController: ImageActivityIndicatorDelegate {
    internal func setupImageActivityIndicatorDelegate() {
        self.coverImage?.imageActivityIndicatorDelegate = self
    }
}

extension MovieDetailsViewController: MovieDetailsViewModelDelegate {

    internal func setupMovieDetailsViewModelDelegate() {
        viewModel?.movieDetailsViewModelDelegate = self
    }

    public func updateView() {
        fillMovieDetails()
    }

}

extension MovieDetailsViewController: ErrorViewObserver {

    internal func setupErrorViewNotificationCenter() {
        notificationCenter?.addObserver(notificationCenterDelegate ?? self, selector: #selector(self.retryOnError), name: .errorViewRetry, object: nil)
    }

    @objc func retryOnError() {
        print("MovieDetailsViewController Called thru observer")
        fetchMovieDetails(endPoint: .movie)
    }

}

extension MovieDetailsViewController: ErrorViewDelegate {

    @objc func setupErrorViewDelegate() {
        hideErrorViewContainer()
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
