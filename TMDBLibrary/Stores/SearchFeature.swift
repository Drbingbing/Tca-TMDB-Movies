//
//  SearchFeature.swift
//  TMDBLibrary
//
//  Created by Bing Bing on 2023/11/27.
//

import Foundation
import ComposableArchitecture
import TMDBApi

public struct SearchFeature: Reducer {
    
    @Dependency(\.search) var searchClient
    
    public init() {}
    
    public struct State: Equatable {
        public var latestPeople: [Person] = []
        public var topRatedMovies: [Movie] = []
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case viewInit
        case topRatedMovieResponse([Movie])
        case latestPeople([Person])
        case closeSearch
    }
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .viewInit:
            return .merge(
                .run { send in
                    let movies = try await searchClient.recommendMovies()
                    await send(.topRatedMovieResponse(movies))
                },
                .run { send in
                    let people = try await searchClient.topPeople()
                    await send(.latestPeople(people))
                }
            )
        case let .topRatedMovieResponse(movies):
            state.topRatedMovies = movies
            return .none
        case let .latestPeople(people):
            state.latestPeople = people
            return .none
        case .closeSearch:
            return .none
        }
    }
}
