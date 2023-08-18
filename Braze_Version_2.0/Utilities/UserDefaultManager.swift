//
//  UserDefaultManager.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 17/08/2023.
//

import Foundation
import Foundation

struct UserDefaultManager {
    static let shared = UserDefaultManager()
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - User Data
    
    func saveUserData(username: String, profileImageData: Data) throws {
        userDefaults.set(username, forKey: UserDefaultsKeys.username)
        userDefaults.set(profileImageData, forKey: UserDefaultsKeys.profileImageData)
    }
    
    func getUserData() -> (username: String?, profileImageData: Data?) {
        let storedUsername = userDefaults.string(forKey: UserDefaultsKeys.username)
        let storedProfileImageData = userDefaults.data(forKey: UserDefaultsKeys.profileImageData)
        return (storedUsername, storedProfileImageData)
    }
    
    // MARK: - Login Status
    
//    var isLoggedIn: Bool {
//        get { userDefaults.bool(forKey: UserDefaultsKeys.isLoggedIn) }
//        set { userDefaults.set(newValue, forKey: UserDefaultsKeys.isLoggedIn) }
//    }
    
    // MARK: - Clear User Data
    
    //    func clearUserData() {
    //        userDefaults.removeObject(forKey: UserDefaultsKeys.username)
    //        userDefaults.removeObject(forKey: UserDefaultsKeys.profileImageData)
    //        isLoggedIn = false
    //    }
    
    // MARK: - Constants
    
    private struct UserDefaultsKeys {
        static let username = "username"
        static let profileImageData = "profileImageData"
        static let isLoggedIn = "isLoggedIn"
    }
    
}

//MARK: - Error Handling Mechanism
enum UserDefaultError: Error {
    case dataSaveFailed
    case dataDeleteFailed
    case dataReadFailed
}

struct UserDefaultErrorHandler {
    static func description(for error: UserDefaultError) -> String {
        switch error {
        case .dataSaveFailed:
            return "Failed to save user data."
        case .dataDeleteFailed:
            return "Failed to delete user data."
        case .dataReadFailed:
            return "Failed to read user data."
        }
    }
}



