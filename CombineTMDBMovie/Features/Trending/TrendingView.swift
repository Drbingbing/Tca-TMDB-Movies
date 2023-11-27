//
//  TrendingView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary

struct TrendingView: View {
    
    @State var selectedSort = "即將上線"
    
    var body: some View {
        ZStack(alignment: .top) {
            TrendingList(sort: $selectedSort)
                .padding(.top, 100)
            TrendingHeader(selectedSort: $selectedSort)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.richBlack
                .ignoresSafeArea()
                .overlay(.regularMaterial)
        }
    }
}

#Preview {
    TrendingView()
        .environment(\.colorScheme, .dark)
}
