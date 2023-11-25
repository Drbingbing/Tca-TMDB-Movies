//
//  ConfigurationClient.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/24.
//

import Foundation
import Dependencies

public struct ConfigurationClient {
    var baseURL: String
}

extension ConfigurationClient: DependencyKey {
    public static var liveValue: ConfigurationClient {
        ConfigurationClient(baseURL: AppEnvironment.current.posterBaseURL)
    }
}

extension DependencyValues {
    
    public var posterBaseURL: String {
        get { self[ConfigurationClient.self].baseURL }
        set { self[ConfigurationClient.self].baseURL = newValue }
    }
}
