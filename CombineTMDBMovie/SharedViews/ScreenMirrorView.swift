//
//  ScreenMirrorView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI
import TMDBLibrary
import ComposableArchitecture

struct ScreenMirrorView: View {
    
    var store: StoreOf<ScreenMirrorFeature>
    
    init(store: StoreOf<ScreenMirrorFeature>) {
        self.store = store
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Image("game-manual-book")
                .resizable()
                .frame(width: 200, height: 200)
            Text("找不到裝置")
                .font(.system(size: 28, weight: .bold))
                .foregroundStyle(.white)
            Text("請確認您的智慧型電視、串流裝置和iPhone或iPad全部連接同一個網路。如果需要協助，請前往我們的Netflix的說明中心")
                .font(.system(size: 14, weight: .medium))
                .padding(.horizontal, 12)
            Text("前往說明中心")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .button(style: .scaled)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .topTrailing) {
            Circle()
                .fill(.regularMaterial)
                .frame(width: 28, height: 28)
                .padding(8)
                .overlay {
                    Image("close")
                        .resize(width: 20, height: 20)
                        .foregroundStyle(.white)
                }
                .button(
                    action: { store.send(.closeButtonTapped) },
                    style: .scaled
                )
        }
    }
}

#Preview {
    ScreenMirrorView(store: Store(initialState: ScreenMirrorFeature.State()) { ScreenMirrorFeature() })
        .environment(\.colorScheme, .dark)
}
