//
//  NetworkingManager.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import Foundation
import Combine

typealias DownloadResult = AnyPublisher<Data, Error>

final class NetworkingManager {
    
    //handling networking error in a custom way 
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknowm
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥]Bad response from URL: \(url)"
            case .unknowm: return "[⚠️]unknown error occurred"
            }
        }
    }
    
    /// A custom function that downloads
    /// - Parameter url: The URL path to the requested API
    /// - Returns: A Publisher type that returns a Data & Error
    static func download(url: URL) -> DownloadResult {
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .retry(2)
            .tryMap {try handleURLResponse(output: $0, url: url)}
            .receive(on: DispatchQueue.main) //return to the main thread
            .eraseToAnyPublisher() //converts the publisher into an AnyPublisher type (which is our function return type)
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
