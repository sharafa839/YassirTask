//
//  View+Extenstion.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import Foundation
import UIKit

extension UIView {
    func circular() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    func cornerRadius(_ with: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = with
    }
}
