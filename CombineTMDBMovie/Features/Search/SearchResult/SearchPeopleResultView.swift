//
//  SearchPeopleResultView.swift
//  CombineTMDBMovie
//
//  Created by 鍾秉辰 on 2023/11/27.
//

import SwiftUI

struct SearchPeopleResultView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(
                rows: [GridItem(.flexible(minimum: 110, maximum: .infinity))]
            ) {
                VStack(alignment: .leading, spacing: 2) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                    Text("四魂小")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white)
                    Text("動作")
                        .font(.system(size: 12))
                        .foregroundStyle(.sonicSilver)
                }
                .padding(.vertical, 8)
                .frame(width: 110)
            }
            .padding(.horizontal, 10)
            
        }
        .background(.clear)
        .frame(height: 110 * 1.4)
    }
}

#Preview {
    SearchPeopleResultView()
        .background {
            Color.richBlack
        }
}
