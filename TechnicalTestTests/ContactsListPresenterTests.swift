//
//  ContactsListPresenterTests.swift
//  TechnicalTestTests
//
//  Created by Denis Shalagin on 14.11.2022.
//

import Foundation
import XCTest
@testable import TechnicalTest

class ContactsListPresenterTests: XCTestCase {
    var sut: ContactsListPresenter!
    
    let mockService = MockContactsServiceImpl()
    let mockView = MockContactListView()
    
    override func setUpWithError() throws {
        sut = ContactsListPresenterImpl(service: mockService, view: mockView)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchListOfContacts() {
        let expectation:XCTestExpectation = expectation(description: "Fetch Contacts")
        
        mockView.reloadExpectation = expectation
        sut.reloadData()
        
        waitForExpectations(timeout: 1)
        
        XCTAssertEqual(sut.data.count, 4, "We should parse exactly 4 contact groups.")
    }
}

final class MockContactListView: ContactsListView {
    var reloadExpectation: XCTestExpectation?
    var errorExpectation: XCTestExpectation?
    
    func reloadViewData() {
        reloadExpectation?.fulfill()
    }
    
    func showError(_ error: String) {
        errorExpectation?.fulfill()
    }
}
