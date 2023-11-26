//
//  TrendingFeature.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/26.
//

import Foundation
import TMDBApi
import ComposableArchitecture

public struct TrendingFeature: Reducer {
    
    @Dependency(\.trending) var trendingClient
    
    public init() {}
    
    public struct State: Equatable {
        
        public var upcomingMovies: [Movie] = []
        public var trendingMovies: [Movie] = []
        
        public init() {}
    }
    
    public enum Action {
        case viewInit
        case upcomingResponse([Movie])
        case trendingResponse([Movie])
    }
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .viewInit:
            return .concatenate(
                .run { send in await fetchUpcomingMovies(send) },
                .run { send in await fetchTrendingMovies(send) }
            )
        case let .upcomingResponse(movies):
            state.upcomingMovies = Array(movies.prefix(10))
            return .none
        case let .trendingResponse(movies):
            state.trendingMovies = Array(movies.prefix(10))
            return .none
        }
    }
    
    private func fetchUpcomingMovies(_ send: Send<Action>) async {
        do {
            let movies = try await trendingClient.upcomingMovies()
            await send(.upcomingResponse(movies))
        } catch {
            await send(.upcomingResponse([]))
        }
    }
    
    private func fetchTrendingMovies(_ send: Send<Action>) async {
        do {
            let movies = try await trendingClient.trendingMovies()
            await send(.trendingResponse(movies))
        } catch {
            await send(.trendingResponse([]))
        }
    }
}
