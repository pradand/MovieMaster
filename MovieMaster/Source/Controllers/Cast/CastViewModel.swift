//
//  CastViewModel.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 05/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation

protocol CastViewModelDelegate: class {
    func updateView()
}

class CastViewModel {

    private var castCrew: DataCast?
    private var movie: Movie?
    weak var moviesActivityIndicatorDelegate: MoviesActivityIndicatorDelegate?
    weak var castViewModelDelegate: CastViewModelDelegate?
    typealias fetchCastClosure = (Result<DataCast, ErrorReturn>) -> ()

    func getAllCastCrew() -> DataCast? {
        return self.castCrew
    }

    func getCastCrew(by IndexPath: Int) -> Cast? {
        return self.castCrew?.cast[IndexPath]
    }

    func getCastCount() -> Int {
        return self.castCrew?.cast.count ?? 0
    }

    private func updateView() {
        self.castViewModelDelegate?.updateView()
    }

    func setCastCrew(cast: DataCast) {
        self.castCrew = cast
        updateView()
    }

    func setMovie(movie: Movie) {
        self.movie = movie
    }

    func getMovieId() -> Int? {
        return self.movie?.id
    }

    func fetchCast(endPoint: Constants.MovieEndPoint, movieId: Int, completion: @escaping (fetchCastClosure)) {
        moviesActivityIndicatorDelegate?.activityIndicatorView?.showActivityIndicator(withAdditionalOverLayer: true)
        MovieManager.sharedInstance().fetchData(of: DataCast.self, endPoint: endPoint, movieId: movieId) { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))

            case .success(let movieResult):
                completion(.success(movieResult))

            }
        }

    }

}
