//
//  LocalFileManager.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

final class LocalFileManager {
    
    static let instance = LocalFileManager() //one instance for this manager in the entire app
    
    private init() { }
    
    //save images
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName) //the folder should be created if it is not yet created
        
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
            
        } catch let error {
            print("Error saving image. ImageName: \(imageName). \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        //check if url exist
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating directory. folderName: \(folderName). \(error)")
            }
        }
    }
    
    //private func is only accessed in this class
    //Before this func is called, the folder should be created if it is not yet created
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = url.appendingPathComponent(folderName) // return a url with the specified name appended
        return fileURL
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png") //data type concantenated
    }
    
}
