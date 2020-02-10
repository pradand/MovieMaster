//
//  MovieDetailsViewSpecs.swift
//  MovieMasterTests
//
//  Created by Andre & Bianca on 09/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import MovieMaster

class MovieDetailsViewSpecs: QuickSpec {

    override func spec() {
        super.spec()

        var movieDetailsViewController: MovieDetailsViewController!

        beforeEach {
            let movieDetailsStoryboard = UIStoryboard(name: Constants.StringIdentifier.Storyboard.movieDetails, bundle: nil)
            movieDetailsViewController = movieDetailsStoryboard.instantiateViewController(withIdentifier: String(describing: MovieDetailsViewController.self)) as? MovieDetailsViewController
        }

        afterEach {
            movieDetailsViewController = nil
        }

        context("Verify Setup Properties") {

            it("Should MovieDetailsViewController IBOutlets not be nil") {
                movieDetailsViewController.viewDidLoad()
                expect(movieDetailsViewController.backgroundCoverImage).toNot(beNil())
                expect(movieDetailsViewController.coverView).toNot(beNil())
                expect(movieDetailsViewController.coverImage).toNot(beNil())
                expect(movieDetailsViewController.titleLabel).toNot(beNil())
                expect(movieDetailsViewController.yearLabel).toNot(beNil())
                expect(movieDetailsViewController.titleContainerView).toNot(beNil())
                expect(movieDetailsViewController.timeAndCategoryLabel).toNot(beNil())
                expect(movieDetailsViewController.descriptionTextView).toNot(beNil())
            }

        }
    }
}
