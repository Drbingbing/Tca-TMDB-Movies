//
//  Movie.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/14.
//

import Foundation

public struct MovieEnvelope: Decodable {
    
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int
    public let results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

public struct Movie: Hashable, Decodable {
    
    private let id = UUID()
    
    public let movieID: Int
    public let overview: String
    public let title: String
    public let genreIDs: [Int]
    public let posterPath: String?
    public let releaseDate: String
    public let originalTitle: String
    
    public init(
        movieID: Int,
        overview: String = "",
        title: String = "",
        originalTitle: String = "",
        genreIDs: [Int] = [],
        posterPath: String = "",
        releaseDate: String = ""
    ) {
        self.movieID = movieID
        self.overview = overview
        self.title = title
        self.posterPath = posterPath
        self.genreIDs = genreIDs
        self.releaseDate = releaseDate
        self.originalTitle = originalTitle
    }
    
    private enum CodingKeys: String, CodingKey {
        case movieID = "id"
        case overview, title
        case originalTitle = "original_title"
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
