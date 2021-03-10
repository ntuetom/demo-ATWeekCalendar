//
//  CollectionHeaderView.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

class TableViewHeader: UITableViewHeaderFooterView {
    
    lazy var hLine: UIView = {
        return UIView()
    }()
    
    lazy var dateText: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.numberOfLines = 2
        return lb
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: public function
    func setup(date: String) {
        dateText.text = date
    }
    
    func toggle(toggled: Bool) {
        hLine.backgroundColor = toggled ? g_availableColor : g_unavailableColor
        dateText.textColor = toggled ? g_textColor : g_unavailableColor
    }
    
    //MARK: private function
    private func setupSubView() {
        let bgView = UIView()
        bgView.backgroundColor = .white
        backgroundView = bgView
        contentView.addSubview(hLine)
        contentView.addSubview(dateText)
    }
    
    private func setupConstraint() {
        hLine.snp.makeConstraints(){ make in
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(5)
        }
        dateText.snp.makeConstraints(){ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(hLine.snp.bottom).offset(kOffset)
            make.bottom.equalToSuperview()
        }
    }
    
    
}
