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
    // Create a constant to store the reference to UserDefaultManager.shared
    private let userdefault = UserDefaultManager.shared
    
    var body: some View {
        VStack {
            if !isAnimationActive {
                welcomeText()
                
                VStack {
                    TextField("Enter your username...", text: $userName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                    
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
                    // Save user's name and selectedImage using UserDefaultManager
                    if let profileImageData = selectedImage?.jpegData(compressionQuality: 0.8) {
                        do {
                            try userdefault.saveUserData(username: userName,
                                                         profileImageData: profileImageData
                            )
                        } catch {
                            // Handle error if saving fails
                            print("Error saving user data: \(error)")
                        }
                    }
                    withAnimation(.easeInOut(duration: 0.5)) {

                    }
                }
            }
            .padding()
            .opacity(isAnimationActive ? 0:1) // Transition effect when the button disappears
            .animation(.easeInOut(duration: 0.5), value: isAnimationActive)
            
            //View after tapping Continue button
            if isAnimationActive {
                welcomeText(greeting: "You're all set up,", name: userName + "!")
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
                .frame(width: 100, height: 100)
                .shadow(radius: 5)
            Image(uiImage: image ?? UIImage(systemName: "person.circle.fill")!)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .frame(width: isSmallHeight() ? 70:80, height: isSmallHeight() ? 70:80)
                .clipShape(Circle())

        }
        .offset(y: isAnimationActive ? -150 : 0) // Offset the image when animation is active
    }
    
    //MARK: - welcomeText
    private func welcomeText(greeting: String = "Welcome!", name: String = "") -> some View {
        Text("\(greeting) \(name)")
            .custom(font: .bold, size: tap ? 28:32)
            .padding()
            .offset(y: isAnimationActive ? 50 : 0) // Offset the image when animation is active

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
