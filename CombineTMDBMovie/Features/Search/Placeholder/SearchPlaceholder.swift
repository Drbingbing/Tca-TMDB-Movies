//
//  SearchPlaceholder.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/27.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary
import TMDBApi

struct SearchPlaceholder: View {
    
    var store: StoreOf<SearchFeature>
    
    init() {
        store = Store(initialState: SearchFeature.State()) {
            SearchFeature()
        }
        store.send(.viewInit)
    }
    
    var body: some View {
        ScrollView {
            WithViewStore(store, observe: \.latestPeople) { viewStore in
                SearchPeoplePlaceholder(people: viewStore.state)
            }
            
            WithViewStore(store, observe: \.topRatedMovies) { viewStore in
                SearchMoviesPlaceholder(movies: viewStore.state)
            }
        }
    }
}


#Preview {
    SearchPlaceholder()
        .background {
            Color.richBlack.ignoresSafeArea()
        }
        .environment(\.colorScheme, .dark)
}
