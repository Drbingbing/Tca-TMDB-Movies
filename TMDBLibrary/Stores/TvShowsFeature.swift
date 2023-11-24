//
//  TvShowsFeature.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/24.
//

import Foundation
import ComposableArchitecture
import TMDBApi

public struct TvShowsFeature: Reducer {
    
    @Dependency(\.tvShow) var tvClient
    
    public struct State: Equatable {
        public var tvShows: [TvShow] = []
        public var isLoadingTvShows: Bool = false
        public var nextPage: Int? = nil
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case onAppear
        case cellWillDisplay(TvShow)
        case tvShowsResponse([TvShow])
        case tvShowsResponseFailed
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .onAppear:
            return .run { send in
                await fetchTvShows(page: 1, send: send)
            }
        case let .cellWillDisplay(show):
            if let nextPage = state.nextPage,
               !state.isLoadingTvShows,
               canLoadNextPage(trigger: show, totalItems: state.tvShows) {
                state.isLoadingTvShows = true
                return .run { send in
                    await fetchTvShows(page: nextPage, send: send)
                }
            }
            return .none
        case let .tvShowsResponse(shows):
            state.isLoadingTvShows = false
            state.nextPage = (state.nextPage ?? 1) + 1
            state.tvShows.append(contentsOf: shows)
            return .none
        case .tvShowsResponseFailed:
            return .none
        }
    }
    
    private func fetchTvShows(page: Int, send: Send<Action>) async {
        do {
            let shows = try await tvClient.popularTVs(page)
            return await send(.tvShowsResponse(shows))
        } catch {
            return await send(.tvShowsResponseFailed)
        }
    }
}
