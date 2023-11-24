//
//  TvShow.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/24.
//

import Foundation

public struct TvShowEnvelope: Decodable {
    
    public let results: [TvShow]
}

public struct TvShow: Decodable, Hashable {
    
    public var tvID: Int
    public var title: String
    public var posterPath: String
    
    public init(tvID: Int, title: String, posterPath: String) {
        self.tvID = tvID
        self.title = title
        self.posterPath = posterPath
    }
    
    private enum CodingKeys: String, CodingKey {
        case title = "name"
        case tvID = "id"
        case posterPath = "poster_path"
    }
}
