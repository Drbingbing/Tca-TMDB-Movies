//
//  TopRatedMoviesFeature.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/26.
//

import Foundation
import ComposableArchitecture
import TMDBApi

public struct TopRatedMoviesFeature: Reducer {
    
    @Dependency(\.movies) var moviesClient
    
    public init() {}
    
    public struct State: Equatable {
        public var movies: [Movie] = []
        public var nextPage: Int? = nil
        public var isLoadingMovies: Bool = false
        
        public init() {}
    }
    
    public enum Action {
        case viewInit
        case moviesResponse([Movie])
        case cellWillDisplay(Movie)
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
            state.movies.append(contentsOf: movies)
            state.nextPage = (state.nextPage ?? 1) + 1
            state.isLoadingMovies = false
            return .none
        case let .cellWillDisplay(movie):
            if let nextPage = state.nextPage,
               !state.isLoadingMovies,
               canLoadNextPage(trigger: movie, totalItems: state.movies) {
                state.isLoadingMovies = true
                return .run { send in
                    await fetchMovies(page: nextPage, send: send)
                }
            }
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
