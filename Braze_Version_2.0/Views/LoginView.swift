//
//  LoginView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 17/08/2023.
//

import SwiftUI

struct LoginView: View {
    @State private var userName = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isAnimationActive = false
    @State private var tap = false
    
    var body: some View {
        VStack {
            if !isAnimationActive {
                welcomeText()
                
                VStack {
                    TextField("Enter your username...", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if userName.isEmpty && tap {
                        Text("Please enter a username")
                            .foregroundColor(.red)
                            .custom(font: .regular, size: 16)
                    }
                }
                .padding()
                
                if let image = selectedImage {
                    avatarImageView(image: image, isAnimationActive: isAnimationActive)
                } else {
                    Text("No image selected!")
                        .custom(font: .regular, size: isSmallHeight() ? 15:18)
                }
                
                Button("Tap to Select Image") {
                    isImagePickerPresented = true
                }
                .padding()
            }
            
            LongButton(text: "Continue") {
                tap = true
                if !userName.isEmpty {
                    isAnimationActive = true
                    withAnimation(.easeInOut(duration: 0.5)) {
                        // Save user's name and selectedImage, and navigate to the next screen
                    }
                }
            }
            .padding()
            .opacity(isAnimationActive ? 0:1) // Transition effect when the button disappears
            .animation(.easeInOut(duration: 0.5), value: isAnimationActive)
            
            if isAnimationActive {
                welcomeText(greeting: "You're all set up,", name: userName)
                Color.red
                avatarImageView(image: selectedImage, isAnimationActive: isAnimationActive)
            }
            
        }
        .custom(font: .bold, size: isSmallHeight() ? 13:16)
        .background(
            LinearGradient(colors: [Color.theme.blue.opacity(0.6), Color.theme.purple.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
        .cornerRadius(isSmallHeight() ? 10:13)
    }
    
    //MARK: - avatarImageView
    private func avatarImageView(image: UIImage?, isAnimationActive: Bool) -> some View {
        ZStack {
            Circle()
                .fill(Color.theme.homeBackground)
                .frame(width: 120, height: 120)
                .shadow(radius: 5)
            
            Image(uiImage: image ?? UIImage(systemName: "person.circle.fill")!)
                .resizable()
                .scaledToFit()
                .frame(width: isSmallHeight() ? 80:100, height: isSmallHeight() ? 80:100)
                .clipShape(Circle())
        }
        .offset(y: isAnimationActive ? -150 : 0) // Offset the image when animation is active
    }
    
    //MARK: - welcomeText
    private func welcomeText(greeting: String = "Welcome!", name: String = "") -> some View {
        Text("\(greeting) \(name)")
            .custom(font: .bold, size: isSmallHeight() ? 30:35)
            .padding()
    }
}


//MARK: - PREVIEW PROVIDER
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
                .previewLayout(.sizeThatFits)
                .padding(20)
                .environmentObject(dev.homeVM)
            
            LoginView()
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding(20)
                .environmentObject(dev.homeVM)
        }
    }
}
