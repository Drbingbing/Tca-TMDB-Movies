//
//  TvsClient.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/24.
//

import Foundation
import TMDBApi
import Dependencies

public typealias TVsClientPageIndex = Int

public struct TVsClient {
    var popularTVs: (TVsClientPageIndex) async throws -> [TvShow]
}

extension TVsClient: DependencyKey {
    
    public static var liveValue: TVsClient {
        let apiService = AppEnvironment.current.apiService
        return TVsClient(
            popularTVs: { page in
                let envelope = try await apiService.popularTvShows(page: page)
                return envelope.results
            }
        )
    }
    
    public static var previewValue: TVsClient {
        return TVsClient(
            popularTVs: { _ in
                [TvShow(tvID: 94722, title: "Tagesschau", posterPath: "/7dFZJ2ZJJdcmkp05B9NWlqTJ5tq.jpg")]
            }
        )
    }
}

extension DependencyValues {
    
    public var tvShow: TVsClient {
        get { self[TVsClient.self] }
        set { self[TVsClient.self] = newValue }
    }
}
