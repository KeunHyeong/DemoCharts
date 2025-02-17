//
//  recentTransCellView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

struct RecentTransCellView: View {
    @Binding var selectedRecentTransMenu: RecentTransMenu
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 51, height: 51)
                .foregroundColor(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(spacing: 10){
                HStack(spacing: 0){
                    Text(transaction.name)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Text(transaction.amount)
                        .foregroundStyle(Color.deepBlue)
                        .bold()
                }
                
                HStack(spacing: 0){
                    Text(transaction.type)
                        .foregroundStyle(Color.lightGray)
                    
                    Spacer()
                    
                    Text(transaction.timestamp)
                        .foregroundStyle(Color.lightGray)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(height: 51)
    }
}


