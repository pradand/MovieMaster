//
//  MoviesSpecs.swift
//  MovieMasterTests
//
//  Created by Andre & Bianca on 02/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import MovieMaster

class MoviesSpecs: QuickSpec {

    override func spec() {
        super.spec()

        var sut = MoviesViewModel()

        beforeEach {
            let mocks = Mocks()
            sut.setMovies(mocks.getMovies())
        }

        afterEach {
            sut = MoviesViewModel()
        }

        context("Test Movie") {
            it("Should Title be equal") {
                expect(sut.getMovies()?.first?.title).to(equal("Frozen II"))
            }

            it("Should Vote Average be equal") {
                expect(sut.getMovies()?.first?.voteAverage).to(equal(7.1))
            }

            it("Should Release Date be equal") {
                expect(sut.getMovies()?.first?.releaseDate).to(equal("2019-11-20"))
            }
        }
    }
}

