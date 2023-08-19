//
//  LocalFileManager.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import SwiftUI

/**
 Manager class for handling local file operations.
 
 This class provides methods to save and retrieve images locally within the app.
 */
final class LocalFileManager {
    
    static let instance = LocalFileManager() //one instance for this manager in the entire app
    
    private init() { }
    
    /**
     Saves an image locally with the specified name and folder.
     
     - Parameters:
     - image: The UIImage to be saved.
     - imageName: The name to assign to the saved image.
     - folderName: The name of the folder in which the image should be stored.
     */
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
    
    /**
     Retrieves a locally saved image with the specified name and folder.
     
     - Parameters:
     - imageName: The name of the image to retrieve.
     - folderName: The name of the folder in which the image is stored.
     
     - Returns: The UIImage if found, or nil if not found.
     */
    func getImage(imageName: String, folderName: String) -> UIImage? {
        
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    /**
     Creates a folder if it doesn't already exist.
     
     - Parameter folderName: The name of the folder to be created.
     */
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
    
    /**
     Returns the URL for a specified folder name.
     
     - Parameter folderName: The name of the folder.
     
     - Returns: The URL for the specified folder.
     */
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = url.appendingPathComponent(folderName) // return a url with the specified name appended
        return fileURL
    }
    
    /**
     Returns the URL for a specified image name within a folder.
     
     - Parameters:
     - imageName: The name of the image.
     - folderName: The name of the folder.
     
     - Returns: The URL for the specified image within the specified folder.
     */
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png") //data type concantenated
    }
    
}
