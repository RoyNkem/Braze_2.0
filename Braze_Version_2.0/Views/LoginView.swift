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
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .custom(font: .bold, size: isSmallHeight() ? 30:35)
                .padding()
            
            TextField("Enter your name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            } else {
                Text("No image selected!")
                    .custom(font: .regular, size: isSmallHeight() ? 15:18)
            }
            
            Button("Tap to Select Image") {
                isImagePickerPresented = true
            }
            .padding()
            
            LongButton(text: "Continue") {
                // Save user's name and selectedImage, and navigate to the next screen
            }.padding()
            
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
}

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
