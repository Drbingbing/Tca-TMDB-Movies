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
                Text("首頁")
            }
        }
    }
    
    public func trendingTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "trending")!.asTabBar())
                Text("熱門")
            }
        }
    }
    
    public func actorTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "actor")!.asTabBar())
                Text("演員")
            }
        }
    }
}
