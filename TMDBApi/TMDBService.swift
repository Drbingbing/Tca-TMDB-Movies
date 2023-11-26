//
//  TMDBService.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation

public struct TMDBService: TMDBServiceProtocol {
    
    public let serverConfig: TMDBServerConfigProtocol
    public let oauthToken: OauthTokenAuthProtocol?
    
    public init(
        serverConfig: TMDBServerConfigProtocol = TMDBServerConfig.production,
        oauthToken: OauthTokenAuthProtocol? = nil
    ) {
        self.serverConfig = serverConfig
        self.oauthToken = oauthToken
    }
    
    public func login(_ oauthToken: OauthTokenAuthProtocol) -> TMDBService {
        return TMDBService(serverConfig: serverConfig, oauthToken: oauthToken)
    }
    
    public func upcomingMovies(page: Int) async throws -> MovieEnvelope {
        /**
         
         https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=zh-TW&page=1&primary_release_year=2023&region=TW&release_date.gte=2023-11-01&sort_by=popularity.desc
         
         */
        let query: [String: Any] = [
            "page": page,
            "include_adult": false,
            "include_video": false,
            "primary_release_year": 2023,
            "region": "TW",
            "release_date.gte": "2023-\(Calendar.current.component(.month, from: Date()))-01",
            "sort_by": "popularity.desc"
        ]
        return try await request(.upcoming, query: query)
    }
    
    public func nowPlayingMovies(page: Int) async throws -> MovieEnvelope {
        try await request(.nowPlaying, query: ["page": page])
    }
    
    public func popularTvShows(page: Int) async throws -> TvShowEnvelope {
        try await request(.popularTvShows, query: ["page": page])
    }
    
    public func topMovies(page: Int) async throws -> MovieEnvelope {
        try await request(.topMovies, query: ["page": page])
    }
    
    public func genres() async throws -> [Genre] {
        struct GenreResult: Decodable {
            public let genres: [Genre]
        }
        
        let result: GenreResult = try await request(.genres, query: [:])
        return result.genres
    }
    
    public func trendingMovies() async throws -> MovieEnvelope {
        try await request(.trendingMovies("day"), query: [:])
    }
}
