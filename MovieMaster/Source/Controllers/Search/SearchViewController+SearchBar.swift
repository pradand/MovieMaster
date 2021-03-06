//
//  SearchViewController+SearchBar.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 30/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {

    internal func setupSearchBar() {
        searchBar.delegate = self
        displayInfoLabel.text = ""
    }

    //MARK: UISearchbar delegate
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("[LOG] User searching for ( \(String(describing: self.searchBar.text)) )")
        if let searchQuery = self.searchBar.text, !searchQuery.isEmpty {
            self.viewModel?.setMovies([])
            self.viewModel?.setMovieResult(nil)
            fetchMovies(query: searchQuery)
            super.searchString = searchQuery
        }
    }

}
