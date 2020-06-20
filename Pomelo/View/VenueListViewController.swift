//
//  ViewController.swift
//  Pomelo
//
//  Created by Paulo Correa on 20/6/20.
//  Copyright © 2020 Pomelo. All rights reserved.
//

import UIKit
import SnapKit

import RxSwift
import RxCocoa

class VenueListViewController: UIViewController, ControllerType {
    private var tableView: UITableView! {
        didSet {
            tableView.contentInsetAdjustmentBehavior = .never
            tableView.backgroundColor = .white
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 120
            tableView.register(VenueListCell.self, forCellReuseIdentifier: venueCellIdentifier)
        }
    }
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .infoDark)
        return button
    }()
    
    private let venueCellIdentifier = "venueCellIdentifier"
    
    typealias ViewModel = VenueListViewControllerViewModel
    private var viewModel: ViewModel!
    private var disposeBag = DisposeBag()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupNavigation()
        setupLayout()
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
    }
    
    private func setupLayout() {
        self.view.backgroundColor = .white
        tableView = UITableView(frame: .zero, style: .plain)
        
        [tableView].forEach {
            view.addSubview($0)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func configure(with viewModel: VenueListViewControllerViewModel) {
        self.viewModel = viewModel
        
        disposeBag.insert(
            searchButton.rx.tap
            .bind(to: viewModel.input.didTapLocation),
            
            viewModel.output.title
            .bind(to: rx.title),
            
            viewModel.output.items
            .bind(to: tableView.rx.items(cellIdentifier: venueCellIdentifier, cellType: VenueListCell.self)) { _, cellViewModel, cell in
                cell.configure(with: cellViewModel)
            }
        )
    }
}

