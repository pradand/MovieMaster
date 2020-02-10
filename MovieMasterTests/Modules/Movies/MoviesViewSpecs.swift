//
//  MoviesViewSpecs.swift
//  MovieMasterTests
//
//  Created by Andre & Bianca on 02/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import MovieMaster

class MoviesViewSpecs: QuickSpec {

    override func spec() {
        super.spec()

        var homeViewController: HomeViewController!
        var nowPlayingViewController: NowPlayingViewController!
        var popularViewController: PopularViewController!
        var upComingViewController: UpComingViewController!
        var searchViewController: SearchViewController!

        beforeEach {
            let homeStoryboard = UIStoryboard(name: Constants.StringIdentifier.Storyboard.home, bundle: nil)
            homeViewController = homeStoryboard.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController

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
            upComingViewController = nil
            searchViewController = nil
        }

        context("Verify Setup Properties") {

            it("Should HomeViewController IBOutlets not be nil") {
                homeViewController.viewDidLoad()
                expect(homeViewController.scrollView).toNot(beNil())
            }

            it("Should NowPlayingViewController IBOutlets not be nil") {
                nowPlayingViewController.viewDidLoad()
                expect(nowPlayingViewController.collectionView).toNot(beNil())
            }

            it("Should PopularViewController IBOutlets not be nil") {
                popularViewController.viewDidLoad()
                expect(popularViewController.collectionView).toNot(beNil())
            }

            it("Should UpComingViewController IBOutlets not be nil") {
                upComingViewController.viewDidLoad()
                expect(upComingViewController.collectionView).toNot(beNil())
            }

            it("Should SearchViewController IBOutlets not be nil") {
                searchViewController.viewDidLoad()
                expect(searchViewController.collectionView).toNot(beNil())
                expect(searchViewController.searchBar).toNot(beNil())
                expect(searchViewController.displayInfoLabel).toNot(beNil())
            }

        }
    }
}
