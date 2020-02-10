//
//  CastsCollectionViewCell.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 01/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

class CastsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castCover: CustomImageView!
    @IBOutlet weak var characterLabel: PaddingLabel!
    @IBOutlet weak var nameLabel: PaddingLabel!

    internal var imageActivityIndicatorView: UIActivityIndicatorViewX?
    internal let imageCover = CustomImageView()
    var cast: Cast? {
        didSet {
            setupCast()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageActivityIndicatorDelegate()
        setupActivityIndicator()
        castCover.image = nil
        castCover.allCornersRounded()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.castCover.image = UIImage()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.castCover.allCornersRounded()
    }

    private func setupActivityIndicator() {
        imageActivityIndicatorView = UIActivityIndicatorViewX(
            uiView: self.castCover,
            activityIndicatorColor: .white,
            activityIndicatorSize: .medium
        )
    }

    private func setupCast() {
        castCover.downloadFrom(stringURL: cast?.profilePath ?? Constants.images.defaultImage)
        characterLabel.text = cast?.character
        nameLabel.text = cast?.name
    }

}
