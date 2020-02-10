//
//  MovieDetailsViewModel.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 28/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

protocol MovieDetailsViewModelDelegate: class {
    func updateView()
}

class MovieDetailsViewModel {

    private var movie: Movie?
    private var movieDetail: MovieDetail?
    private var genres: [Genre]?
    private var genresDescriptions: String?
    typealias fetchMoviesClosure = (Result<MovieDetail, ErrorReturn>) -> ()

    weak var moviesActivityIndicatorDelegate: MoviesActivityIndicatorDelegate?
    weak var movieDetailsViewModelDelegate: MovieDetailsViewModelDelegate?

    func setMovie(movie: Movie) {
        self.movie = movie
    }

    func getMovie() -> Movie? {
        return movie
    }

    func setMovieDetails(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        updateView()
    }

    func getMovieDetails() -> MovieDetail? {
        return movieDetail
    }

    private func updateView() {
        self.movieDetailsViewModelDelegate?.updateView()
    }

    func fetchMovieDetails(endPoint: Constants.MovieEndPoint, movieId: Int, completion: @escaping (fetchMoviesClosure)) {
        moviesActivityIndicatorDelegate?.activityIndicatorView?.showActivityIndicator(withAdditionalOverLayer: true)
        MovieManager.sharedInstance().fetchData(of: MovieDetail.self, endPoint: endPoint, movieId: movieId) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let movieResult):
                completion(.success(movieResult))

            }

        }
    }

}
