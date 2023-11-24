//
//  Route.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation

enum Route {
    
    case upcoming
    case popularTvShows
    
    internal var requestProperties: (method: Method, path: String) {
        switch self {
        case .upcoming:
            return (.GET, "/3/movie/upcoming")
        case .popularTvShows:
            return (.GET, "/3/tv/popular")
        }
    }
}
