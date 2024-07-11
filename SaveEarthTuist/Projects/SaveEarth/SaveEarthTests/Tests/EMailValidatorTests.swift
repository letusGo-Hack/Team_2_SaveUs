//
//  EMailValidatorTests.swift
//  WemixWalletTests
//
//  Created by Aaron Hanwe LEE on 2022/05/16.
//

import XCTest
@testable import WemixWalletDev

class EMailValidatorTests: XCTestCase {
  
  override func setUpWithError() throws {
    
  }
  
  override func tearDownWithError() throws {
    
  }
  
  let validator: EmailValidator = EmailValidator()
  
  func test1() throws {
    XCTAssertTrue(self.validator.isValidEmail("asd@dqwd.com"))
  }
  
  func test2() throws {
    XCTAssertTrue(self.validator.isValidEmail("a@a.a"))
  }
  
  func test3() throws {
    XCTAssertFalse(self.validator.isValidEmail("@."))
  }
  
  func test4() throws {
    XCTAssertFalse(self.validator.isValidEmail("asda@qwe"))
  }
  
  func test5() throws {
    XCTAssertFalse(self.validator.isValidEmail("qjqjwj"))
  }
  
  func test6() throws {
    XCTAssertFalse(self.validator.isValidEmail(".q"))
  }
  
}
