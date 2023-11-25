//
//  Styles.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation
import SwiftUI

extension View {
    
    public func homeTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "house")!.asTabBar())
                Text("Home")
            }
        }
    }
    
    public func trendingTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "trending")!.asTabBar())
                Text("Trending")
            }
        }
    }
    
    public func actorTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "actor")!.asTabBar())
                Text("Actors")
            }
        }
    }
}
