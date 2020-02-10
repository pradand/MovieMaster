//
//  MoviesViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

class MoviesViewController: BaseViewController {

    public weak var moviesCollectionView: UICollectionView?
    public weak var moviesDelegate: MoviesDelegate? {didSet {self.isDelegateSet = true}}
    public weak var moviesActivityIndicatorDelegate: MoviesActivityIndicatorDelegate?

    public var viewModel: MoviesViewModel? {didSet {setupViewModelDelegate();isViewModelSet = true}}
    public var movieSection: Constants.MovieSection?

    internal let movieDetailsViewModel = MovieDetailsViewModel()
    internal var movieEndPoint: Constants.MovieEndPoint?
    internal var isLandscape: Bool = false
    internal var isDelegateSet: Bool = false
    internal var movieSelected: Movie?
    internal var fetchingMore = false
    internal var searchString: String = ""
    internal var collectionViewHeight: CGFloat?
    internal var errorViewContainer: ErrorView = ErrorView()
    internal var errorViewModel: ErrorViewModel = ErrorViewModel()
    internal var notificationCenter: NotificationCenter?
    internal weak var notificationCenterDelegate: UIViewController?
    private var isViewModelSet: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupErrorViewDelegate()
        setupErrorViewNotificationCenter()
        initViewModel()
        initEndPoint()
        fetchMovies()
        setupCollectionView()
        super.registerNib(moviesCollectionView, Constants.StringIdentifier.CollectionViewCell.moviesCollectionViewCell)
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        determineMyDeviceOrientation()
        setCollectionViewHeight()
        collectionViewFlowDirection()
    }

    override func viewWillAppear(_ animated: Bool) {
        determineMyDeviceOrientation()
        if viewModel != nil {
            updateView()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewFlowDirection()
        determineMyDeviceOrientation()
        updateView()
    }

    func determineMyDeviceOrientation() {
        isLandscape = UIScreen.main.isLandscape ? true : false
    }

    private func initViewModel() {
        if !isViewModelSet {
            switch movieSection {
            case .nowPlaying:
                viewModel = NowPlayingViewModel()
            case .popular:
                viewModel = PopularViewModel()
            case .upComing:
                viewModel = UpComingViewModel()
            case .search:
                viewModel = SearchViewModel()
            default:
                viewModel = NowPlayingViewModel()
            }
        }
    }

    internal func initEndPoint() {
        switch movieSection {
        case .nowPlaying:
            movieEndPoint = .nowPlaying
        case .popular:
            movieEndPoint = .popular
        case .upComing:
            movieEndPoint = .upComing
        case .search:
            movieEndPoint = .search
        default:
            movieEndPoint = .nowPlaying
        }
    }

    internal func fetchMovies(page: Int = 1, query: String? = nil) {

        guard isViewModelSet else { return }
        guard let movieSection = movieSection else { return }
        guard let movieEndPoint = movieEndPoint else { return }

        if movieSection.rawValue == Constants.MovieSection.search.rawValue { if query == nil { return } }
        moviesActivityIndicatorDelegate?.activityIndicatorView?.showActivityIndicator()

        fetchingMore = true
        viewModel?.fetchMovies(endPoint: movieEndPoint, page: page, query: query) { [weak self] (result) in
            guard let weakSelf = self else {
                DispatchQueue.main.async {
                    self?.moviesActivityIndicatorDelegate?.activityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer:false)
                }
                return
            }

            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    weakSelf.moviesActivityIndicatorDelegate?.activityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer: false)
                    weakSelf.errorViewModel.setErrorText(String(describing: error.description))
                    weakSelf.errorViewContainer.errorViewModel = weakSelf.errorViewModel
                    weakSelf.showErrorViewContainer()
                }

            case .success(let data):
                DispatchQueue.main.async {
                    weakSelf.viewModel?.setMovieResult(data)
                    weakSelf.viewModel?.getMoviesCount() ?? 0 == 0 ? weakSelf.viewModel?.setMovies(data.results) : weakSelf.viewModel?.updateMovies(data.results)
                    weakSelf.viewModel?.setPagination(data)
                    weakSelf.fetchingMore = false
                    weakSelf.hideErrorViewContainer(withDuration: 0.2)
                    weakSelf.moviesActivityIndicatorDelegate?.activityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer: false)
                }
            }

        }

    }

    deinit {
        notificationCenter?.removeObserver(notificationCenterDelegate ?? self)
    }
}
