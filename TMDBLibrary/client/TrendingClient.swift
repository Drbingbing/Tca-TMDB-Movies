//
//  TrendingClient.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/26.
//

import Foundation
import Dependencies
import TMDBApi

struct TrendingClient {
    public let trendingMovies: () async throws -> [Movie]
    public let upcomingMovies: () async throws -> [Movie]
}

extension TrendingClient: DependencyKey {
    
    static var liveValue: TrendingClient {
        let apiService = AppEnvironment.current.apiService
        return TrendingClient(
            trendingMovies: {
                try await apiService.trendingMovies().results
            },
            upcomingMovies: {
                try await apiService.upcomingMovies(page: 1).results
            }
        )
    }
    
    static var previewValue: TrendingClient {
        return TrendingClient(
            trendingMovies: {
                [
                    Movie(
                        movieID: 872585,
                        overview: "克里斯多夫諾蘭自編自導的《奧本海默》是一部用IMAX攝影機拍攝的史詩驚悚片，觀眾將看到一個謎一般的男人是如何陷入一個自相矛盾的困境，他為了拯救這個世界，必須先毀滅它。",
                        title: "奧本海默",
                        originalTitle: "Oppenheimer",
                        genreIDs: [18, 36],
                        backdropPath: "/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
                        releaseDate: "2023-07-19"
                    )
                ]
            },
            upcomingMovies: {
                [
                    Movie(
                        movieID: 872585,
                        overview: "克里斯多夫諾蘭自編自導的《奧本海默》是一部用IMAX攝影機拍攝的史詩驚悚片，觀眾將看到一個謎一般的男人是如何陷入一個自相矛盾的困境，他為了拯救這個世界，必須先毀滅它。",
                        title: "奧本海默",
                        originalTitle: "Oppenheimer",
                        genreIDs: [18, 36],
                        backdropPath: "/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
                        releaseDate: "2023-07-19"
                    )
                ]
            }
        )
    }
}

extension DependencyValues {
    
    var trending: TrendingClient {
        get { self[TrendingClient.self] }
        set { self[TrendingClient.self] = newValue }
    }
}
