//
//  Environment.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/15.
//

import Foundation
import TMDBApi

public struct Environment {
    
    /// A type that exposes endpoint for fetching TMDB movies.
    public let apiService: TMDBServiceProtocol
    
    public let posterBaseURL: String
    
    /// A Collections of movie's genres
    public let movieGenres: [Genre]
    
    init(
        apiService: TMDBServiceProtocol = TMDBService(),
        posterBaseURL: String = "https://image.tmdb.org/t/p/w185",
        movieGenres: [Genre] = []
    ) {
        self.apiService = apiService
        self.posterBaseURL = posterBaseURL
        self.movieGenres = movieGenres
    }
}
