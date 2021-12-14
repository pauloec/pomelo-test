//
//  PickupSearchCellTests.swift
//  Pomelo TestTests
//
//  Created by Paulo Correa on 15/12/2564 BE.
//

import XCTest
import CoreLocation
@testable import PickupSearch

class PickupSearchCellTests: XCTestCase {

    var pickupSearchCellViewModel: PickupSearchCellViewModel!

    override func setUp() {
        super.setUp()
        pickupSearchCellViewModel = PickupSearchCellViewModel(city: "Bangkok",
                                                              name: "Pick Up Place",
                                                              address: "Pick Up Address",
                                                              distance: "",
                                                              latitude: 13.7563,
                                                              longitude: 100.5018)
    }

    override func tearDown() {
        pickupSearchCellViewModel = nil
        super.tearDown()
    }

    func testCityIsBangkok() {
        XCTAssertEqual(pickupSearchCellViewModel.output.city.value, "Bangkok")
    }

    func testNameIsPickUpPlace() {
        XCTAssertEqual(pickupSearchCellViewModel.output.name.value, "Pick Up Place")
    }

    func testAddressIsPickUpAddress() {
        XCTAssertEqual(pickupSearchCellViewModel.output.address.value, "Pick Up Address")
    }

    func testPickupHasNoDistance() {
        XCTAssertEqual(pickupSearchCellViewModel.output.distance.value, "")
        XCTAssertEqual(pickupSearchCellViewModel.output.distanceValue.value, 0)
    }

    func testDistanceIsOneHundredKilometers() {
        pickupSearchCellViewModel.input.updateLocation.onNext(CLLocation(latitude: 12.8524, longitude: 100.5018))

        pickupSearchCellViewModel.output.distanceValue.bind(listener: { distance in
            XCTAssertEqual(Int(distance), 100)
        })

        pickupSearchCellViewModel.output.distance.bind(listener: { distance in
            XCTAssertEqual(distance, "100.0km")
        })
    }
}
