//
//  RecentTransView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

enum RecentTransMenu: CaseIterable {
    case all, expense, income
    
    var label: String {
        switch self {
        case .all: return "All"
        case .expense: return "Expense"
        case .income: return "Income"
        }
    }
    
    var prefix: Int {
        switch self {
        case .all: return 20
        case .expense: return 10
        case .income: return 10
        }
    }
}

struct RecentTransView: View {
    @Binding var selectedRecentTransMenu: RecentTransMenu
    
    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 0) {
                Text("Recent Transactions")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity)
        
            HStack(spacing: 20) {
                ForEach(RecentTransMenu.allCases, id: \.self) { menu in
                    Button {
                        selectedRecentTransMenu = menu
                    }label: {
                        Text(menu.label)
                            .foregroundStyle(selectedRecentTransMenu == menu ? Color.deepBlue : Color.lightGray)
                            .bold()
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 20)
    }
}
