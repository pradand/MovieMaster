//
//  CastViewController.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 05/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class CastViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    internal var isDelegateSet: Bool = false
    internal var collectionViewHeight: CGFloat?
    internal var notificationCenter: NotificationCenter? = NotificationCenter.default
    internal weak var notificationCenterDelegate: UIViewController?
    var viewModel: CastViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupErrorViewNotificationCenter()
        setupCollectionView()
        setupCastViewModelDelegate()
        super.registerNib(collectionView, Constants.StringIdentifier.CollectionViewCell.castsCollectionViewCell)
        fetchCast(endPoint: .cast)
    }

    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCollectionViewHeight()
        collectionViewFlowDirection()
    }

    override func viewWillAppear(_ animated: Bool) {
        if viewModel != nil {
            updateView()
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionViewFlowDirection()
        updateView()
    }

    internal func fetchCast(endPoint: Constants.MovieEndPoint) {
        guard let movieId = viewModel?.getMovieId() else { return }
        viewModel?.fetchCast(endPoint: endPoint, movieId: movieId, completion: { [weak self] (result) in
            guard let weakSelf = self else { return }

            switch result {
            case .failure(let error):
                guard error != .networkTimeOut else { return }
                DispatchQueue.main.async {
                    weakSelf.showAlertView(title: MessagesUtils.General.oops, message: String(describing: error.description))
                }

            case .success(let castResult):
                DispatchQueue.main.async {
                    weakSelf.viewModel?.setCastCrew(cast: castResult)
                }

            }
        })

    }

    deinit {
        notificationCenter?.removeObserver(self)
    }

}
