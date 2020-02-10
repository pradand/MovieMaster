//
//  HomeViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit
class HomeViewController: BaseViewController, Identifiable {

    @IBOutlet weak var scrollView: UIScrollView!
    
    internal let movieDetailsViewModel = MovieDetailsViewModel()
    internal var viewModel = HomeViewModel()
    internal var movieDetails: Movie?
    internal var refreshControl = UIRefreshControl()
    internal var activityIndicatorView: UIActivityIndicatorViewX?
    internal var errorViewContainer: ErrorView = ErrorView()
    internal var errorViewModel: ErrorViewModel = ErrorViewModel()
    internal var notificationCenter: NotificationCenter? = NotificationCenter.default
    internal weak var notificationCenterDelegate: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupErrorViewDelegate()
        setupErrorViewNotificationCenter()
        setupActivityIndicatorDelegate()
        setupActivityIndicator()
        setupRefreshControl()
        fetchMovies(endPoint: .nowPlaying)
        fetchMovies(endPoint: .popular)
        fetchMovies(endPoint: .upComing)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.setupBaseNavigationBar(title: .home, titleColor: .red, tintColor: .red)
    }

    @IBAction func showMore(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = sender.tag
    }

    private func setupActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorViewX(uiView: self.view)
    }

    internal func fetchMovies(endPoint: Constants.MovieEndPoint, page: Int = 1) {
        viewModel.fetchMovies(endPoint: endPoint, page: page) { [weak self] (result) in
            guard let weakSelf = self else { return }

            DispatchQueue.main.async {
                weakSelf.activityIndicatorView?.showActivityIndicator(withAdditionalOverLayer: true)
            }

            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    weakSelf.activityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer: true)
                    weakSelf.finishedRefreshing()
                    weakSelf.errorViewModel.setErrorText(String(describing: error.description))
                    weakSelf.errorViewContainer.errorViewModel = weakSelf.errorViewModel
                    weakSelf.showErrorViewContainer()
                }

            case .success(let movieResult):

                DispatchQueue.main.async {

                    if endPoint == .nowPlaying {
                        weakSelf.viewModel.nowPlayingViewModel.setMovieResult(movieResult)
                        weakSelf.viewModel.nowPlayingViewModel.setMovies(movieResult.results)
                    } else if endPoint == .popular {
                        weakSelf.viewModel.popularViewModel.setMovieResult(movieResult)
                        weakSelf.viewModel.popularViewModel.setMovies(movieResult.results)
                    } else if endPoint == .upComing {
                        weakSelf.viewModel.upComingViewModel.setMovieResult(movieResult)
                        weakSelf.viewModel.upComingViewModel.setMovies(movieResult.results)
                    }

                    weakSelf.finishedRefreshing()
                    weakSelf.hideErrorViewContainer(withDuration: 0.1)
                    weakSelf.activityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer: true)
                }

            }

        }

    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == NowPlayingViewController.segueIdentifier {
            guard let nowPlayingViewController = segue.destination as? NowPlayingViewController else { return }
            nowPlayingViewController.moviesDelegate = self
            nowPlayingViewController.viewModel = viewModel.nowPlayingViewModel
        } else if segue.identifier == PopularViewController.segueIdentifier {
            guard let popularViewController = segue.destination as? MoviesViewController else { return }
            popularViewController.moviesDelegate = self
            popularViewController.viewModel = viewModel.popularViewModel
        } else if segue.identifier == UpComingViewController.segueIdentifier {
            guard let upComingViewController = segue.destination as? MoviesViewController else { return }
            upComingViewController.moviesDelegate = self
            upComingViewController.viewModel = viewModel.upComingViewModel
        } else if segue.identifier == MovieDetailsViewController.segueIdentifier {
            guard let movieDetailsViewController = segue.destination as? MovieDetailsViewController else { return }
            if let movieDetails = self.movieDetails {
                movieDetailsViewModel.setMovie(movie: movieDetails)
                movieDetailsViewController.viewModel = movieDetailsViewModel
            }
        }
    }

    deinit {
        notificationCenter?.removeObserver(self)
    }
}
