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
    @State var offset: CGPoint = .zero
    
    init() {
        store = Store(initialState: SearchFeature.State()) {
            SearchFeature()
        }
        store.send(.viewInit)
    }
    
    var body: some View {
        OffsetObservingScrollView(offset: $offset) {
            VStack(spacing: 0) {
                WithViewStore(store, observe: \.latestPeople) { viewStore in
                    SearchPeoplePlaceholder(people: viewStore.state)
                }
                
                WithViewStore(store, observe: \.topRatedMovies) { viewStore in
                    SearchMovieResultView(movies: viewStore.state)
                }
            }
        }
        .onChange(of: offset) { oldValue, newValue in
            print(newValue)
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
