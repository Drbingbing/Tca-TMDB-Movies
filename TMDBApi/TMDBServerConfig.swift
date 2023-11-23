//
//  TMDBServerConfig.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation


public protocol TMDBServerConfigProtocol {
    var apiBaseURL: URL { get }
}

public struct TMDBServerConfig: TMDBServerConfigProtocol {
    
    public var apiBaseURL: URL
    
    public init(apiBaseURL: URL) {
        self.apiBaseURL = apiBaseURL
    }
    
    public static let production: TMDBServerConfigProtocol = TMDBServerConfig(
        apiBaseURL: URL(string: "https://api.themoviedb.org")!
    )
}

