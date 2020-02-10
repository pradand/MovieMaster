//
//  Connectivity.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/02/20.
//  Copyright © 2020 Andre. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
