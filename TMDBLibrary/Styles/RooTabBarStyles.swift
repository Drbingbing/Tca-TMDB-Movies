//
//  Styles.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation
import SwiftUI

extension View {
    
    public func upcomingTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "movies")!.asTabBar())
                Text("Upcoming")
            }
        }
    }
    
    public func tvTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "tv")!.asTabBar())
                Text("TVs")
            }
        }
    }
    
    public func searchTab() -> some View {
        self.tabItem {
            VStack {
                Image(uiImage: UIImage(named: "magnifier")!.asTabBar())
                Text("Search")
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
