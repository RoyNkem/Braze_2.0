//
//  AnimatedCircles.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

struct AnimatedCircle: View {
    
    @State var width: CGFloat = 60
    @State var status: [Bool] = Array(repeating: false, count: 7)
    private let offset = CGSize(width: -15, height: -15)
    @State var timer = Timer.publish(every: 3, on: .current, in: .common).autoconnect()
    @State var delayTime: Double = 0
    private let customGrayColor = Color.theme.animationColorBackground
    private let animationColor = Color.theme.purple.opacity(0.6)
    
    var body: some View {
        ZStack {
            customGrayColor.ignoresSafeArea()
            VStack(spacing: 15) {
                Text("Braze").textCase(.uppercase)
                    .custom(font: .heavy, size: isSmallHeight() ? 40:50)
                    .frame(alignment: .leading)
                    .foregroundLinearGradient(
                        colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing
                    )
                    .padding()
                
                HStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor, lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[0] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[1] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[2] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[3] ? offset : .zero)
                    }
                }
                HStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[1] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[2] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[3] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[4] ? offset : .zero)
                    }
                }
                HStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[2] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[3] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[4] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[5] ? offset : .zero)
                    }
                }
                HStack(spacing: 15) {
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[3] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[4] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[5] ? offset : .zero)
                    }
                    ZStack {
                        Circle()
                            .frame(width: width, height: width)
                            .foregroundColor(animationColor)
                        Circle()
                            .strokeBorder(animationColor,lineWidth: 2)
                            .frame(width: width, height: width)
                            .background(Circle().foregroundColor(customGrayColor))
                            .offset(status[6] ? offset : .zero)
                    }
                }
            }
        }
        .onAppear(perform: performAnimation)
        .onReceive(timer) { _ in
            delayTime = 0
            performAnimation()
        }
    }
    
    private func performAnimation() {
        for i in 0..<status.count {
            doAnimation(delay: delayTime, value: offset, index: i)
            delayTime += 0.3
        }
    }
    
    private func doAnimation(delay: Double, value: CGSize, index: Int) {
        withAnimation(Animation
            .easeOut(duration: 0.5)
            .delay(delayTime)) {
                status[index].toggle()
            }
        
        withAnimation(Animation
            .easeInOut(duration: 0.5)
            .delay(delayTime + 0.5)) {
                status[index].toggle()
            }
    }
}

//MARK: Preview
struct AnimatedCircle_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedCircle()
            .preferredColorScheme(.dark)
    }
}
