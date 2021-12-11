//
//  PickupLocationEndpoint.swift
//  Network
//
//  Created by Paulo Correa on 11/12/2021.
//
import Foundation
import Core

public class PickupLocationEndpoint {
    public class func pickupLocation(result: PublishBinder<Swift.Result<PickupLocationResponse, ErrorModel>>) {
        ServiceManager.shared.sendRequest(request: PickupLocationRequest(), result: result)
    }
}

class PickupLocationRequest: RequestModel {
    override var path: String {
        return "/pickup-locations"
    }

    override var headers: [String : String] {
        [
            "content-type": "application/json",
            "x-api-key": "PMAK-6167d603741c320047d62485-04a7ac4007612666d5728c7d67961fbb39"
        ]
    }
}

public struct PickupLocationResponse: Codable {
    let numberOfNewLocations: Int
    let pickup: [Pickup]
}

struct Pickup: Codable {
    let idPickupLocation, idPartnetStore, idState: Int?
    let idCountry, idZone, idCarrier: Int
    let alias, address1, city, description: String
    let company, address2, nearestBts, district, postcode, hours1, hours2, floorNumber, floormapImagePath, storeImagePath, phone: String?
    let latitude, longitude: Double?
    let active: Bool
    let type: PickupType
    let subType: PickupSubType?
    let status: PickupStatus
    let features: [PickupFeature]?
    let paymentMethods: [PaymentMethodModel]
}

enum PickupType: String, Codable {
    case pickup = "pickup"
    case partner = "partner"
}

enum PickupSubType: String, Codable {
    case store = "store"
    case csr = "csr"
    case skybox = "skybox"
    case pin = "pin"
    case office = "office"
}

enum PickupStatus: String, Codable {
    case active = "active"
    case temporaryDisable = "temporary-disable"
}

struct PickupFeature: Codable {
    let type, description: String
}

struct PaymentMethodModel: Codable {
    let idPartnerStore, idPaymentType: Int
    let description, status: String
}
