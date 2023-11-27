//
//  SearchResultView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import TMDBLibrary
import ComposableArchitecture

struct SearchResultView: View {
    
    var store: StoreOf<SearchFeature>
    
    init() {
        store = Store(initialState: SearchFeature.State()) {
            SearchFeature()
        }
    }
    
    var body: some View {
        VStack {
            SearchPlaceholder()
        }
    }
}

#Preview {
    SearchResultView()
}
