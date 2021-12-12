//
//  PickupSearchCellViewModel.swift
//  PickupSearch
//
//  Created by Paulo Correa on 12/12/2021.
//

import Core
import CoreLocation

class PickupSearchCellViewModel: ViewModelProtocol {
    struct Input {
        let updateLocation: PublishBinder<CLLocation>
    }
    struct Output {
        let city: RelayBinder<String>
        let name: RelayBinder<String>
        let address: RelayBinder<String>
        let distance: RelayBinder<String>
        let distanceValue: RelayBinder<Double>
    }

    let input: Input
    let output: Output

    private let updateLocationBinder = PublishBinder<CLLocation>()

    private var latitude: Double
    private var longitude: Double

    init(city: String, name: String, address: String, distance: String, latitude: Double?, longitude: Double?) {
        let cityBinder = RelayBinder<String>.init(city)
        let nameBinder = RelayBinder<String>.init(name)
        let addressBinder = RelayBinder<String>.init(address)
        let distanceBinder = RelayBinder<String>.init(distance)
        let distanceValueBinder = RelayBinder<Double>.init(0)

        self.latitude = latitude ?? 0.0
        self.longitude = longitude ?? 0.0

        input = Input(updateLocation: updateLocationBinder)
        output = Output(city: cityBinder,
                        name: nameBinder,
                        address: addressBinder,
                        distance: distanceBinder,
                        distanceValue: distanceValueBinder)

        updateLocationBinder.bind(listener: { location in
            let pickupLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
            let distance = pickupLocation.distance(from: location)
            distanceBinder.value = String(format:"%.01fkm", distance / 1000)
            distanceValueBinder.value = Double(distance / 1000)
        })
    }
}
