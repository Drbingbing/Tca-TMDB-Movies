//
//  MoviesClient.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/23.
//

import Foundation
import TMDBApi
import ComposableArchitecture

public struct MoviesClient {
    public let upcomingMovies: (Int) async throws -> [Movie]
}

extension MoviesClient: DependencyKey {
    
    public static var liveValue: MoviesClient {
        let apiService = AppEnvironment.current.apiService
        return MoviesClient(
            upcomingMovies: { page in
                let envelope = try await apiService.upcomingMovies(page: page)
                return envelope.results
            }
        )
    }
    
    public static var previewValue: MoviesClient {
        return MoviesClient(
            upcomingMovies: { _ in
                [
                    Movie(
                        movieID: 695721,
                        overview: "",
                        title: "The Hunger Games: The Ballad of Songbirds & Snakes",
                        posterPath: "/mBaXZ95R2OxueZhvQbcEWy2DqyO.jpg",
                        releaseDate: ""
                    )
                ]
            }
        )
    }
}


extension DependencyValues {
    
    public var movies: MoviesClient {
        get { self[MoviesClient.self] }
        set { self[MoviesClient.self] = newValue }
    }
}
