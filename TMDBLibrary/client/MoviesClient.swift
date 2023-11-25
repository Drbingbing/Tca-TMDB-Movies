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
    public let nowPlaying: (Int) async throws -> [Movie]
    public let tops: (Int) async throws -> [Movie]
}

extension MoviesClient: DependencyKey {
    
    public static var liveValue: MoviesClient {
        let apiService = AppEnvironment.current.apiService
        return MoviesClient(
            upcomingMovies: { page in
                let envelope = try await apiService.upcomingMovies(page: page)
                return envelope.results
            },
            nowPlaying: { page in
                let envelope = try await apiService.nowPlayingMovies(page: page)
                return envelope.results
            },
            tops: { page in
                let envelope = try await apiService.topMovies(page: page)
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
                        genreIDs: [27],
                        posterPath: "/mBaXZ95R2OxueZhvQbcEWy2DqyO.jpg",
                        releaseDate: ""
                    )
                ]
            },
            nowPlaying: { _ in
                [
                    Movie(
                        movieID: 695721,
                        overview: "",
                        title: "The Hunger Games: The Ballad of Songbirds & Snakes",
                        genreIDs: [27],
                        posterPath: "/mBaXZ95R2OxueZhvQbcEWy2DqyO.jpg",
                        releaseDate: ""
                    )
                ]
            },
            tops: { _ in
                [
                    Movie(
                        movieID: 695721,
                        overview: "",
                        title: "The Hunger Games: The Ballad of Songbirds & Snakes",
                        originalTitle: "The Hunger Games: The Ballad of Songbirds & Snakes",
                        genreIDs: [27],
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
