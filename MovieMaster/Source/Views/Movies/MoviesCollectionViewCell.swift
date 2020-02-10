//
//  MoviesCollectionViewCell.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var coverImage: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var movieCover: Movie? {
        didSet {
            if let movie = movieCover {
                setupMovie(movie)
            }
        }
    }
    var imageActivityIndicatorView: UIActivityIndicatorViewX?

    // MARK: - CollectionView Cell Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageActivityIndicatorDelegate()
        setupActivityIndicator()
        self.coverImage.image = nil
        self.coverImage.allCornersRounded()
    }

    internal func setupMovie(_ data: Movie) {
        coverImage.downloadFrom(stringURL: data.posterPath ?? Constants.images.defaultImage)
        self.titleLabel.text = data.title
        self.ratingLabel.setRatingBadge(data.voteAverage ?? 0.0)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.coverImage.image = UIImage()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.coverImage.allCornersRounded()
    }

    private func setupActivityIndicator() {
        imageActivityIndicatorView = UIActivityIndicatorViewX(
            uiView: self.coverImage,
            activityIndicatorColor: .white,
            activityIndicatorSize: .medium
        )
    }

}
