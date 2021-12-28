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

    private let keychain = Keychain(service: "nikolaiev_project")

    func put(object: String, for key: String) throws {
        try keychain.set(object, key: key)
    }

    func get(key: String) throws -> String? {
        try keychain.get(key)
    }

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
