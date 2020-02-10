//
//  MovieManager.swift
//  MovieMaster
//
//  Created by Andre & Bianca on 08/12/19.
//  Copyright © 2019 Andre. All rights reserved.
//

import Foundation

enum NetworkError {
    case URLErrorTimedOut
    case URLErrorCannotFindHost
    case URLErrorCannotConnectToHost
    case URLErrorNetworkConnectionLost
    case URLErrorDNSLookupFailed
    case URLErrorHTTPTooManyRedirects
    case URLErrorResourceUnavailable
    case URLErrorNotConnectedToInternet
    case NetworkUnrelated
}

enum URLError {
    case errorCode(_ code: Int)

    var rawValue: NetworkError {
        switch self {
        case .errorCode(let code):
            switch code {
            case -1001:
                return NetworkError.URLErrorTimedOut
            case -1003:
                return NetworkError.URLErrorCannotFindHost
            case -1004:
                return NetworkError.URLErrorCannotConnectToHost
            case -1005:
                return NetworkError.URLErrorNetworkConnectionLost
            case -1006:
                return NetworkError.URLErrorDNSLookupFailed
            case -1007:
                return NetworkError.URLErrorHTTPTooManyRedirects
            case -1008:
                return NetworkError.URLErrorResourceUnavailable
            case -1009:
                return NetworkError.URLErrorNotConnectedToInternet
            default:
                return NetworkError.NetworkUnrelated
            }
        }
    }
}

public enum ErrorReturn: Error {
    case invalidEndpoint
    case invalidResponse
    case noData
    case networkTimeOut

    var description: String {
        switch self {
            case .invalidEndpoint:
                return MessagesUtils.General.invalidEndPoint
            case .invalidResponse:
                return MessagesUtils.General.invalidResponse
            case .noData:
                return MessagesUtils.General.noData
            case .networkTimeOut:
                return MessagesUtils.General.networkTimeOut
        }
    }
}

class MovieManager {
    
    // MARK: - Singleton
    static private var shared: MovieManager?
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()

    // MARK: - INIT
    init() {}

    // MARK: - Functions
    static func sharedInstance() -> MovieManager {
        if let object = self.shared {
            return object
        } else {
            self.shared = MovieManager()
            return self.shared ?? MovieManager()
        }
    }

    private func replacingPlaceHolderOccurrences(_ endPoint: Constants.MovieEndPoint, _ movieId: Int?) -> String? {
        switch endPoint {
        case .cast, .movie:
            guard let movieId = movieId else { return nil }
            return endPoint.URL.replacingOccurrences(of: Constants.movieIdPlaceHolder, with: "\(movieId)")
        default:
            return endPoint.URL
        }
        
    }

    private func setSessionConfigurationTimeoutLimit(_ timeInterval: TimeInterval) -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = timeInterval
        sessionConfiguration.timeoutIntervalForResource = timeInterval
        return sessionConfiguration
    }

    func fetchData<T: Decodable>(of type: T.Type = T.self, endPoint: Constants.MovieEndPoint, page: Int = 1, query: String? = nil, movieId: Int? = nil, completion: @escaping (Result<T, ErrorReturn>) -> ()) {

        if let endPointURL = replacingPlaceHolderOccurrences(endPoint, movieId), let request = MovieRequest.sharedInstance().generateRequest(endPoint: endPointURL, page: page, query: query) {

            let sessionTimeout = setSessionConfigurationTimeoutLimit(10)
            let session = URLSession(configuration: sessionTimeout, delegate: self as? URLSessionDelegate, delegateQueue:OperationQueue.main)

            print("[LOG] isConnectedToInternet? \(Connectivity.isConnectedToInternet)")
            if !Connectivity.isConnectedToInternet {
                completion(.failure(.networkTimeOut))
                return
            } else {

                let dataTask = session.dataTask(with: request) { [weak self] (data, response, error) in
                    guard let jsonData = data else {
                        print("❌ Request Failed")
                        if let errorCode = error?._code {
                            switch URLError.errorCode(errorCode).rawValue {
                                case .URLErrorCannotConnectToHost,
                                     .URLErrorCannotFindHost,
                                     .URLErrorDNSLookupFailed,
                                     .URLErrorHTTPTooManyRedirects,
                                     .URLErrorNetworkConnectionLost,
                                     .URLErrorNotConnectedToInternet,
                                     .URLErrorResourceUnavailable,
                                     .URLErrorTimedOut:
                                    completion(.failure(.networkTimeOut))
                            case .NetworkUnrelated:
                                    completion(.failure(.noData))
                            }
                        }

                        return
                    }

                    do {
                        let objectResult = try self?.jsonDecoder.decode(T.self, from: jsonData)
                        if let result = objectResult {
                            completion(.success(result))
                        }
                    } catch {
                        print("❌ Request Failed")
                        completion(.failure(.invalidResponse))
                    }
                }
                dataTask.resume()
            }

        } else {
            print("❌ Request Failed")
            completion(.failure(.invalidEndpoint))
        }

    }

}
