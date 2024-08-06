//
//  FilterItemView.swift
//  YassirTask
//
//  Created by Sharaf on 8/5/24.
//

import SwiftUI

struct FilterItemView: View {
    private let filter: Filtration
    var body: some View {
        Text(filter.filter.rawValue)
            .padding()
            .background(content: {
                if filter.selected {
                    Color.red
                        .cornerRadius(30)
                } else {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.gray, lineWidth: 2)
                }
                
            })
    }
    
    
    init(filter: Filtration) {
        self.filter = filter
    }
}

#Preview {
    FilterItemView(filter: .init(filter: .alive, selected: false))
}
