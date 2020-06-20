//
//  VenueListCell.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa

class VenueListCell: UITableViewCell, ControllerType {
    private let cellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()
    
    typealias ViewModel = VenueListCellViewModel
    private var viewModel: ViewModel!
    private var disposeBag = DisposeBag()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupLayout()
    }
    
    private func setupLayout() {
        [cellStackView, distanceLabel].forEach {
            contentView.addSubview($0)
        }
        
        cellStackView.snp.makeConstraints {
            $0.top.equalTo(LayoutConstraints.StackView.top)
            $0.leading.equalTo(LayoutConstraints.StackView.leading)
            $0.trailing.equalTo(LayoutConstraints.StackView.leading)
            $0.bottom.equalTo(LayoutConstraints.StackView.bottom)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.centerY.equalTo(cellStackView)
            $0.trailing.equalTo(LayoutConstraints.DistanceLabel.trailing)
        }
        
        [cityLabel, nameLabel, addressLabel].forEach {
            cellStackView.addArrangedSubview($0)
        }
    }
    
    func configure(with viewModel: VenueListCellViewModel) {
        self.viewModel = viewModel
        
        disposeBag.insert(
            viewModel.output.city
            .bind(to: cityLabel.rx.text),
            
            viewModel.output.name
            .bind(to: nameLabel.rx.text),
            
            viewModel.output.address
            .bind(to: addressLabel.rx.text),
            
            viewModel.output.distance
            .bind(to: distanceLabel.rx.text)
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension VenueListCell {
    struct LayoutConstraints {
        struct StackView {
            static let top = 10
            static let leading = 20
            static let trailing = -20
            static let bottom = -10
        }
        struct DistanceLabel {
            static let trailing = -20
        }
    }
}
