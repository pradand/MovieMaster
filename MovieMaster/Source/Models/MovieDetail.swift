//
//  MovieDetail.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 29/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

class MovieDetail: Decodable {
    var runtime: Int?
    var genres: [Genre] = []
}

extension MovieDetail {
    var timeAndCategory: String {
        return "\(runtime ?? 0)m | \(categories)"
    }

    var categories: String {
        return genres.compactMap { $0.name }.joined(separator: ", ")
    }
}
