//
//  Notification+Name.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 09/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation

extension Notification.Name {
    static var errorViewRetry: Notification.Name {
        return .init(Constants.Notification.errorViewRetry.rawValue)
    }
}
