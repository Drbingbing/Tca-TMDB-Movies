//
//  NowPlayingFeature.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/25.
//

import Foundation
import TMDBApi
import ComposableArchitecture

public struct NowPlayingFeature: Reducer {
    
    @Dependency(\.movies) var moviesClient
    
    public init() {}
    
    public struct State: Equatable {
        public var movies: [Movie] = []
        public var nextPage: Int? = nil
        public var isLoadingMovies: Bool = false
        
        public init() {}
    }
    
    public enum Action {
        case onAppear
        case moviesResponse([Movie])
    }
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .run { send in
                await fetchMovies(page: 1, send: send)
            }
        case let .moviesResponse(movies):
            state.movies.append(contentsOf: movies)
            state.nextPage = (state.nextPage ?? 1) + 1
            state.isLoadingMovies = false
            return .none
        }
    }
    
    private func fetchMovies(page: Int, send: Send<Action>) async {
        do {
            let movies = try await moviesClient.nowPlaying(page)
            return await send(.moviesResponse(movies))
        } catch {
            return await send(.moviesResponse([]))
        }
    }
}
