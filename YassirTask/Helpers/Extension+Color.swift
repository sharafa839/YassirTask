//
//  Extension+Color.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var nameColor: Color {
        .init(uiColor: .init(red: 0.26, green: 0.2, blue: 0.68, alpha: 1))
    }
    
    static var speciesColor: Color {
        .init(uiColor: .init(red: 0.64, green: 0.56, blue: 0.92, alpha: 1))
    }
}
