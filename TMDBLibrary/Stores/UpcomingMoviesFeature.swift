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
    
    @Dependency(\.movies) var moviesClient
    
    public struct State: Equatable {
        public var movies: [Movie] = []
        public var nextPage: Int? = nil
        public var isLoadingMovies: Bool = false
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        case cellWillDisplay(Movie)
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
            return .run { send in
                await fetchMovies(page: 1, send: send)
            }
        case let .moviesResponse(movies):
            state.movies.append(contentsOf: movies)
            state.nextPage = (state.nextPage ?? 1) + 1
            state.isLoadingMovies = false
            return .none
        case .moviesResponseFailed:
            return .none
        case let .cellWillDisplay(movie):
            if let nextPage = state.nextPage, canLoadNextPage(trigger: movie, totalItems: state.movies), !state.isLoadingMovies {
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
            let movies = try await moviesClient.upcomingMovies(page)
            return await send(.moviesResponse(movies))
        } catch {
            return await send(.moviesResponseFailed)
        }
    }
}
