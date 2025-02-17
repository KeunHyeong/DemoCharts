//
//  TagView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

enum TabMenu: CaseIterable{
    case week, month
    
    var label: String {
        switch self {
        case .week: return "Week"
        case .month: return "Month"
        }
    }
    
    var lineLabel: String {
        switch self {
        case .week: return "Income"
        case .month: return "Expense"
        }
    }
}

struct TabMenuView: View {
    @Binding var selectedTabMenu: TabMenu
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(TabMenu.allCases, id: \.self) { menu in
                    Button {
                        selectedTabMenu = menu
                    }label: {
                        Text(menu.label)
                            .foregroundStyle(selectedTabMenu == menu ? .white:  Color.lightGray)
                            .bold()
                    }
                    .frame(width: 86, height: 34)
                    .background(selectedTabMenu == menu ? Color.deepBlue : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .background(Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 34)
    }
}
