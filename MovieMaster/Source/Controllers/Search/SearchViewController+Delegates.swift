//
//  SearchViewController+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 30/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

extension SearchViewController: SearchBarDisplayInfoDelegate {
    internal func setupSearchBarDisplayInfoDelegate() {
        super.viewModel?.searchBarDisplayInfoDelegate = self
    }

    func updateDisplayInfoLabel() {
        if self.isViewLoaded {
            displayInfoLabel.text = "Total Results: \(viewModel?.getMovieResult()?.totalResults ?? 0). Displaying: \(viewModel?.getMoviesCount() ?? 0)"
        }
    }
}

extension SearchViewController: MoviesActivityIndicatorDelegate {
    internal func setupActivityIndicatorDelegate() {
        super.moviesActivityIndicatorDelegate = self
    }
}
