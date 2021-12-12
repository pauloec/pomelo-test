//
//  PickupSearchCell.swift
//  PickupSearch
//
//  Created by Paulo Correa on 12/12/2021.
//

import UIKit
import Core

class PickupSearchCell: UITableViewCell, CellProtocol {
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
        label.numberOfLines = 0
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 10)
        return label
    }()

    typealias ViewModelProtocol = PickupSearchCellViewModel
    private var viewModel: ViewModelProtocol?
    static var identifier: String = "pickupCell"

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        setupViews()
    }


    func setupViews() {
        [cellStackView, distanceLabel].forEach {
            contentView.addSubview($0)
        }

        cellStackView.anchor(top: contentView.topAnchor,
                             leading: contentView.leadingAnchor,
                             bottom: contentView.bottomAnchor,
                             trailing: contentView.trailingAnchor,
                             padding: .init(top: LayoutConstraints.StackView.top,
                                            left: LayoutConstraints.StackView.leading,
                                            bottom: LayoutConstraints.StackView.bottom,
                                            right: LayoutConstraints.StackView.trailing),
                             topPriority: .defaultHigh,
                             leadingPriority: .defaultHigh,
                             trailingPriority: .defaultHigh)

        distanceLabel.anchor(trailing: contentView.trailingAnchor,
                             centerY: cellStackView.centerYAnchor,
                             padding: .init(top: 0,
                                            left: 0,
                                            bottom: 0,
                                            right: LayoutConstraints.DistanceLabel.trailing))

        [cityLabel, nameLabel, addressLabel].forEach {
            cellStackView.addArrangedSubview($0)
        }
    }

    func bindViewModel(viewModel: PickupSearchCellViewModel) {
        self.viewModel = viewModel
        let output = viewModel.output

        output.city.bind(listener: { [weak self] city in
            self?.cityLabel.text = city
        })

        output.name.bind(listener: { [weak self] name in
            self?.nameLabel.text = name
        })

        output.address.bind(listener: { [weak self] address in
            self?.addressLabel.text = address
        })

        output.distance.bind(listener: { [weak self] distance in
            self?.distanceLabel.text = distance
        })
    }
}

extension PickupSearchCell {
    struct LayoutConstraints {
        struct StackView {
            static let top: CGFloat = 10
            static let leading: CGFloat = 20
            static let trailing: CGFloat = 20
            static let bottom: CGFloat = 10
        }
        struct DistanceLabel {
            static let trailing: CGFloat = 100
        }
    }
}
