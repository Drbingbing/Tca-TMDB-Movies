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
                        movieID: 872585,
                        overview: "克里斯多夫諾蘭自編自導的《奧本海默》是一部用IMAX攝影機拍攝的史詩驚悚片，觀眾將看到一個謎一般的男人是如何陷入一個自相矛盾的困境，他為了拯救這個世界，必須先毀滅它。",
                        title: "奧本海默",
                        originalTitle: "Oppenheimer",
                        genreIDs: [18, 36],
                        posterPath: "/7wYG2Rowz7TwOosomGBvuqLAfe5.jpg",
                        backdropPath: "/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
                        releaseDate: "2023-07-19"
                    )
                ]
            },
            nowPlaying: { _ in
                [
                    Movie(
                        movieID: 872585,
                        overview: "克里斯多夫諾蘭自編自導的《奧本海默》是一部用IMAX攝影機拍攝的史詩驚悚片，觀眾將看到一個謎一般的男人是如何陷入一個自相矛盾的困境，他為了拯救這個世界，必須先毀滅它。",
                        title: "奧本海默",
                        originalTitle: "Oppenheimer",
                        genreIDs: [18, 36],
                        posterPath: "/7wYG2Rowz7TwOosomGBvuqLAfe5.jpg",
                        backdropPath: "/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
                        releaseDate: "2023-07-19"
                    )
                ]
            },
            tops: { _ in
                [
                    Movie(
                        movieID: 872585,
                        overview: "克里斯多夫諾蘭自編自導的《奧本海默》是一部用IMAX攝影機拍攝的史詩驚悚片，觀眾將看到一個謎一般的男人是如何陷入一個自相矛盾的困境，他為了拯救這個世界，必須先毀滅它。",
                        title: "奧本海默",
                        originalTitle: "Oppenheimer",
                        genreIDs: [18, 36],
                        posterPath: "/7wYG2Rowz7TwOosomGBvuqLAfe5.jpg",
                        backdropPath: "/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
                        releaseDate: "2023-07-19"
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
