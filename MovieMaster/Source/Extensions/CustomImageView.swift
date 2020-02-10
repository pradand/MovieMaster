//
//  CustomImageView.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 11/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

enum ImageSizes: NSString {
    case small
    case medium
    case original
    var apiURL: String {
        switch self {
        case .small:
            return Constants.apiURLImageSmallSize
        case .medium:
            return Constants.apiURLImageMediumSize
        case .original:
            return Constants.apiURLImageOriginalSize
        }
    }
}

class CustomImageView: UIImageView {

    private var imageURLString: String?
    weak var imageActivityIndicatorDelegate: ImageActivityIndicatorDelegate?

    private func dispatchImage(image: UIImage) {
        DispatchQueue.main.async {
            self.alpha = 0
            UIView.animate(withDuration: 0.4, delay: 0.0, options: .allowUserInteraction, animations: {
                self.alpha = 1.0
            })
            self.image = image
            self.imageActivityIndicatorDelegate?.imageActivityIndicatorView?.hideActivityIndicator(withAdditionalOverLayer: false)
        }
    }

    func downloadFrom(stringURL: String, imageSize: ImageSizes = .small) {
        self.image = nil
        self.imageURLString = stringURL

        guard let defaultImage = UIImage(named: Constants.images.defaultImage) else { return }

        imageActivityIndicatorDelegate?.imageActivityIndicatorView?.showActivityIndicator()
        if !stringURL.isEmpty, let strURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: imageSize.apiURL + strURL) {
            // Checking from cache
            if let cachedImage = imageCache.object(forKey: "\(url)" as NSString) as? UIImage, self.imageURLString == stringURL {
                dispatchImage(image: cachedImage)
                print("[LOG] 🖼 Image \(url) returned from cache")
                return
            }

            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let weakSelf = self else { return }
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                    else {
                        weakSelf.dispatchImage(image: defaultImage)
                        return
                }

                print("[LOG] 🖼 Image \(url) returned from web")
                DispatchQueue.main.async {
                    imageCache.setObject(image, forKey: "\(url)" as NSString)
                    if stringURL == weakSelf.imageURLString {
                        weakSelf.dispatchImage(image: image)
                        return
                    }
                }
            }.resume()
            
        } else {
            dispatchImage(image: defaultImage)
            return
        }
    }

}
