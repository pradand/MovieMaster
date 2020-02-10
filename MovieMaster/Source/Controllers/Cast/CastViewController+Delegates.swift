//
//  CastViewController+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 05/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension CastViewController: CastViewModelDelegate {

    internal func setupCastViewModelDelegate() {
        viewModel?.castViewModelDelegate = self
    }

    public func updateView() {
        self.collectionView.reloadData()
    }

}

extension CastViewController: ErrorViewObserver {

    internal func setupErrorViewNotificationCenter() {
        notificationCenter?.addObserver(notificationCenterDelegate ?? self, selector: #selector(self.retryOnError), name: .errorViewRetry, object: nil)
    }

    @objc func retryOnError() {
        fetchCast(endPoint: .cast)
    }

}
