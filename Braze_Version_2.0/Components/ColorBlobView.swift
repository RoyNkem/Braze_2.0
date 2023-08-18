//
//  ColorBlobView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct ColorBlobView: View {
    @State private var blobPositions: [CGPoint] = []
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<blobPositions.count, id: \.self) { index in
                Circle()
                    .fill(randomColor())
                    .frame(width: 30, height: 30)
                    .position(blobPositions[index])
                    .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false), value: blobPositions)
                    .onAppear {
                        updateBlobPosition(index: index, in: geometry.size)
                    }
            }
        }
        .onAppear {
            generateInitialBlobPositions(count: 10)
        }
    }
    
    private func generateInitialBlobPositions(count: Int) {
        blobPositions = (0..<count).map { _ in randomPosition(in: .zero) }
    }
    
    private func updateBlobPosition(index: Int, in bounds: CGSize) {
        withAnimation {
            blobPositions[index] = randomPosition(in: bounds)
        }
    }
    
    private func randomPosition(in bounds: CGSize) -> CGPoint {
        CGPoint(x: CGFloat.random(in: 0...bounds.width), y: CGFloat.random(in: 0...bounds.height))
    }
    
    private func randomColor() -> Color {
        Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
}

struct ColorBlobView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ColorBlobView()
            
            ColorBlobView()
                .preferredColorScheme(.dark)
        }
    }
}
