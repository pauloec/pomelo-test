//
//  ShopListVCViewModel.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import Foundation
import CoreLocation

import RxSwift
import RxCocoa
import RxCoreLocation

class VenueListViewControllerViewModel: ViewModelType {
    struct Input {
        let didTapLocation: AnyObserver<Void>
    }
    struct Output {
        let title: Observable<String>
        let items: Observable<[VenueListCellViewModel]>
    }

    let input: Input
    let output: Output
    
    private let didTapLocationSubject = PublishSubject<Void>()
    private let titleSubject = BehaviorSubject<String>(value: "Pomelo Pick Up")
    private let itemsSubject = BehaviorSubject<[VenueListCellViewModel]>.init(value: [])
    private let disposeBag = DisposeBag()
    private let manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        return manager
    }()
    
    init() {
        input = Input(didTapLocation: didTapLocationSubject.asObserver())
        output = Output(title: titleSubject.asObservable(),
                        items: itemsSubject.asObservable())
        
        setupRx()
    }
    
    private func setupRx() {
        disposeBag.insert(
            getVenueList()
            .map { $0.pickup }
            .map { $0.filter { $0.status == .active } }
            .map { $0.map { VenueListCellViewModel(venueModel: $0) } }
            .bind(to: itemsSubject),
            
            didTapLocationSubject
            .subscribe(onNext: { [weak self] _ in
                self?.manager.requestWhenInUseAuthorization()
                self?.manager.startUpdatingLocation()
            }),
            
            manager.rx.didUpdateLocations
            .map { $0.locations.last }
            .withLatestFrom(itemsSubject) { location, items -> [VenueListCellViewModel] in
                guard let location = location else { return items }
                items.forEach { $0.input.didUpdateDistance.onNext(location) }
                let sortedDistance = items.sorted(by: { $0.output.nominalDistance > $1.output.nominalDistance })
                return sortedDistance
            }
            .bind(to: itemsSubject)
        )
    }
    
    private func getVenueList(with shopId: String = "1") -> Observable<VenueListModel> {
        return NetworkService.getVenueList(shopId: shopId)
        .observeOn(MainScheduler.instance)
        .asObservable()
    }
}
