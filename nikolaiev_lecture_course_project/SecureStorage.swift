//
//  SecureStorage.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 23.12.2021.
//

import UIKit
import KeychainAccess
/// A storage with Keychain
final class SecureStorage {
    
    enum Keys {
        static let email = "Email"
    }
    
    /// A Keychain object (from KeychainAccess pod)
    private let keychain = Keychain(service: "nikolaiev_project")
    
    /// Save object of type `String` to keychain.
    func put(object: String, for key: String) throws {
        try keychain.set(object, key: key)
    }
    
    /// Get object of type `String` from keychain.
    func get(key: String) throws -> String? {
        try keychain.get(key)
    }
    
    /// Save object of type `String` to keychain with biometry protection.
    func saveBiometryProtected(object: String, key: String, completion: @escaping (Result<String, MyProjectError>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            do {
                try self?.keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .biometryCurrentSet)
                    .authenticationPrompt("Authenticate to update your \(key)")
                    .set(object, key: key)
                DispatchQueue.main.async {
                    completion(.success(("")))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(Result.failure(MyProjectError.unknown))
                }
            }
        }
    }
    
    /// Get object of type `String` from keychain with biometry protection.
    func fetchBiometryProtected(key: String, completion: @escaping (Result<String?, Error>) -> Void) {
        DispatchQueue.global().async { [weak self] in
            do {
                let string = try self?.keychain
                    .accessibility(.whenPasscodeSetThisDeviceOnly, authenticationPolicy: .biometryAny)
                    .authenticationPrompt("Authenticate to get your \(key)")
                    .get(key)
                DispatchQueue.main.async {
                    completion(.success(string))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

enum MyProjectError: Error {
    case unknown
}
