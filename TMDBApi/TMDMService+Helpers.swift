//
//  TMDMService+Helpers.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation

extension TMDBService {
    
    private static let session = URLSession(configuration: .default)

    func request<M: Decodable>(_ route: Route, query: [String: Any]) async throws -> M {
        let properties = route.requestProperties
        
        guard let URL = URL(string: properties.path, relativeTo: serverConfig.apiBaseURL as URL) else {
            fatalError(
                "URL(string: \(properties.path), relativeToURL: \(serverConfig.apiBaseURL)) == nil"
            )
        }
        
        let jsonData = try await TMDBService.session.dataResponse(
            preparedRequest(for: URL, method: properties.method, query: query)
        )
        
        return try decodeModel(jsonData)
    }
}
