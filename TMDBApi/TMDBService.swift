//
//  TMDBService.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation

public struct TMDBService: TMDBServiceProtocol {
    
    public let serverConfig: TMDBServerConfigProtocol
    public let oauthToken: OauthTokenAuthProtocol?
    
    public init(
        serverConfig: TMDBServerConfigProtocol = TMDBServerConfig.production,
        oauthToken: OauthTokenAuthProtocol? = nil
    ) {
        self.serverConfig = serverConfig
        self.oauthToken = oauthToken
    }
    
    public func login(_ oauthToken: OauthTokenAuthProtocol) -> TMDBService {
        return TMDBService(serverConfig: serverConfig, oauthToken: oauthToken)
    }
    
    public func upcomingMovies() async throws -> [Movie] {
        try await request(.upcoming, query: [:])
    }
}
