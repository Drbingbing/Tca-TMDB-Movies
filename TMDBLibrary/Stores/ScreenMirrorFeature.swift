//
//  ScreenMirrorFeature.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import Foundation
import ComposableArchitecture

public struct ScreenMirrorFeature: Reducer {
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action: Equatable {
        case closeButtonTapped
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .closeButtonTapped:
            return .none
        }
    }
}


