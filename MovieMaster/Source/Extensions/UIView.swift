//
//  UIView.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 01/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

extension UIView {

    func setLayerProperties(cornerRadius: CGFloat?, borderWidth: CGFloat?, borderColor: CGColor?) {
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }

        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth
        }

        if let borderColor = borderColor {
            layer.borderColor = borderColor
        }
    }

}
