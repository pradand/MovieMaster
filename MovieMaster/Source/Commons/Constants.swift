//
//  Constants.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

struct Constants {

    static let apiURLBase                       = "https://api.themoviedb.org/3/"
    static let movieIdPlaceHolder               = "<movieid>"
    static let movieEndPoint                    = "movie/\(Constants.movieIdPlaceHolder)?"
    static let castEndPoint                     = "movie/\(Constants.movieIdPlaceHolder)/credits?"
    static let nowPlayingEndPoint               = "movie/now_playing?"
    static let popularEndPoint                  = "movie/popular?"
    static let upComingEndPoint                 = "movie/upcoming?"
    static let searchEndPoint                   = "search/movie?"
    static let apiToken                         = "1f54bd990f1cdfb230adb312546d765d"
    static let apiURLImageSmallSize             = "https://image.tmdb.org/t/p/w185"
    static let apiURLImageMediumSize            = "https://image.tmdb.org/t/p/w500"
    static let apiURLImageOriginalSize          = "https://image.tmdb.org/t/p/original"
    // Constant for the list pagination
    static let leadingScreensForBatching: CGFloat = 2.0

    struct images {
        static let splash = "Splash"
        static let defaultImage = "Popcorn"
        static let detaultImageSize512 = "Popcorn@512x"
    }

    struct StringIdentifier {
        struct CollectionViewCell {
            static let castsCollectionViewCell = "CastsCollectionViewCell"
            static let moviesCollectionViewCell = "MoviesCollectionViewCell"
            static let cell = "Cell"
        }

        struct Storyboard {
            static let home = "Home"
            static let nowPlaying = "NowPlaying"
            static let popular = "Popular"
            static let upComing = "UpComing"
            static let search = "Search"
            static let movieDetails = "MovieDetails"
        }

    }

    enum Notification {
        case errorViewRetry

        var rawValue: String {
            switch self {
            case .errorViewRetry:
                return "ErrorView.Retry"
            }
        }
    }

    enum MovieSection {
        case home
        case nowPlaying
        case popular
        case upComing
        case search
        case details
        case text(description: String?)

        var rawValue: String {
            switch self {
            case .home:
                return "Home"
            case .nowPlaying:
                return "Now Playing"
            case .popular:
                return "Popular"
            case .upComing:
                return "Up Coming"
            case .search:
                return "Search"
            case .details:
                return "Details"
            case .text(let description):
                return description ?? "none"
            }
        }
    }

    enum MovieEndPoint {
        case nowPlaying
        case popular
        case upComing
        case search
        case movie
        case cast

        var URL: String {
            switch self {
            case .nowPlaying:
                return Constants.nowPlayingEndPoint
            case .popular:
                return Constants.popularEndPoint
            case .upComing:
                return Constants.upComingEndPoint
            case .search:
                return Constants.searchEndPoint
            case .movie:
                return Constants.movieEndPoint
            case .cast:
                return Constants.castEndPoint
            }
        }

    }

}
