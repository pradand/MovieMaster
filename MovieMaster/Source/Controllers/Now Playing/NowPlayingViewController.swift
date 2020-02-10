//
//  NowPlayingViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 14/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

class NowPlayingViewController: MoviesViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            super.moviesCollectionView = self.collectionView
        }
    }
    @IBOutlet weak var errorView: ErrorView!
    var activityIndicatorView: UIActivityIndicatorViewX?

    override func viewDidLoad() {
        setupActivityIndicatorDelegate()
        setupActivityIndicator()
        self.setupErrorViewDelegate()
        setupMovieSection()
        super.viewDidLoad()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupTabBarControllerDelegate()
        super.setupBaseNavigationBar(title: .nowPlaying, titleColor: .red, tintColor: .red)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }

    override func setupErrorViewDelegate() {
        super.setupErrorViewDelegate()
        super.errorViewContainer.errorViewDelegate = self
        super.notificationCenterDelegate = self
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MovieDetailsViewController.segueIdentifier {
            guard let movieDetailsViewController = segue.destination as? MovieDetailsViewController else { return }
            if let movieSelected = super.movieSelected {
                movieDetailsViewModel.setMovie(movie: movieSelected)
                movieDetailsViewController.viewModel = movieDetailsViewModel
            }
        }
    }

    private func setupMovieSection() {
        super.movieSection = .nowPlaying
    }

    private func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorViewX(
            uiView: self.view,
            activityIndicatorColor: .red,
            activityIndicatorSize: .large
        )
    }

}
