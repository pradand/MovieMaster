//
//  MoviesViewModel.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 28/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

protocol MoviesViewModelDelegate: class {
    func updateView()
}

struct MoviePagination {
    var movieCurrentPage: Int?
    var movieTotalPages: Int?
}

class MoviesViewModel {

    private var movieResult: MovieResult?
    private var movies: [Movie]?
    private var pagination = MoviePagination()
    typealias fetchMoviesClosure = (Result<MovieResult, ErrorReturn>) -> ()

    weak var moviesActivityIndicatorDelegate: MoviesActivityIndicatorDelegate?
    weak var moviesViewModelDelegate: MoviesViewModelDelegate?
    weak var searchBarDisplayInfoDelegate: SearchBarDisplayInfoDelegate?

    func fetchMovies(endPoint: Constants.MovieEndPoint, page: Int = 1, query: String? = nil, completion: @escaping (fetchMoviesClosure)) {
        moviesActivityIndicatorDelegate?.activityIndicatorView?.showActivityIndicator()
        MovieManager.sharedInstance().fetchData(of: MovieResult.self, endPoint: endPoint, page: page, query: query) { (result) in
            switch result {
                case .failure(let error):
                    completion(.failure(error))

                case .success(let movieResult):
                    completion(.success(movieResult))
            }
        }
    }

    private func updateView() {
        self.moviesViewModelDelegate?.updateView()
    }

    private func updateDisplayInfoLabel() {
        self.searchBarDisplayInfoDelegate?.updateDisplayInfoLabel()
    }

    func getMovies() -> [Movie]? {
        return movies
    }
    
    func getMovie(_ index: Int) -> Movie? {
        return movies?[index]
    }

    func getMovieResult() -> MovieResult? {
        return movieResult
    }
    
    func getTotalPages() -> Int? {
        return movieResult?.totalPages
    }
    
    func getMoviesCount() -> Int? {
        return movies?.count
    }

    func setMovies(_ movies: [Movie]) {
        self.movies = movies
        updateView()
        updateDisplayInfoLabel()
    }

    func updateMovies(_ movies: [Movie]) {
        self.movies?.append(contentsOf: movies)
        updateView()
        updateDisplayInfoLabel()
    }

    func setMovieResult(_ movieResult: MovieResult?) {
        self.movieResult = movieResult
        updateView()
        updateDisplayInfoLabel()
    }

    func setPagination(_ data: MovieResult) {
        pagination.movieCurrentPage = data.page ?? 1
        pagination.movieTotalPages = data.totalPages ?? 1
    }

    func getPagination() -> MoviePagination {
        return pagination
    }

}
