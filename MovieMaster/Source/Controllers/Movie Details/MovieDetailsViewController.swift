//
//  MovieDetailsViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BaseViewController, Identifiable {

    @IBOutlet weak var backgroundCoverImage: CustomImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var coverImage: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: PaddingLabel!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var timeAndCategoryLabel: PaddingLabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    var viewModel: MovieDetailsViewModel?
    private var castViewModel: CastViewModel = CastViewModel()
    internal var activityIndicatorView: UIActivityIndicatorViewX?
    internal var imageActivityIndicatorView: UIActivityIndicatorViewX?
    internal var notificationCenter: NotificationCenter? = NotificationCenter.default
    internal weak var notificationCenterDelegate: UIViewController?
    internal var errorViewContainer: ErrorView = ErrorView()
    internal var errorViewModel: ErrorViewModel = ErrorViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        super.removeBackBarButtonItemText()
        setupErrorViewNotificationCenter()
        setupImageActivityIndicatorDelegate()
        setupMovieDetailsViewModelDelegate()
        setupActivityIndicatorDelegate()
        setupActivityIndicator()
        setupErrorViewDelegate()
        coverView.setLayerProperties(cornerRadius: 5, borderWidth: 1, borderColor: UIColor.white.cgColor)
        titleContainerView.setLayerProperties(cornerRadius: 3, borderWidth: nil, borderColor: nil)
        fetchMovieDetails(endPoint: .movie)
        self.view.layoutIfNeeded()
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        
    }

    internal func fillMovieDetails() {
        super.setupBaseNavigationBar(title: .text(description: viewModel?.getMovie()?.title) , titleColor: .red, tintColor: .red)
        coverImage.downloadFrom(
            stringURL: viewModel?.getMovie()?.posterPath ?? Constants.images.defaultImage,
            imageSize: .original
        )
        backgroundCoverImage.downloadFrom(
            stringURL: viewModel?.getMovie()?.backdropPath ?? Constants.images.defaultImage,
            imageSize: .original
        )
        titleLabel.text = viewModel?.getMovie()?.title
        yearLabel.allCornerRadius(size: 3)
        yearLabel.text = DateFormating.getYear(dateString: viewModel?.getMovie()?.releaseDate)
        timeAndCategoryLabel.text = viewModel?.getMovieDetails()?.timeAndCategory
        descriptionTextView.text = viewModel?.getMovie()?.overview
    }

    internal func setupActivityIndicator() {
        imageActivityIndicatorView = UIActivityIndicatorViewX(
            uiView: coverImage ?? CustomImageView(),
            activityIndicatorColor: .white,
            activityIndicatorSize: .medium
        )

        activityIndicatorView = UIActivityIndicatorViewX(
            uiView: self.view,
            activityIndicatorColor: .red,
            activityIndicatorSize: .large
        )
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CastViewController.segueIdentifier {
            guard let castViewController = segue.destination as? CastViewController else { return }
            if let movie = viewModel?.getMovie() {
                castViewModel.setMovie(movie: movie)
                castViewController.viewModel = castViewModel
            }
        }
    }

    internal func fetchMovieDetails(endPoint: Constants.MovieEndPoint) {
        guard let movieId = viewModel?.getMovie()?.id else { return }
        viewModel?.fetchMovieDetails(endPoint: endPoint, movieId: movieId, completion: { [weak self] (result) in
            guard let weakSelf = self else { return }
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    weakSelf.activityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer: true)
                    weakSelf.errorViewModel.setErrorText(String(describing: error.description))
                    weakSelf.errorViewContainer.errorViewModel = weakSelf.errorViewModel
                    weakSelf.showErrorViewContainer()
                }

            case .success(let movieResult):
                DispatchQueue.main.async {
                    weakSelf.viewModel?.setMovieDetails(movieDetail: movieResult)
                    weakSelf.activityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer: true)
                    weakSelf.hideErrorViewContainer(withDuration: 0.2)
                }

            }

        })

    }

    deinit {
        notificationCenter?.removeObserver(self)
    }

}
