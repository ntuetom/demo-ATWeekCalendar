//
//  CollectionCell.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var timeLabel: UILabel = {
        return UILabel()
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubView()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: public function
    func setup(showTime: String, available: Bool) {
        timeLabel.text = showTime
        toggle(toggled: available)
    }
    
    func toggle(toggled: Bool) {
        timeLabel.textColor = toggled ? g_availableColor : g_unavailableColor
    }
    
    //MARK: private function
    private func setupSubView() {
        selectionStyle = .none
        contentView.addSubview(timeLabel)
    }
    
    private func setupConstraint() {
        timeLabel.snp.makeConstraints(){ make in
            make.center.equalToSuperview()
        }
    }
}
