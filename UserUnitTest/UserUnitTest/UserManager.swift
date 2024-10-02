//
//  UserManager.swift
//  UserUnitTest
//
//  Created by 최희진 on 9/25/24.
//

import Foundation
struct User {
    let id: Int
    let username: String
    let email: String
}

class UserManager {
    private var users: [User] = []
    
    func addUser(username: String, email: String) throws -> User {
        guard isValidEmail(email) else {
            throw UserError.invalidEmail
        }
        
        guard !userExists(username: username) else {
            throw UserError.userAlreadyExists
        }
        
        let newUser = User(id: users.count + 1, username: username, email: email)
        users.append(newUser)
        return newUser
    }
    
    func getUser(byUsername username: String) -> User? {
        return users.first { $0.username == username }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // 간단한 이메일 유효성 검사
        return email.contains("@") && email.contains(".")
    }
    
    private func userExists(username: String) -> Bool {
        return users.contains { $0.username == username }
    }
}

enum UserError: Error {
    case invalidEmail
    case userAlreadyExists
}
