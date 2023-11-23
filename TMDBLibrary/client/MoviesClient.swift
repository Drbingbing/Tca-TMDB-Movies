//
//  MoviesClient.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/23.
//

import Foundation
import TMDBApi
import ComposableArchitecture

struct MoviesClient {
    public let upcomingMovies: () async throws -> [Movie]
}

extension MoviesClient: DependencyKey {
    
    public static var liveValue: MoviesClient {
        let apiService = AppEnvironment.current.apiService
        return MoviesClient(
            upcomingMovies: {
                try await apiService.upcomingMovies()
            }
        )
    }
}

extension DependencyValues {
    
    var movies: MoviesClient {
        get { self[MoviesClient.self] }
        set { self[MoviesClient.self] = newValue }
    }
}
