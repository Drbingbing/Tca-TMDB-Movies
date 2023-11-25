//
//  Route.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation

enum Route {
    
    case upcoming
    case nowPlaying
    case popularTvShows
    case topMovies
    case genres
    
    internal var requestProperties: (method: Method, path: String) {
        switch self {
        case .upcoming:
            return (.GET, "/3/movie/upcoming")
        case .nowPlaying:
            return (.GET, "/3/movie/now_playing")
        case .topMovies:
            return (.GET, "3/movie/top_rated")
        case .popularTvShows:
            return (.GET, "/3/tv/popular")
        case .genres:
            return (.GET, "/3/genre/movie/list")
        }
    }
}
