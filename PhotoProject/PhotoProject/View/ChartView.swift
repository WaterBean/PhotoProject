//
//  ChartView.swift
//  PhotoProject
//
//  Created by 한수빈 on 1/22/25.
//

import SwiftUI
import Charts

struct ChartView: View {

    let data: [Value] = [
        .init(date: "A", value: 5),
        .init(date: "B", value: 9),
        .init(date: "C", value: 7)
    ]
    var body: some View {
        Chart(data, id: \.date) { item in
            AreaMark(
                x: .value("Category", item.date),
                y: .value("Value", item.value)
            )
            .cornerRadius(36, style: .continuous)
            
        }
        
    }
}

#Preview {
    ChartView()
}
