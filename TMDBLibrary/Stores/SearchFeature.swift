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
    private enum CancelID { case search }
    
    public init() {}
    
    public struct State: Equatable {
        public var latestPeople: [Person] = []
        public var topRatedMovies: [Movie] = []
        public var searchedMovies: [Movie] = []
        public var searchText: String = ""
        public var isSearchingMovie: Bool = false
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case viewInit
        case topRatedMovieResponse([Movie])
        case latestPeople([Person])
        case closeSearch
        case searchTextChanged(String)
        case searchedMovieResults([Movie])
        case searchMovieDidStart
        case searchMovieDidEnd
    }
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
            ._printChanges()
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
        case let .searchTextChanged(searchText):
            state.searchText = searchText
            if searchText.isEmpty {
                state.searchedMovies = []
                return .cancel(id: CancelID.search)
            }
            return .merge(
                .run { send in
                    await fetchSearchMovies(query: searchText, send: send)
                },
                .send(.searchMovieDidStart)
            ).debounce(id: CancelID.search, for: .milliseconds(300), scheduler: RunLoop.main)
        case let .searchedMovieResults(movies):
            state.searchedMovies = movies
            return .send(.searchMovieDidEnd)
        case .searchMovieDidStart:
            state.isSearchingMovie = true
            return .none
        case .searchMovieDidEnd:
            state.isSearchingMovie = false
            return .none
        }
    }
    
    private func fetchSearchMovies(query: String, send: Send<Action>) async {
        do {
            let movies = try await searchClient.searchMovies(query)
            await send(.searchedMovieResults(movies))
        } catch {
            await send(.searchedMovieResults([]))
        }
    }
}
