//
//  SignInViewModelTests.swift
//  AuthenticationTests
//
//  Created by Hoangtaiki on 8/1/18.
//  Copyright © 2018 toprating. All rights reserved.
//

import XCTest

class SignInViewModelTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testExample() {
        let email = "duchoang.vp@gmail.com"
        XCTAssertTrue(email.isValidEmail(), "Email is valid")
    }

}
