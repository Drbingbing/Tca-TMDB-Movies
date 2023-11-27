//
//  TrendingHeader.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI
import TMDBLibrary
import ComposableArchitecture

struct TrendingHeader: View {
    
    @Binding var selectedSort: String
    
    var store: StoreOf<NavigationHeaderFeature>
    
    init(selectedSort: Binding<String>) {
        store = Store(initialState: NavigationHeaderFeature.State()) {
            NavigationHeaderFeature()
        }
        _selectedSort = selectedSort
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                Text("哈燒新榜")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                
                WithViewStore(store, observe: \.isProcessingMirror) { viewStore in
                    ProgressButton(viewStore.binding(send: { .screenMirrorButtonTapped($0) })) {
                        Image("chrome-cast")
                            .asThumbnail()
                    }
                }
                Image("magnifying-glass")
                    .asThumbnail()
                    .button(style: .scaled)
            }
            
            TrendingSortPagersView(selectedSort: $selectedSort)
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
        .background {
            Color.richBlack
                .overlay(.regularMaterial)
        }
        .sheet(
            store: store.scope(
                state: \.$screenMirror,
                action: { .showScreenMirror($0) }
            )
        ) { screenMirrorFeature in
            ScreenMirrorView(store: screenMirrorFeature)
                .presentationDetents([.medium])
                .presentationBackground(Color.primaryGray)
                .environment(\.colorScheme, .dark)
        }
    }
}

#Preview {
    TrendingView()
        .environment(\.colorScheme, .dark)
}
