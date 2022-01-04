
import UIKit
import KeychainAccess

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

}

enum MyProjectError: Error {
    case unknown
}
