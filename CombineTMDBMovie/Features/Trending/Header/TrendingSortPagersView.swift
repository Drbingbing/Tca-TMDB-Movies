//
//  TrendingSortPagersView.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI
import TMDBLibrary

struct TrendingSortPagersView: View {
    @Binding var selectedSort: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                TrendingSortPagerView(
                    text: Text("即將上線")
                        .foregroundStyle(selectedSort == "即將上線" ? .primaryGray : .white),
                    image: Image("popcorn"),
                    background: selectedSort == "即將上線" ? Color.white : Color.clear
                )
                .button(
                    action: { selectedSort = "即將上線" },
                    style: .scaled
                )
                TrendingSortPagerView(
                    text: Text("大家都在看")
                        .foregroundStyle(selectedSort == "大家都在看" ? .primaryGray : .white),
                    image: Image("fire"),
                    background: selectedSort == "大家都在看" ? Color.white : Color.clear
                )
                .button(
                    action: { selectedSort = "大家都在看" },
                    style: .scaled
                )
            }
            .animation(.spring(), value: selectedSort)
        }
    }
}

private struct TrendingSortPagerView<Backgroud: ShapeStyle>: View {
    
    var text: Text
    var image: Image
    var background: Backgroud
    
    init(text: Text, image: Image, background: @autoclosure () -> Backgroud) {
        self.text = text
        self.image = image
        self.background = background()
    }
    
    var body: some View {
        HStack(spacing: 4) {
            image
                .resize(width: 24, height: 24, rederingMode: .original)
            text
                .font(.system(size: 14, weight: .medium, design: .rounded))
        }
        .padding(.leading, 8)
        .padding(.trailing, 10)
        .padding(.vertical, 6)
        .background(background)
        .clipShape(Capsule())
    }
}

#Preview {
    TrendingView()
        .environment(\.colorScheme, .dark)
}
