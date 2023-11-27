//
//  ActorsView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI

struct ActorsView: View {
    var body: some View {
        ZStack(alignment: .top) {
            ActorListView()
                .padding(.top, 32)
            ActorHeader()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.richBlack
                .overlay(.regularMaterial)
        }
    }
}

#Preview {
    ActorsView()
        .environment(\.colorScheme, .dark)
}
