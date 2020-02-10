//
//  MessagesUtils.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 30/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

struct MessagesUtils {

    struct General {
        static let ok: String = "OK"
        static let oops: String = "Oops!"
        static let somethingWentWrong = "Something went wrong!"
        static let networkTimeOut = "\(MessagesUtils.General.oops)\nServer is down or no internet connection."
        static let invalidEndPoint = "\(MessagesUtils.General.oops)\nInvalid end point being used to request data."
        static let invalidResponse = "\(MessagesUtils.General.oops)\nInvalid response has returned from server."
        static let noData = "\(MessagesUtils.General.oops)\nNo data returned from server.\nTry again later."
    }

}
