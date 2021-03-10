//
//  CollectionViewCell.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var collectionViewCellViewModel: CollectionViewCellViewModel?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tv.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "TableViewHeader")
        tv.showsVerticalScrollIndicator = false
        tv.bounces = false
        tv.separatorStyle = .none
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
        setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: public function
    func setup(vm: CollectionViewCellViewModel) {
        tableView.delegate = self
        tableView.dataSource = self
        self.collectionViewCellViewModel = vm
        tableView.reloadData()
    }
    
    //MARK: private function
    private func setupSubView() {
        contentView.addSubview(tableView)
    }
    
    private func setupConstraint() {
        tableView.snp.makeConstraints(){ make in
            make.edges.equalToSuperview()
        }
    }
}

extension CollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableViewHeader") as? TableViewHeader, let vm = collectionViewCellViewModel {
            if let vm = collectionViewCellViewModel {
                header.setup(date: vm.headerData.expressionString)
            }
            header.toggle(toggled: vm.bookingData.hasTime && !vm.passed)
            return header
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionViewCellViewModel?.bookingData.resultTime.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell, let vm = collectionViewCellViewModel {
            cell.setup(showTime: vm.bookingData.resultTime[indexPath.row].expressString, available: vm.bookingData.resultTime[indexPath.row].avalible)
            if vm.passed {
                cell.toggle(toggled: false)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    
}
