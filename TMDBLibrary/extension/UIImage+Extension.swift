//
//  View+Extension.swift
//  TMDBLibrary
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation
import UIKit

extension UIImage {
    func resize(width: CGFloat, height: CGFloat) -> UIImage {
        let size = CGSize(width: width, height: height)
        return UIGraphicsImageRenderer(
            size: CGSize(width: width, height: height)
        ).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func asTabBar() -> UIImage {
        resize(width: 28, height: 28)
    }
}
