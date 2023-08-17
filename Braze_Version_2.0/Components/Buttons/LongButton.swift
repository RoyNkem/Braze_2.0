//
//  LongButton.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct LongButton: View {
    @State private var tap: Bool = false
    
    var text: String
    var clicked: (() -> Void) //closure for callback
    
    var body: some View {
        
        Button (action: {
            // perform action here when clicked
            clicked()
            tap = true //animate tap gesture with delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tap = false
            }
            
        }) {
            Text(text)
                .frame(maxWidth: .infinity)
        }
        //        .blendMode(.overlay)
        .buttonStyle(.angular)
        .tint(.accentColor)
        .controlSize(.large)
//        .shadow(
//            color: .theme.homeBackground.opacity(tap ? 0.2:0), radius: tap ? 40:30, x: 0, y: tap ? 40:30
//        )
        .scaleEffect(tap ? 1.1:1)
        .animation(.spring(response: 0.4, dampingFraction: 0.6), value: tap)
    }
    
}

struct LongButton_Previews: PreviewProvider {
    static var previews: some View {
        LongButton(text: "Add to Portfolio") {
            print("Clicked")
        }
    }
}
