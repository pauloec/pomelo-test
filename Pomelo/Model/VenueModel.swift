//
//  VenueModel.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation

struct VenueListModel: Decodable {
    let numberOfNewLocations: Int
    let pickup: [VenueModel]
}

struct VenueModel: Decodable {
    let idPickupLocation, idPartnetStore, idState: Int?
    let idCountry, idZone, idCarrier: Int
    let alias, address1, city, description: String
    let company, address2, nearestBts, district, postcode, hours1, hours2, floorNumber, floormapImagePath, storeImagePath, phone: String?
    let latitude, longitude: Double?
    let active: Bool
    let type: VenueType
    let subType: VenueSubType?
    let status: VenueStatus
    let features: [VenueFeatureModel]?
    let paymentMethods: [PaymentMethodModel]
}

enum VenueType: String, Decodable {
    case pickup = "pickup"
    case partner = "partner"
}

enum VenueSubType: String, Decodable {
    case store = "store"
    case csr = "csr"
    case skybox = "skybox"
    case pin = "pin"
}

enum VenueStatus: String, Decodable {
    case active = "active"
    case temporaryDisable = "temporary-disable"
}

struct VenueFeatureModel: Decodable {
    let type, description: String
}

struct PaymentMethodModel: Decodable {
    let idPartnerStore, idPaymentType: Int
    let description, status: String
}


