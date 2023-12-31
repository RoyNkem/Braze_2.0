//
//  LoginView.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 17/08/2023.
//

import SwiftUI

struct LoginView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = false
    @State private var userName = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var isAnimationActive = false
    @State private var isButtonTapped = false
    
    // Create a constant to store the reference to UserDefaultManager.shared
    private var userdefault = UserDefaultManager.shared
    
    var body: some View {
        ZStack {
            ColorBlobView()
            
            VStack {
                if !isAnimationActive {
                    welcomeText()
                    
                    VStack {
                        TextField("Enter your username...", text: $userName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                        
                        if userName.isEmpty && isButtonTapped {
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
                            .custom(font: .regular, size: isSmallHeight() ? 13:16)
                    }
                    
                    Button("Tap to Select Image") {
                        isImagePickerPresented = true
                    }
                    .padding()
                }
                
                LongButton(text: "Continue") {
                    isButtonTapped = true
                    if !userName.isEmpty {
                        isAnimationActive = true
                        do {
                            try saveUserData()
                            
                        } catch let err as UserDefaultError {
                            handleUserDefaultError(err)
                        } catch {
                            handleOtherError(error)
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
            .padding(.vertical)
            .background(
                LinearGradient(colors: [Color.theme.blue.opacity(0.6), Color.theme.purple.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .background(
                VisualEffectView(effect: UIBlurEffect(style: .regular)) // Apply a visual effect background
            )
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $selectedImage)
            }
            .cornerRadius(isSmallHeight() ? 10:13)
            .onAppear {
                let (storedUsername, storedImageData) = userdefault.getUserData()
                let image = UIImage(data: storedImageData ?? Data())
                userName = storedUsername ?? ""
                selectedImage = image
            }
        }
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
        .onTapGesture {
            isImagePickerPresented = true
        }
    }
    
    //MARK: - welcomeText
    
    private func welcomeText(greeting: String = "Welcome!", name: String = "") -> some View {
        Text("\(greeting) \(name)")
            .custom(font: .bold, size: isButtonTapped ? 28:32)
            .padding()
            .offset(y: isAnimationActive ? 50 : 0) // Offset the image when animation is active
        
    }
    
    // MARK: - Helper Methods UserDefault
    
    private func saveUserData() throws {
        let defaultImage = UIImage(systemName: "person.circle.fill")!
        let selectedImageData = selectedImage?.jpegData(compressionQuality: 0.8) ?? defaultImage.jpegData(compressionQuality: 0.8)!
        
        try userdefault.saveUserData(username: userName, profileImageData: selectedImageData)
        isLoggedIn = true
    }
    
    private func handleUserDefaultError(_ error: UserDefaultError) {
        let errorDescription = UserDefaultErrorHandler.description(for: error)
        print("UserDefaultError: \(errorDescription)")
    }
    
    private func handleOtherError(_ error: Error) {
        print("Error saving user data: \(error)")
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
