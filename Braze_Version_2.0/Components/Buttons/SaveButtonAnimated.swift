//
//  SaveButtonAnimated.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

enum SaveStatus {
    case ready
    case started
    case finished
}

struct SaveButtonAnimated: View {
    
    var clicked: (() -> Void)
    @State private var status: SaveStatus
    
    private let progressBarWidth: CGFloat
    private let animationTime: TimeInterval
    private let progressBarAnimationTime: TimeInterval
    
    @State private var isPlaced = false
    
    public init(clicked: @escaping () -> Void, status: SaveStatus = .ready, progressBarWidth: CGFloat = 30, animationTime: TimeInterval = 0.1, progressBarAnimationTime: TimeInterval = 0.5, isPlaced: Bool = false) {
        self.clicked = clicked
        self.status = status
        self.progressBarWidth = progressBarWidth
        self.animationTime = animationTime
        self.progressBarAnimationTime = progressBarAnimationTime
        self.isPlaced = isPlaced
    }
    
    var body: some View {
        ZStack() {
            Color.clear
                .edgesIgnoringSafeArea(.all)
            
                ZStack {
                    //first view background seen with "save"
                    if status != .finished {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.linearGradient(colors: [Color(.white).opacity(0.8), Color(.white).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                            .blendMode(.luminosity)
                            .frame(width: (status == .finished) ? 40 : 60,
                                   height: (status == .started) ? 30 : 30)
                            .animation(.linear(duration: animationTime - 0.1), value: status != .finished)
                            .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 3)
                    }
                    
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(.linearGradient(colors: [Color(.systemBackground), Color(.systemBackground).opacity(0.6)], startPoint: .top, endPoint: .bottom))
                        .blendMode(.luminosity)
                        .frame(width: (status == .started) ? 60 : 60,
                               height: (status == .started) ? 30 : 30)
                        .shadow(color: .black.opacity(0.2), radius: 2, x: 1, y: 3)
                        .padding()

                    
                    if status != .finished {
                        Text("Save")
                            .font(.system(size: isSmallHeight() ? 14:16, weight: .bold))
                            .foregroundColor(.black.opacity(0.7))
                            .opacity((status == .started) ? 0 : 1)
//                            .opacity((status == .ready) ? 1 : 0)
//                            .animation(.linear(duration: animationTime - 0.1))
                            .animation(.linear(duration: animationTime - 0.1), value: status != .finished)
                    }
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .font(.system(size: 20, weight: .heavy))
                        .foregroundColor(.black.opacity(0.7))
                        .opacity((status == .finished) ? 1 : 0)
                        .animation(.easeInOut(duration: 0.3), value: status == .finished)
                }
                .frame(width: progressBarWidth)
                .onTapGesture {
                    download()
                    clicked()
                    print("save button tapped")
                }
        }
        .frame(maxWidth: 70)
    }
    
    private func download() {
        isPlaced.toggle()
        
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { timer in
            withAnimation {
                status = .started
            }        }
        
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { timer in
            withAnimation {
                status = .finished
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            withAnimation {
                status = .ready
            }
        }
    }
    
}

struct SaveButtonAnimated_Previews: PreviewProvider {
    static var previews: some View {
        SaveButtonAnimated() {
            print("save button clicked")
        }
    }
}
