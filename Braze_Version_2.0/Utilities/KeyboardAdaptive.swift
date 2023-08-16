//
//  KeyboardAdaptive.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct KeyboardAdaptive: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onAppear {
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillShowNotification,
                    object: nil, queue: .main) { notification in
                        guard let keyboardFrame =
                                notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                            return
                        }
                        withAnimation {
                            keyboardHeight = keyboardFrame.height
                        }
                    }
                
                NotificationCenter.default.addObserver(
                    forName: UIResponder.keyboardWillHideNotification,
                    object: nil, queue: .main) { _ in
                        withAnimation {
                            keyboardHeight = 0
                        }
                    }
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self)
            }
    }
}
