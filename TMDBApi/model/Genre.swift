//
//  Genre.swift
//  TMDBApi
//
//  Created by Bing Bing on 2023/11/25.
//

import Foundation

public struct Genre: Decodable {
    
    public let id: Int
    public let name: String
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    private enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
