//
//  SearchView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary

struct SearchView: View {
    
    var store: StoreOf<SearchFeature>
    
    init(store: StoreOf<SearchFeature>) {
        self.store = store
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            SearchPlaceholder()
                .padding(.top, 48)
            SearchHeader {
                Image("back")
                    .resize(width: 32, height: 32)
                    .button(
                        action: { store.send(.closeSearch) },
                        style: .scaled
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.richBlack.ignoresSafeArea()
        }
    }
}

#Preview {
    SearchView(
        store: Store(initialState: SearchFeature.State()) { SearchFeature() }
    ).environment(\.colorScheme, .dark)
}
