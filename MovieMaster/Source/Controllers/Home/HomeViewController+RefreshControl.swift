//
//  HomeViewController+RefreshControl.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension HomeViewController {

    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            scrollView.refreshControl = refreshControl
        } else {
            scrollView.addSubview(refreshControl)
        }
        self.refreshControl.tintColor = UIColor.red
        self.refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
    }

    @objc private func refreshTableView(_ sender: Any) {
        // getting a random page for the pull to refresh to bring different movies
        if let nowPlayingTotalPages = viewModel.nowPlayingViewModel.getTotalPages() {
            fetchMovies(endPoint: .nowPlaying, page: Int.random(in: 1 ... nowPlayingTotalPages))
        }
        
        if let popularTotalPages = viewModel.popularViewModel.getTotalPages() {
            fetchMovies(endPoint: .popular, page: Int.random(in: 1 ... popularTotalPages))
        }
        
        if let upComingTotalPages = viewModel.upComingViewModel.getTotalPages() {
            fetchMovies(endPoint: .upComing, page: Int.random(in: 1 ... upComingTotalPages))
        }
        
    }
    
    @objc func finishedRefreshing() {
        refreshControl.endRefreshing()
    }
    
}
