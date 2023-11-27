//
//  PopularPeopleFeature.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import Foundation
import TMDBApi
import ComposableArchitecture

public struct PopularPeopleFeature: Reducer {
    
    @Dependency(\.peopleClient) var peopleClient
    
    public struct State: Equatable {
        public var people: [Person] = []
        public var isLoadingPeople: Bool = false
        public var nextPage: Int? = nil
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case viewInit
        case peopleResponse([Person])
        case cellWillDisplay(Person)
        case loadingPeople
    }
    
    public init() {}
    
    public var body: some Reducer<State, Action> {
        Reduce(self.core)
    }
    
    func core(state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .viewInit:
            return .run { send in
                await fetchPopularPeople(page: 1, send: send)
            }
        case let .peopleResponse(people):
            state.people.append(contentsOf: people)
            state.isLoadingPeople = false
            state.nextPage = (state.nextPage ?? 1) + 1
            return .none
        case let .cellWillDisplay(person):
            if let nextPage = state.nextPage,
               !state.isLoadingPeople,
               canLoadNextPage(trigger: person, totalItems: state.people) {
                return .merge(
                    .run { send in
                        await fetchPopularPeople(page: nextPage, send: send)
                    },
                    .send(.loadingPeople)
                )
            }
            return .none
        case .loadingPeople:
            state.isLoadingPeople = true
            return .none
        }
    }
    
    private func fetchPopularPeople(page: Int, send: Send<Action>) async {
        do {
            let people = try await peopleClient.popularPeople(page)
            await send(.peopleResponse(people))
        } catch {
            await send(.peopleResponse([]))
        }
    }
}


