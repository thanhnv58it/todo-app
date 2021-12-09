//
//  TestCaseBase.swift
//  Todo AppTests
//
//  Created by Thành Ngô Văn on 09/12/2021.
//

import RealmSwift
import XCTest
@testable import Todo_App

class TestCaseBase: XCTestCase {
    override func setUp() {
        super.setUp()
        // Use an in-memory Realm identified by the name of the current test.
        // This ensures that each test can't accidentally access or modify the data
        // from other tests or the application itself, and because they're in-memory,
        // there's nothing that needs to be cleaned up.
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
    }
}
