//
//  Person.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import Foundation

public struct Person: Decodable, Hashable {
    
    public let personID: Int
    public let name: String
    public let originalName: String
    public let profilePath: String?
    public let gender: Int
    
    public init(
        personID: Int,
        name: String,
        originalName: String,
        profilePath: String,
        gender: Int
    ) {
        self.personID = personID
        self.name = name
        self.originalName = originalName
        self.profilePath = profilePath
        self.gender = gender
    }
    
    public enum CodingKeys: String, CodingKey {
        case personID = "id"
        case name = "name"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case gender = "gender"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.personID = try container.decode(Int.self, forKey: .personID)
        self.name = try container.decode(String.self, forKey: .name)
        self.originalName = try container.decode(String.self, forKey: .originalName)
        self.profilePath = try container.decode(String.self, forKey: .profilePath)
        self.gender = try container.decode(Int.self, forKey: .gender)
    }
}
