//
//  ActorHeader.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import ComposableArchitecture
import TMDBLibrary

struct ActorHeader: View {
    
    var store: StoreOf<NavigationHeaderFeature>
    
    init() {
        store = Store(initialState: NavigationHeaderFeature.State()) { NavigationHeaderFeature() }
    }
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                Text("公眾人物")
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
    ActorHeader()
        .environment(\.colorScheme, .dark)
}
