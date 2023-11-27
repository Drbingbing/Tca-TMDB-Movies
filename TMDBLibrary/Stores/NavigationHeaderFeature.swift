//
//  NavigationHeaderFeature.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import Foundation
import ComposableArchitecture

public struct NavigationHeaderFeature: Reducer {
    
    public struct State: Equatable {
        public var isProcessingMirror: Bool = false
        @PresentationState public var screenMirror: ScreenMirrorFeature.State?
        @PresentationState public var searchState: SearchFeature.State?
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case screenMirrorButtonTapped(Bool)
        case screenMirrorResponsed(Bool)
        case showScreenMirror(PresentationAction<ScreenMirrorFeature.Action>)
        case showSearch(PresentationAction<SearchFeature.Action>)
        case showSearchButtonTapped
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
            .ifLet(\.$screenMirror, action: /Action.showScreenMirror) {
                ScreenMirrorFeature()
            }
            .ifLet(\.$searchState, action: /Action.showSearch) {
                SearchFeature()
            }
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .screenMirrorButtonTapped(isLoading):
            state.isProcessingMirror = isLoading
            return .run { send in
                try await Task.sleep(for: .seconds(1))
                await send(.screenMirrorResponsed(false))
            }
        case .showSearchButtonTapped:
            state.searchState = .init()
            return .none
        case .screenMirrorResponsed:
            state.isProcessingMirror = false
            state.screenMirror = .init()
            return .none
        case .showScreenMirror(.presented(.closeButtonTapped)):
            state.screenMirror = nil
            return .none
        case .showScreenMirror:
            return .none
        case .showSearch(.presented(.closeSearch)):
            state.searchState = nil
            return .none
        case .showSearch:
            return .none
        }
    }
}


