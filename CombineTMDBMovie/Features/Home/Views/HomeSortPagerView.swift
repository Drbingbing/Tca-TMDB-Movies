//
//  HomeSortPagerView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import TMDBLibrary
import SwiftUI

struct HomeSortPagerView: View {
    
    @State private var selectedSort: String = ""
    
    var body: some View {
        HStack {
            if !selectedSort.isEmpty {
                Image("close")
                    .asSortPager()
                    .button(
                        action: { selectedSort = "" },
                        style: .scaled
                    )
            }
            if selectedSort.isEmpty || selectedSort == "節目" {
                SortPagerView(
                    action: { selectedSort = "節目" },
                    text: Text("節目"),
                    background: selectedSort == "節目" ? Color.almond.opacity(0.3) : Color.clear
                )
            }
            if selectedSort.isEmpty || selectedSort == "電影" {
                SortPagerView(
                    action: { selectedSort = "電影" },
                    text: Text("電影"),
                    background: selectedSort == "電影" ? Color.almond.opacity(0.3) : Color.clear
                )
            }
            
            SortPagerView(
                action: { },
                text: Text(selectedSort.isEmpty ? "類別" : "所有類別"),
                image: Image("down-arrow"),
                background: Color.clear
            )
            
            Spacer()
        }
        .animation(.spring(.bouncy), value: selectedSort)
    }
}

private struct SortPagerView<Background: ShapeStyle>: View {
    
    var text: Text
    var image: Image?
    var background: Background
    var onTap: () -> Void
    
    init(
        action: @escaping () -> Void,
        text: Text,
        image: Image? = nil,
        background: @autoclosure () -> Background
    ) {
        self.text = text
        self.image = image
        self.background = background()
        self.onTap = action
    }
    
    var body: some View {
        HStack(spacing: 3) {
            text
            if let image {
                image
                    .resize(width: 16, height: 16)
                    .foregroundStyle(.white)
            }
        }
        .asSortPager(background: background)
        .button(action: onTap, style: .scaled)
    }
}

private extension Image {
    func asSortPager() -> some View {
        self
            .resizable()
            .renderingMode(.template)
            .frame(width: 14, height: 14)
            .padding(6)
            .overlay {
                Capsule()
                    .stroke(lineWidth: 1)
                    .fill(.sonicSilver)
            }
            .foregroundStyle(.white)
    }
}

private extension View {
    
    func asSortPager<B: ShapeStyle>(background: B = Color.clear) -> some View {
        self
            .foregroundStyle(.white)
            .font(.system(size: 12))
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(background)
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(lineWidth: 1)
                    .fill(.sonicSilver)
            }
    }
}


#Preview {
    HomeSortPagerView()
        .padding(12)
        .background(.richBlack)
}
