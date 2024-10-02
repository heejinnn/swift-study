//
//  Quick_Nimble.swift
//  UserUnitTestTests
//
//  Created by 최희진 on 10/2/24.
//


import Quick
import Nimble

@testable import UserUnitTest

final class Quick_Nimble: QuickSpec {
    
    override class func spec() {
        var userManager: UserManager!
        
        beforeEach {
            userManager = UserManager()
        }
        
        describe("UserManager") {
            context("유효한 사용자 계정으로") {
                let username = "testuser"
                let email = "test@example.com"
                
                describe("사용자를 추가할 때") {
                    var newUser: User?
                    var ex: Error?
                    
                    beforeEach {
                        do {
                            newUser = try userManager.addUser(username: username, email: email)
                        } catch {
                            ex = error
                        }
                    }
                    
                    it("에러가 발생하지 않아야 한다") {
                        expect(ex).to(beNil())
                    }
                    
                    it("새로운 사용자가 반환되어야 한다") {
                        expect(newUser).notTo(beNil())
                        expect(newUser?.username).to(equal(username))
                        expect(newUser?.email).to(equal(email))
                    }
                    
                    it("사용자가 추가되어야 한다") {
                        let retrievedUser = userManager.getUser(byUsername: username)
                        expect(retrievedUser).notTo(beNil())
                        expect(retrievedUser?.id).to(equal(newUser?.id))
                    }
                }
            }
            
            context("잘못된 이메일로") {
                let username = "testuser"
                let invalidEmail = "invalidemail"
                
                it("UserError.invalidEmail 에러를 발생시켜야 한다") {
                    expect {
                        try userManager.addUser(username: username, email: invalidEmail)
                    }.to(throwError(UserError.invalidEmail))
                }
            }
            
            context("중복된 사용자명으로") {
                let username = "testuser"
                let email = "test@example.com"
                
                beforeEach {
                    try? userManager.addUser(username: username, email: email)
                }
                
                it("UserError.userAlreadyExists 에러를 발생시켜야 한다") {
                    expect {
                        try userManager.addUser(username: username, email: "another@example.com")
                    }.to(throwError(UserError.userAlreadyExists))
                }
            }
        }
    }
}
