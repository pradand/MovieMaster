//
//  CastsCollectionViewCell+Delegates.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 05/01/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension CastsCollectionViewCell: ImageActivityIndicatorDelegate {
    internal func setupImageActivityIndicatorDelegate() {
        self.castCover.imageActivityIndicatorDelegate = self
    }
}
