//
//  CombineTMDBMovieApp.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import SwiftUI
import TMDBApi
import TMDBLibrary

private let APIKEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjA2YTk1NjNmYWU3NDMwOTc2ZWYxYzg3NjQ3OTMxMyIsInN1YiI6IjYyYmFjYjI4MTJhYWJjMDYxYjYyNjg4ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vLIgZtntgNbfv79SmwSG1tLmS4vrk7lvbqMLsKVvF_U"

@main
struct CombineTMDBMovieApp: App {
    
    init() {
        AppEnvironment.login(AccessTokenEnvelope(token: APIKEY))
        Appearance.setupAppearance(backgroundColor: .white, foregroundColor: .sealBrown)
    }
    
    var body: some Scene {
        WindowGroup {
            RootTabBarView()
        }
    }
}
