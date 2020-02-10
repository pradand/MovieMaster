//
//  MovieDetailsSpecs.swift
//  MovieMasterTests
//
//  Created by Andre & Bianca on 09/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import MovieMaster

class MovieDetailsSpecs: QuickSpec {

    override func spec() {
        super.spec()

        var sut = MovieDetailsViewModel()

        beforeEach {
            let mocks = Mocks()
            sut.setMovieDetails(movieDetail: mocks.getMovieDetail())
        }

        afterEach {
            sut = MovieDetailsViewModel()
        }

        context("Test Movie Detail") {
            it("Should runtime be equal") {
                expect(sut.getMovieDetails()?.runtime).to(equal(104))
            }

            it("Should Genre be GreaterThan") {
                expect(sut.getMovieDetails()?.genres.count).to(beGreaterThan(0))
            }
        }
    }
}

