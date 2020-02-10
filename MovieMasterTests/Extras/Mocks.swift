//
//  Mocks.swift
//  MovieMasterTests
//
//  Created by Andre & Bianca on 02/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation
@testable import MovieMaster

class Mocks {

//    var viewModel: MoviesViewModel?

    func getMovies() -> [Movie] {
        let movies: [Movie] = [
            Movie(
                id: 330457,
                title: "Frozen II",
                popularity: 326.113,
                overview: "Elsa, Anna, Kristoff and Olaf head far into the forest to learn the truth about an ancient mystery of their kingdom.",
                voteCount: 654,
                voteAverage: 7.1,
                posterPath: "/qdfARIhgpgZOBh3vfNhWS4hmSo3.jpg",
                originalLanguage: "en",
                originalTitle: "Frozen II",
                genreIds: [16, 10402, 10751, 12],
                backdropPath: "/xJWPZIYOEFIjZpBL7SVBGnzRYXp.jpg",
                releaseDate: "2019-11-20"
            )
        ]
        return movies
    }

    func getGenres() -> [Genre] {
        let genres: [Genre] = [
            Genre(id: 16, name: "Animation"),
            Genre(id: 10751, name: "Family"),
            Genre(id: 10402, name: "Music"),
            Genre(id: 12, name: "Adventure")
        ]
        return genres
    }

    func getCasts() -> [Cast] {
        let casts: [Cast] = [
            Cast(id: 40462, character: "Anna (voice)", creditId: "596a859992514136e7017277", name: "Kristen Bell", profilePath: "/9DoDVUkoXhT3O2R1RymPlOfUryl.jpg"),
            Cast(id: 19394, character: "Elsa (voice)", creditId: "596a858292514136e7017266", name: "Idina Menzel", profilePath: "/eGsyJmAZNV5tUU4RYy2DIRlFVpW.jpg")
        ]
        return casts
    }

    func getMovieDetail() -> MovieDetail {
        let movieDetail: MovieDetail = MovieDetail()
        movieDetail.runtime = 104
        movieDetail.genres = getGenres()
        return movieDetail
    }
}
