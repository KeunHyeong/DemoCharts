//
//  View+Extension.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

extension View {
    func initialTask(perform action: @escaping () async -> Void) -> some View {
        modifier(InitialTaskModifier(perform: action))
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, transaction: Transaction, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, transaction: transaction, duration: duration))
    }
}

struct InitialTaskModifier: ViewModifier {
    @State private var didLoad = false
    private let action: () async -> Void
    
    init(perform action: @escaping () async -> Void) {
        self.action = action
    }
    
    func body(content: Content) -> some View {
        content
            .task {
                if !didLoad {
                    await action()
                    didLoad = true
                }
            }
    }
}
