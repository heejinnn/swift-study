//
//  UserUnitTestTests.swift
//  UserUnitTestTests
//
//  Created by 최희진 on 9/25/24.
//

import XCTest
@testable import UserUnitTest

final class UserUnitTestTests: XCTestCase {
    
    var userManager: UserManager!

    override func setUp() {//오류 발생 가능성이 없으므로 setUp 사용 (초기화 과정에서 오류가 발생할 수 있는 경우 setUpWithError를 사용)
        super.setUp()
        userManager = UserManager()
    }

    override func tearDownWithError() throws {
        userManager = nil
        try super.tearDownWithError()
    }

    func testAddValidUser() {
        
        //Given
        let username = "testuser"
        let email = "test@example.com"
        
        // When
        let newUser: User
        do {
            newUser = try userManager.addUser(username: username, email: email)
        } catch {
            XCTFail("Valid user addition threw an error: \(error)")
            return
        }
        
        // Then
        XCTAssertEqual(newUser.id, 1)
        XCTAssertEqual(newUser.username, username)
        XCTAssertEqual(newUser.email, email)
        
        let retrievedUser = userManager.getUser(byUsername: username)
        XCTAssertNotNil(retrievedUser)
        XCTAssertEqual(retrievedUser?.id, newUser.id)
    }

    func testAddUserWithInvalidEmail() {
        // Given
        let username = "testuser"
        let invalidEmail = "invalidemail"
        
        // When
        var thrownError: Error?
        XCTAssertThrowsError(try userManager.addUser(username: username, email: invalidEmail)) {
            thrownError = $0
        }
        
        // Then
        XCTAssertEqual(thrownError as? UserError, UserError.invalidEmail)
        let retrievedUser = userManager.getUser(byUsername: username)
        XCTAssertNil(retrievedUser)
    }
    
    func testAddDuplicateUser() throws {
        // Given
        let username = "testuser"
        let email = "test@example.com"
        let duplicateEmail = "another@example.com"
        
        let newUser = try userManager.addUser(username: username, email: email)

        // When
        var thrownError: Error?
        XCTAssertThrowsError(try userManager.addUser(username: username, email: duplicateEmail)) {
            thrownError = $0
        }

        // Then
        XCTAssertEqual(thrownError as? UserError, UserError.userAlreadyExists)

        let retrievedUser = userManager.getUser(byUsername: username)
        XCTAssertNotNil(retrievedUser)
        XCTAssertEqual(retrievedUser?.email, email)

    }
    
    func testCheckExistingUser() throws {
        // Given
        let username = "testuser"
        let email = "test@example.com"
        
        let newUser = try userManager.addUser(username: username, email: email)
        
        // When(사용자 계정 등록)
        let retrievedUser = userManager.getUser(byUsername: username)
        
        
        // Then(when에서 등록한 username을 가지는 유저가 있는지 판단)
        XCTAssertNotNil(retrievedUser)//nil이 아닌 경우(유저 존재)
        XCTAssertEqual(retrievedUser?.username, username)
    }
    
    func testCheckNotExistingUser(){
        // Given
        let newUsername = "testuser2"
        
        // When
        let retrievedUser = userManager.getUser(byUsername: newUsername)
        
        // Then
        XCTAssertNil(retrievedUser)//값이 nil인 경우(유저 존재 x)
        
    }
}
