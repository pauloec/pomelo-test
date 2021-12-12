//
//  PickupSearchViewModel.swift
//  PickupSearch
//
//  Created by Paulo Correa on 12/12/2021.
//

import Foundation
import Core
import Network
import CoreLocation

class PickupSearchViewModel: NSObject, ViewModelProtocol  {
    struct Input {
        let didLoad: PublishBinder<Void>
        let didTapEnableLocation: PublishBinder<Void>
    }
    struct Output {
        let title: RelayBinder<String>
        let items: RelayBinder<[PickupSearchCellViewModel]>
        let error: PublishBinder<String>
    }

    let input: Input
    let output: Output

    private let didTapEnableLocationBinder = PublishBinder<Void>()
    private let itemsBinder = RelayBinder<[PickupSearchCellViewModel]>.init([])
    private let titleBinder = RelayBinder<String>.init("Pomelo Pick Up")
    private let errorBinder = PublishBinder<String>()

    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        manager.delegate = self
        return manager
    }()

    override init() {
        input = Input(didLoad: PublishBinder<Void>(),
                      didTapEnableLocation: didTapEnableLocationBinder)
        output = Output(title: titleBinder,
                        items: itemsBinder,
                        error: errorBinder)

        super.init()

        input.didLoad.bind(listener: { [weak self] _ in
            self?.searchLocation()
        })

        didTapEnableLocationBinder.bind(listener: { [weak self] in
            guard let self = self, !self.itemsBinder.value.isEmpty else { return }
            DispatchQueue.main.async {
                self.manager.requestWhenInUseAuthorization()
                self.manager.startUpdatingLocation()
            }
        })
    }

    private func searchLocation() {
        let pickupResult = PublishBinder<Result<PickupLocationResponse, ErrorModel>>()
        pickupResult.bind(listener: { [weak self] result in
            switch result {
            case .success(let response):
                let viewModels = response.pickup
                    .filter { pickup in
                        pickup.active == true &&
                        pickup.alias != "" &&
                        pickup.city != "" &&
                        pickup.latitude != nil &&
                        pickup.longitude != nil
                    }.map { pickup in
                        PickupSearchCellViewModel(city: pickup.city,
                                                  name: pickup.alias,
                                                  address: pickup.address1,
                                                  distance: "",
                                                  latitude: pickup.latitude,
                                                  longitude:  pickup.longitude)
                    }
                self?.itemsBinder.value = viewModels
            case .failure(let error):
                self?.errorBinder.onNext(error.localizedDescription)
            }
        })

        PickupLocationEndpoint.searchLocation(result: pickupResult)
    }
}

extension PickupSearchViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for pickup in itemsBinder.value {
            pickup.input.updateLocation.onNext(locations.last)
        }

        itemsBinder.value = itemsBinder.value
            .sorted { $0.output.distanceValue.value < $1.output.distanceValue.value }
    }
}
