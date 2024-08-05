//
//  FilterItemView.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import SwiftUI

struct FilterItemView: View {
    private let title: String
    var body: some View {
       Text(title)
            .padding()
            .background(content: {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.gray, lineWidth: 2)
            })
    }
    
    init(title: String) {
        self.title = title
    }
}

#Preview {
    FilterItemView(title: "")
}
