//
//  ErrorView+Protocols.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import UIKit

protocol ErrorViewNotificationCenter: class {
    var notificationCenterDelegate: UIViewController? { get set }
    var notificationCenter: NotificationCenter? { get set }
    func setupErrorViewNotificationCenter()
}

protocol ErrorViewObserver: ErrorViewNotificationCenter {
    func retryOnError()
}

protocol ErrorViewDelegate: ErrorViewObserver {
    var errorViewContainer: ErrorView { get set }
    var errorViewModel: ErrorViewModel { get set }
    func setupErrorViewDelegate()
    func hideErrorViewContainer()
    func showErrorViewContainer()
}
