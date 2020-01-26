//
//  CalcParamsStoreTests.swift
//  CalcParamsStoreTests
//
//  Created by younke on 26.01.2020.
//  Copyright © 2020 Maxim Sivtcev. All rights reserved.
//

import XCTest
@testable import Ramp_Builder

class CalcParamsStoreTests: XCTestCase {

    var userDefaults: UserDefaults!
    var sut: CalcParamsStore!

    override func setUp() {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        sut = CalcParamsUserDefaults(userDefaults: userDefaults)
    }

    override func tearDown() {
        sut = nil
        userDefaults = nil
    }

    func test_sut_is_not_nil() {
        XCTAssertNotNil(sut)
    }

    func test_empty_get() {
        let params = sut.get()

        XCTAssertNil(params)
    }

    func test_simple_set() {
        let params = CalcParams()

//         when
        sut.set(params: params)

        // then
        let retreived = sut.get()
        XCTAssertNotNil(retreived)
    }

    func test_store_works_properly() {
        let store = CalcParamsUserDefaults(userDefaults: userDefaults)

        store.set(params: CalcParams())

        let retreived = sut.get()
        XCTAssertNotNil(retreived)
    }
}
