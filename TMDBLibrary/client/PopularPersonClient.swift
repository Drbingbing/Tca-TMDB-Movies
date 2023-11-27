//
//  PopularPersonClient.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import Foundation
import Dependencies
import TMDBApi

struct PopularPersonClient {
    public let popularPeople: (Int) async throws -> [Person]
}

extension PopularPersonClient: DependencyKey {
    static var liveValue: PopularPersonClient {
        let apiService = AppEnvironment.current.apiService
        return PopularPersonClient(
            popularPeople: { page in
                try await apiService.popularPeople(page: page)
            }
        )
    }
    
    static var previewValue: PopularPersonClient {
        return PopularPersonClient(
            popularPeople: { _ in
                [
                    Person(
                        personID: 3371806,
                        name: "Robb Guinto",
                        originalName: "Robb Guinto",
                        profilePath: "/gYs7kSFwr89BOHG2rxEOet17C2y.jpg",
                        gender: 1
                    ),
                    Person(
                        personID: 3194176,
                        name: "Angeli Khang",
                        originalName: "Angeli Khang",
                        profilePath: "/7vrTWF8PxQogF6o9ORZprYQoDOr.jpg",
                        gender: 1
                    ),
                    Person(
                        personID: 974169,
                        name: "Jenna Ortega",
                        originalName: "Jenna Ortega",
                        profilePath: "/q1NRzyZQlYkxLY07GO9NVPkQnu8.jpg",
                        gender: 1
                    )
                ]
            }
        )
    }
}

extension DependencyValues {
    
    var peopleClient: PopularPersonClient {
        get { self[PopularPersonClient.self] }
        set { self[PopularPersonClient.self] = newValue }
    }
}
