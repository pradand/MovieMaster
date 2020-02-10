//
//  MoviesRequestSpecs.swift
//  MovieMasterTests
//
//  Created by Andre & Bianca on 03/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import MovieMaster

class MoviesRequestSPecs: QuickSpec {

    override func spec() {
        super.spec()

        var homeViewController: HomeViewController!
        var nowPlayingViewController: NowPlayingViewController!
        var popularViewController: PopularViewController!
        var upComingViewController: UpComingViewController!
        var searchViewController: SearchViewController!

        beforeEach {
            homeViewController = HomeViewController()

            let nowPlayingStoryboard = UIStoryboard(name: Constants.StringIdentifier.Storyboard.nowPlaying, bundle: nil)
            nowPlayingViewController = nowPlayingStoryboard.instantiateViewController(withIdentifier: String(describing: NowPlayingViewController.self)) as? NowPlayingViewController

            let popularStoryboard = UIStoryboard(name: Constants.StringIdentifier.Storyboard.popular, bundle: nil)
            popularViewController = popularStoryboard.instantiateViewController(withIdentifier: String(describing: PopularViewController.self)) as? PopularViewController

            let upComingStoryboard = UIStoryboard(name: Constants.StringIdentifier.Storyboard.upComing, bundle: nil)
            upComingViewController = upComingStoryboard.instantiateViewController(withIdentifier: String(describing: UpComingViewController.self)) as? UpComingViewController

            let searchStoryboard = UIStoryboard(name: Constants.StringIdentifier.Storyboard.search, bundle: nil)
            searchViewController = searchStoryboard.instantiateViewController(withIdentifier: String(describing: SearchViewController.self)) as? SearchViewController
        }

        afterEach {
            homeViewController = nil
            nowPlayingViewController = nil
            popularViewController = nil
        }

        context("Test Movie Requests") {
            it("Should Home Now Playing Request be GreaterThan") {
                homeViewController.fetchMovies(endPoint: .nowPlaying)
                expect(homeViewController.viewModel.nowPlayingViewModel.getMoviesCount()).toEventually(beGreaterThan(0))
            }

            it("Should Home Popular Request be GreaterThan") {
                homeViewController.fetchMovies(endPoint: .popular)
                expect(homeViewController.viewModel.popularViewModel.getMoviesCount()).toEventually(beGreaterThan(0))
            }

            it("Should Home Up Coming Request be GreaterThan") {
                homeViewController.fetchMovies(endPoint: .upComing)
                expect(homeViewController.viewModel.upComingViewModel.getMoviesCount()).toEventually(beGreaterThan(0))
            }

            it("Should Now Playing Request be GreaterThan") {
                nowPlayingViewController.viewDidLoad()
                nowPlayingViewController.fetchMovies()
                expect(nowPlayingViewController.viewModel?.getMoviesCount()).toEventually(beGreaterThan(0))
            }

            it("Should Popular Request be GreaterThan") {
                popularViewController.viewDidLoad()
                popularViewController.fetchMovies()
                expect(popularViewController.viewModel?.getMoviesCount()).toEventually(beGreaterThan(0))
            }
            
            it("Should Up Coming Request be GreaterThan") {
                upComingViewController.viewDidLoad()
                upComingViewController.fetchMovies()
                expect(upComingViewController.viewModel?.getMoviesCount()).toEventually(beGreaterThan(0))
            }

            it("Should Search Request be GreaterThan") {
                let query = "Frozen II"
                searchViewController.viewDidLoad()
                searchViewController.fetchMovies(query: query)
                expect(searchViewController.viewModel?.getMoviesCount()).toEventually(beGreaterThan(0))
            }
        }
    }
}
