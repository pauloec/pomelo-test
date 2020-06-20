//
//  VenueListCellViewModel.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation
import CoreLocation

import RxSwift

class VenueListCellViewModel: ViewModelType {
    struct Input {
        let didUpdateDistance: AnyObserver<CLLocation>
    }
    struct Output {
        let city: Observable<String>
        let name: Observable<String>
        let address: Observable<String>
        let distance: Observable<String>
        let nominalDistance: Double
    }

    let input: Input
    let output: Output
    
    private let didUpdateDistanceSubject = PublishSubject<CLLocation>()
    private let citySubject: BehaviorSubject<String>
    private let nameSubject: BehaviorSubject<String>
    private let addressSubject: BehaviorSubject<String>
    private let distanceSubject = BehaviorSubject<String>.init(value: "")
    private var nominalDistance: Double = 0.0
    private let disposeBag = DisposeBag()
    
    init(venueModel: VenueModel) {
        citySubject = .init(value: venueModel.city)
        nameSubject = .init(value: venueModel.alias)
        addressSubject = .init(value: venueModel.address1)
        
        input = Input(didUpdateDistance: didUpdateDistanceSubject.asObserver())
        output = Output(city: citySubject.asObservable(),
                        name: nameSubject.asObservable(),
                        address:  addressSubject.asObservable(),
                        distance: distanceSubject.asObservable(),
                        nominalDistance: nominalDistance)
        
        didUpdateDistanceSubject
        .take(1)
        .map { [weak self] myLocation -> String in
            guard let latitude = venueModel.latitude, let longitude = venueModel.longitude else { return "" }
            let venueLocation = CLLocation(latitude: latitude, longitude: longitude)
            let distance = venueLocation.distance(from: myLocation)
            self?.nominalDistance = distance
            return String(format:"%.01fkm", distance / 1000)
        }
        .bind(to: distanceSubject)
        .disposed(by: disposeBag)
    }
}
