//
//  MoviesViewController+Protocols.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 28/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

protocol MoviesActivityIndicatorDelegate: class {
    var activityIndicatorView: UIActivityIndicatorViewX? { get set }
    func setupActivityIndicatorDelegate()
}

protocol ImageActivityIndicatorDelegate: class {
    var imageActivityIndicatorView: UIActivityIndicatorViewX? { get set }
    func setupImageActivityIndicatorDelegate()
}

protocol MoviesDelegate: class {
    func didSelectItemAt(with movie: Movie)
}

protocol CollectionViewContentOffsetDelegate {
    func setCollectionViewContentOffsetToZero()
}

protocol MoviesSectionProtocol: class {
    var movieSection: Constants.MovieSection? { get set }
}
