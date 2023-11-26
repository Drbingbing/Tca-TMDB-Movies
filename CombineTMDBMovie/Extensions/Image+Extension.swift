//
//  Image+Extension.swift
//  CombineTMDBMovie
//
//  Created by Bing Bing on 2023/11/26.
//

import SwiftUI

extension Image {
    
    func resize(
        width: CGFloat, 
        height: CGFloat,
        rederingMode: Image.TemplateRenderingMode? = .template
    ) -> some View {
        self.resizable()
            .renderingMode(rederingMode)
            .frame(width: width, height: height)
    }
}
