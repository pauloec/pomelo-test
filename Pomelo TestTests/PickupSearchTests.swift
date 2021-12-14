//
//  PickupSearchTests.swift
//  Pomelo TestTests
//
//  Created by Paulo Correa on 15/12/2564 BE.
//

import XCTest
@testable import PickupSearch

class PickupSearchTests: XCTestCase {

    var pickupSearchViewModel: PickupSearchViewModel!

    override func setUp() {
        super.setUp()
        pickupSearchViewModel = PickupSearchViewModel()
    }

    override func tearDown() {
        pickupSearchViewModel = nil
        super.tearDown()
    }

    func testTitleIsPomelo() {
        XCTAssertEqual(pickupSearchViewModel.output.title.value, "Pomelo Pick Up")
    }

    func testNoItemsForPickup() {
        XCTAssertTrue(pickupSearchViewModel.output.items.value.isEmpty)
    }

}
