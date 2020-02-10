//
//  UIActivityIndicatorViewX.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 28/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

class UIActivityIndicatorViewX {

    private var container: UIView = UIView()
    private var loadingView: UIView = UIView()
    private let activityIndicatorColor: UIColor!
    private let activityIndicatorSize: UIActivityIndicatorView.Style!
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private weak var uiView: UIView?

    init(uiView: UIView, activityIndicatorColor: UIColor = .red, activityIndicatorSize: UIActivityIndicatorView.Style = .medium) {
        self.uiView = uiView
        self.activityIndicatorColor = activityIndicatorColor
        self.activityIndicatorSize = activityIndicatorSize
    }

    public func showActivityIndicator(withAdditionalOverLayer: Bool = false) {
        guard let view = self.uiView else { return }
        container.frame = view.frame
        container.center = view.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 1)

        loadingView.frame = getContainerSize()
        loadingView.center = view.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.5)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = self.activityIndicatorSize
        activityIndicator.color = self.activityIndicatorColor
        activityIndicator.center = CGPoint(
            x: loadingView.frame.size.width / 2,
            y: loadingView.frame.size.height / 2
        )

        if withAdditionalOverLayer {
            loadingView.addSubview(activityIndicator)
            container.addSubview(loadingView)
            view.addSubview(container)
        } else {
            loadingView.addSubview(activityIndicator)
            view.addSubview(loadingView)
        }

        activityIndicator.startAnimating()
    }

    public func hideActivityIndicator(withAdditionalOverLayer: Bool = true) {
        activityIndicator.stopAnimating()
        if withAdditionalOverLayer {
            container.removeFromSuperview()
        } else {
            loadingView.removeFromSuperview()
        }
    }

    private func UIColorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red: red, green: green, blue: blue, alpha: CGFloat(alpha))
    }

    private func getContainerSize() -> CGRect {
        let size = (self.activityIndicatorSize == UIActivityIndicatorView.Style.large ? 80.0 : 40.0)
        return CGRect(x: 0.0, y: 0.0, width: size, height: size)
    }
}
