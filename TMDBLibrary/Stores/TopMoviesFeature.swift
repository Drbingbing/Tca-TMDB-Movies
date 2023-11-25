//
//  TopMoviesFeature.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/25.
//

import Foundation
import ComposableArchitecture
import TMDBApi

public struct TopMoviesFeature: Reducer {
    
    @Dependency(\.movies) var moviesClient
    
    public init() {}
    
    public struct State: Equatable {
        public var movie: Movie?
        
        public init() {}
    }
    
    public enum Action {
        case viewInit
        case moviesResponse([Movie])
    }
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .viewInit:
            return .run { send in
                await fetchMovies(page: 1, send: send)
            }
        case let .moviesResponse(movies):
            state.movie = movies.first
            return .none
        }
    }
    
    private func fetchMovies(page: Int, send: Send<Action>) async {
        do {
            let movies = try await moviesClient.tops(page)
            return await send(.moviesResponse(movies))
        } catch {
            return await send(.moviesResponse([]))
        }
    }
}
