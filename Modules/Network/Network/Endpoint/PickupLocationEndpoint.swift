//
//  PickupLocationEndpoint.swift
//  Network
//
//  Created by Paulo Correa on 11/12/2021.
//
import Foundation
import Core

public class PickupLocationEndpoint {
    public class func searchLocation(result: PublishBinder<Swift.Result<PickupLocationResponse, ErrorModel>>) {
        ServiceManager.shared.sendRequest(request: PickupLocationRequest(), result: result)
    }
}

class PickupLocationRequest: RequestModel {
    override var path: String {
        return "/pickup-locations"
    }
}

public struct PickupLocationResponse: Codable {
    public let pickup: [Pickup]
}

public struct Pickup: Codable {
    public let idCountry, idZone, idCarrier: Int
    public let alias, address1, city, description: String
    public let idPickupLocation, idState: Int?
    public let company, address2, nearestBts, district, postcode, hours1, hours2, floorNumber, phone, npsLink, feature: String?
    public let latitude, longitude: Double?
    public let images: Image
    public let hours: [String]?
    public let active, isNewLocation, isFeatured, isDefaultLocation: Bool?
    public let type: PickupType?
    public let subType: PickupSubType?
    public let status: PickupStatus?
    public let features: [PickupFeature]?
    public let paymentMethods: [PaymentMethod]?
}

public enum PickupType: String, Codable {
    case pickup = "pickup"
    case partner = "partner"
}

public enum PickupSubType: String, Codable {
    case store = "store"
    case csr = "csr"
    case skybox = "skybox"
    case pin = "pin"
    case office = "office"
}

public enum PickupStatus: String, Codable {
    case active = "active"
    case temporaryDisable = "temporary-disable"
}

public struct PickupFeature: Codable {
    public let type, description: String
}

public struct PaymentMethod: Codable {
    public let idPartnerStore, idPaymentType, active, position: Int
    public let description: String
    public let isNew: Bool
}

public struct Image: Codable {
    public let store: Store
    public let floormap: Floormap
}

public struct Store: Codable {
    public let primary: Primary
    public let secondary: String
}

public struct Primary: Codable {
    public let landscape: String
    public let fullLandscape: String
    public let portrait: String
    public let fullPortrait: String
}

public struct Floormap: Codable {
    public let main: String
    public let zoomed: String
}
