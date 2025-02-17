//
//  Toast.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/10/25.
//

import SwiftUI

struct ToastView: View {
    let transaction: Transaction

    var body: some View {
        VStack(spacing: 10){
            HStack(spacing: 0){
                Text(transaction.name)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text(transaction.amount)
                    .foregroundStyle(.white)
                    .bold()
            }
            .padding(.horizontal)
            
            HStack(spacing: 0){
                Text(transaction.type)
                    .foregroundStyle(.white)
                
                Spacer()
                
                Text(transaction.timestamp)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 40)
        .frame(height: 60)
        .background(Color.deepBlue.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 8))
       
//        Text(message)
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.black.opacity(0.8))
//            .cornerRadius(8)
//            .padding(.horizontal, 40)
//            .multilineTextAlignment(.center)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let transaction: Transaction
    let duration: TimeInterval

    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isPresented {
                VStack {
                    Spacer()
                    ToastView(transaction: transaction)
                        .transition(.opacity)
                        .zIndex(1)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                }
                .padding(.bottom, 40)
            }
        }
    }
}
