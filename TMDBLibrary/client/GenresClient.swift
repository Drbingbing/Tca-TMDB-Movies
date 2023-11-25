//
//  GenresClient.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/25.
//

import Foundation
import TMDBApi
import Dependencies

public struct GenresClient {
    public let movieGenres: () async throws -> [Genre]
    public let getMovieGenresName: ([Int]) -> [String]
    
    private static var defaultValue: [Genre] {
        [
            Genre(id: 28, name: "Action"),
            Genre(id: 12, name: "Adventure"),
            Genre(id: 16, name: "Animation"),
            Genre(id: 35, name: "Comedy"),
            Genre(id: 80, name: "Crime"),
            Genre(id: 99, name: "Documentary"),
            Genre(id: 18, name: "Drama"),
            Genre(id: 10751, name: "Family"),
            Genre(id: 14, name: "Fantasy"),
            Genre(id: 27, name: "Horror")
        ]
    }
}

extension GenresClient: DependencyKey {
    
    public static var liveValue: GenresClient {
        let apiService = AppEnvironment.current.apiService
        return GenresClient(
            movieGenres: {
                try await apiService.genres()
            },
            getMovieGenresName: { ids in
                AppEnvironment.current.movieGenres.filter { ids.contains($0.id) }
                    .map(\.name)
            }
        )
    }
    
    public static var previewValue: GenresClient {
        return GenresClient(
            movieGenres: {
                GenresClient.defaultValue
            },
            getMovieGenresName: { ids in
                GenresClient.defaultValue.filter { ids.contains($0.id) }
                    .map(\.name)
            }
        )
    }
}

extension DependencyValues {
    
    public var genres: GenresClient {
        get { self[GenresClient.self] }
        set { self[GenresClient.self] = newValue }
    }
}

/**
 {
   "genres": [
     {
       "id": 28,
       "name": "Action"
     },
     {
       "id": 12,
       "name": "Adventure"
     },
     {
       "id": 16,
       "name": "Animation"
     },
     {
       "id": 35,
       "name": "Comedy"
     },
     {
       "id": 80,
       "name": "Crime"
     },
     {
       "id": 99,
       "name": "Documentary"
     },
     {
       "id": 18,
       "name": "Drama"
     },
     {
       "id": 10751,
       "name": "Family"
     },
     {
       "id": 14,
       "name": "Fantasy"
     },
     {
       "id": 36,
       "name": "History"
     },
     {
       "id": 27,
       "name": "Horror"
     },
     {
       "id": 10402,
       "name": "Music"
     },
     {
       "id": 9648,
       "name": "Mystery"
     },
     {
       "id": 10749,
       "name": "Romance"
     },
     {
       "id": 878,
       "name": "Science Fiction"
     },
     {
       "id": 10770,
       "name": "TV Movie"
     },
     {
       "id": 53,
       "name": "Thriller"
     },
     {
       "id": 10752,
       "name": "War"
     },
     {
       "id": 37,
       "name": "Western"
     }
   ]
 }
 */
