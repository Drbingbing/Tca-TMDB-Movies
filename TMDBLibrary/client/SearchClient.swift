//
//  SearchClient.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/27.
//

import Foundation
import Dependencies
import TMDBApi

struct SearchClient {
    public let searchMovies: (String) async throws -> [Movie]
    public let searchPeople: (String) async throws -> [Person]
    public let recommendMovies: () async throws -> [Movie]
    public let topPeople: () async throws -> [Person]
}

extension SearchClient: DependencyKey {
    
    static var liveValue: SearchClient {
        let apiService = AppEnvironment.current.apiService
        return SearchClient(
            searchMovies: { query in
                let envelope = try await apiService.searchMovie(query: query)
                return envelope.results
            },
            searchPeople: { query in
                try await apiService.searchPeople(query: query)
            },
            recommendMovies: {
                let envelope = try await apiService.topMovies(page: 1)
                return envelope.results
            },
            topPeople: {
                try await apiService.popularPeople(page: 1)
            }
        )
    }
    
    static var previewValue: SearchClient {
        return SearchClient(
            searchMovies: { _ in
                try await Task.sleep(for: .microseconds(0.8))
                return [
                    Movie(
                        movieID: 872585,
                        overview: "克里斯多夫諾蘭自編自導的《奧本海默》是一部用IMAX攝影機拍攝的史詩驚悚片，觀眾將看到一個謎一般的男人是如何陷入一個自相矛盾的困境，他為了拯救這個世界，必須先毀滅它。",
                        title: "奧本海默",
                        originalTitle: "Oppenheimer",
                        genreIDs: [18, 36],
                        posterPath: "/7wYG2Rowz7TwOosomGBvuqLAfe5.jpg",
                        backdropPath: "/rLb2cwF3Pazuxaj0sRXQ037tGI1.jpg",
                        releaseDate: "2023-07-19"
                    ),
                    Movie(
                        movieID: 901362,
                        overview: "克里斯多夫諾蘭自編自導的《奧本海默》是一部用IMAX攝影機拍攝的史詩驚悚片，觀眾將看到一個謎一般的男人是如何陷入一個自相矛盾的困境，他為了拯救這個世界，必須先毀滅它。",
                        title: "魔髮精靈：樂團在一起",
                        originalTitle: "Oppenheimer",
                        genreIDs: [18, 36],
                        posterPath: "/4PPTeLVBrVRK71iU551N1OKvFtF.jpg",
                        backdropPath: "/xgGGinKRL8xeRkaAR9RMbtyk60y.jpg",
                        releaseDate: "2023-10-12"
                    )
                ]
            },
            searchPeople: { _ in
                try await Task.sleep(for: .microseconds(0.8))
                return [
                    Person(
                        personID: 3371806,
                        name: "Robb Guinto",
                        originalName: "Robb Guinto",
                        profilePath: "/gYs7kSFwr89BOHG2rxEOet17C2y.jpg",
                        gender: 1
                    ),
                    Person(
                        personID: 3194176,
                        name: "Angeli Khang",
                        originalName: "Angeli Khang",
                        profilePath: "/7vrTWF8PxQogF6o9ORZprYQoDOr.jpg",
                        gender: 1
                    ),
                    Person(
                        personID: 974169,
                        name: "Jenna Ortega",
                        originalName: "Jenna Ortega",
                        profilePath: "/q1NRzyZQlYkxLY07GO9NVPkQnu8.jpg",
                        gender: 1
                    )
                ]
            },
            recommendMovies: {
                return [
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
            topPeople: {
                return [
                    Person(
                        personID: 3371806,
                        name: "Robb Guinto",
                        originalName: "Robb Guinto",
                        profilePath: "/gYs7kSFwr89BOHG2rxEOet17C2y.jpg",
                        gender: 1
                    ),
                    Person(
                        personID: 3194176,
                        name: "Angeli Khang",
                        originalName: "Angeli Khang",
                        profilePath: "/7vrTWF8PxQogF6o9ORZprYQoDOr.jpg",
                        gender: 1
                    ),
                    Person(
                        personID: 974169,
                        name: "Jenna Ortega",
                        originalName: "Jenna Ortega",
                        profilePath: "/q1NRzyZQlYkxLY07GO9NVPkQnu8.jpg",
                        gender: 1
                    )
                ]
            }
        )
    }
}

extension DependencyValues {
    
    var search: SearchClient {
        get { self[SearchClient.self] }
        set { self[SearchClient.self] = newValue }
    }
}
