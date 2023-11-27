//
//  SearchView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                
            }
            SearchHeader()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.richBlack.ignoresSafeArea()
        }
    }
}

#Preview {
    SearchView()
        .environment(\.colorScheme, .dark)
}
