//
//  UIScreen.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 15/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension UIScreen {
    var isLandscape: Bool {
        return self.bounds.width > self.bounds.height
    }
}
