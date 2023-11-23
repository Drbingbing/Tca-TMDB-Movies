//
//  UpcomingMoviesFeature.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/23.
//

import Foundation
import ComposableArchitecture
import TMDBApi

public struct UpcomingMoviesFeature: Reducer {
    
//    @Dependency(\.movies) var moviesClient
    
    public struct State: Equatable {
        public var movies: [Movie] = []
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        case moviesResponse([Movie])
        case moviesResponseFailed
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .none
//            return .run { send in
//                await startFetchUpcomingMovies(withSend: send)
//            }
        case let .moviesResponse(movies):
            state.movies = movies
            return .none
        case .moviesResponseFailed:
            return .none
        }
    }
    
//    private func startFetchUpcomingMovies(withSend send: Send<Action>) async {
//        do {
//            let movies = try await moviesClient.upcomingMovies()
//            return await send(.moviesResponse(movies))
//        } catch {
//            return await send(.moviesResponseFailed)
//        }
//    }
}
