//
//  Route.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation

enum Route {
    
    case upcoming
    
    internal var requestProperties: (method: Method, path: String) {
        switch self {
        case .upcoming:
            return (.GET, "/3/movie/upcoming")
        }
    }
}
