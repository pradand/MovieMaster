//
//  MovieRequest.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

class MovieRequest {
    
    // MARK: - Singleton
    static private var shared: MovieRequest?
    private let urlString = Constants.apiURLBase

    // MARK: - INIT
    init() {}

    // MARK: - Functions
    static func sharedInstance() -> MovieRequest {
        if let object = self.shared {
            return object
        } else {
            self.shared = MovieRequest()
            return self.shared ?? MovieRequest()
        }
    }

    private func prepareQueryItems(queryItems: [URLQueryItem]?, items: [(String, Any?)]) -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = queryItems ?? []

        items.forEach { (key, value) in
            if let currentValue = value {
                queryItems.append(URLQueryItem(name: "\(key)", value: "\(currentValue)"))
            }
        }

        return queryItems

    }

    func generateRequest(endPoint: String, page: Int?, query: String?) -> URLRequest? {

        if let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let fullURL = NSURLComponents(string: encodedURL + endPoint) {

            fullURL.queryItems = prepareQueryItems(queryItems: fullURL.queryItems, items: [
                ("api_key", Constants.apiToken),
                ("page", page ?? nil),
                ("language", "en-US"),
                ("query", query ?? nil)
            ])

            if let url = fullURL.url {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                var headers = request.allHTTPHeaderFields ?? [:]
                headers["Content-Type"] = "application/json"
                request.allHTTPHeaderFields = headers
                print("[LOG] 📦 Generating request for \(request)")
                return request
            }
        }

        return nil
    }

}
