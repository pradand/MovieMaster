//
//  UpComingViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 15/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

class UpComingViewController: MoviesViewController {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            super.moviesCollectionView = self.collectionView
        }
    }
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
        super.setupBaseNavigationBar(title: .upComing, titleColor: .red, tintColor: .red)
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

            if let movieSelected = self.movieSelected {
                movieDetailsViewModel.setMovie(movie: movieSelected)
                movieDetailsViewController.viewModel = movieDetailsViewModel
            }
        }
    }

    private func setupMovieSection() {
        super.movieSection = .upComing
    }

    private func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorViewX(
            uiView: self.view,
            activityIndicatorColor: .red,
            activityIndicatorSize: .large
        )
    }

}
