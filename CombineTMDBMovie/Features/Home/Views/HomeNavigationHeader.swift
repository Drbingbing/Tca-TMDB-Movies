//
//  HomeNavigationHeader.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/25.
//

import SwiftUI

struct HomeNavigationHeader: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 20) {
                Text("講話大舌頭，歡迎你")
                    .font(.system(size: 20, weight: .semibold))
                Spacer()
                Image("chrome-cast")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .button(.scaled)
                Image("magnifying-glass")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .button(.scaled)
            }
            HStack {
                Text("節目")
                    .homeButtonStlye()
                Text("電影")
                    .homeButtonStlye()
                Text("類別")
                    .homeButtonStlye()
                Spacer()
            }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
        .background(.regularMaterial)
    }
}

private extension View {
    
    func homeButtonStlye() -> some View {
        self
            .foregroundStyle(.sonicSilver)
            .font(.system(size: 12))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .overlay {
                Capsule()
                    .stroke(lineWidth: 1)
                    .fill(.sonicSilver)
            }
    }
}

#Preview {
    HomeNavigationHeader()
}
