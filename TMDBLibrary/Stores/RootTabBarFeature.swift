//
//  RootTabBarFeature.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation
import ComposableArchitecture
import TMDBApi

public typealias RootViewIndex = Int

public enum RootViewData {
    case home
    case trending
    case actors
}

public enum TabBarItem: Equatable {
    case home(RootViewIndex)
    case trending(RootViewIndex)
    case actors(RootViewIndex)
}

public struct TabBarItemsData: Equatable {
    
    public let items: [TabBarItem]
    
    public init(items: [TabBarItem]) {
        self.items = items
    }
}


public struct RootTabBarFeature: Reducer {
    
    @Dependency(\.genres) var genresClient
    
    public init() {}
    
    public struct State: Equatable {
        /// Emits the array of views.
        public var views: [RootViewData]
        
        /// Emits data for setting tab bar item styles
        public var tabBarData: TabBarItemsData
        
        public init() {
            views = []
            tabBarData = TabBarItemsData(items: [])
        }
    }
    
    public enum Action {
        case onAppear
        case genresResponse([Genre])
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.views = generateStandardView()
                state.tabBarData = tabData()
                return .run { send in
                    let genres = try await genresClient.movieGenres()
                    return await send(.genresResponse(genres))
                }
            case let .genresResponse(genres):
                AppEnvironment.replaceCurrentEnvironment(movieGenres: genres)
                return .none
            }
        }
    }
}



private func generateStandardView() -> [RootViewData] {
    return [.home, .trending, .actors]
}

private func tabData() -> TabBarItemsData {
    let items: [TabBarItem] = [
        .home(0),
        .trending(1),
        .actors(2)
    ]
    
    return TabBarItemsData(items: items)
}
