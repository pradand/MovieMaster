//
//  SearchViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

class SearchViewController: MoviesViewController, Identifiable {

    @IBOutlet weak var searchBar: UISearchBarX!
    @IBOutlet weak var displayInfoLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            super.moviesCollectionView = self.collectionView
        }
    }
    var activityIndicatorView: UIActivityIndicatorViewX?

    override func viewDidLoad() {
        setupActivityIndicatorDelegate()
        setupActivityIndicator()
        setupSearchBar()
        self.setupErrorViewDelegate()
        setupMovieSection()
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupSearchBarDisplayInfoDelegate()
        super.setupBaseNavigationBar(title: .search, titleColor: .red, tintColor: .red)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func setupErrorViewDelegate() {
        super.setupErrorViewDelegate()
        super.errorViewContainer.errorViewDelegate = self
        super.notificationCenterDelegate = self
    }

    private func setupMovieSection() {
        super.movieSection = .search
    }

    private func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorViewX(
            uiView: self.view,
            activityIndicatorColor: .red,
            activityIndicatorSize: .large
        )
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MovieDetailsViewController.segueIdentifier {
            guard let movieDetailsViewController = segue.destination as? MovieDetailsViewController else { return }

            if let movieSelected = self.movieSelected {
                movieDetailsViewModel.setMovie(movie: movieSelected)
                movieDetailsViewController.viewModel = movieDetailsViewModel
            }
        }
    }
}
