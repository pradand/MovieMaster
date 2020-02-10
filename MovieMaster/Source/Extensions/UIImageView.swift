//
//  UIImageView.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

extension UIImageView {

    func allCornersRounded(width: Int = 5, height: Int = 5) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: UIRectCorner.allCorners,
            cornerRadii: CGSize(width: width, height: height)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        layer.masksToBounds = true
        self.clipsToBounds = true
    }

    func topCornersRounded(width: Int = 5, height: Int = 5){
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft , .topRight],
            cornerRadii: CGSize(width: width, height: height)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }

}
