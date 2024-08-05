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
        .init(uiColor: UIColor(named: "titleColor")!)
    }
    
    static var speciesColor: Color {
        .init(uiColor: UIColor(named: "subTitleColor")!)
    }
}

extension UIColor {
    static var titleColor: UIColor {
        UIColor(named: "titleColor")!
    }
}
