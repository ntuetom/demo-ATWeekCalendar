//
//  CalendarHeaderView.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

class CalendarHeaderView: UIView {
    
    let texts: [String]
    let hintText: String
    
    lazy var titleLabel: UILabel = {
        let lb = makeLabel(color: g_textColor)
        lb.text = "CALENDAR_TITLE".toLocalize()
        return lb
    }()
    
    lazy var segmentButton: UIStackView = {
        let sgButtons = UIStackView(arrangedSubviews: [preButton, nextButton])
        sgButtons.layer.masksToBounds = true
        sgButtons.layer.borderColor = g_segmentBorderColor.cgColor
        sgButtons.layer.borderWidth = 1
        sgButtons.layer.cornerRadius = 5
        sgButtons.backgroundColor = g_segmentBorderColor
        sgButtons.spacing = 1
        return sgButtons
    }()
    
    lazy var nextButton: UIButton = {
        let btn = makeButton(title: texts[1])
        return btn
    }()
    
    lazy var preButton: UIButton = {
        let btn = makeButton(title: texts[0])
        return btn
    }()
    
    lazy var timeLebel: UILabel = {
        let lb = makeLabel(color: g_textColor)
        lb.font = UIFont.systemFont(ofSize: 14)
        return lb
    }()
    
    lazy var hintLabel: UILabel = {
        let lb = makeLabel(color: g_textColor)
        lb.text = hintText
        lb.textAlignment = .right
        lb.numberOfLines = 0
        lb.font = UIFont.systemFont(ofSize: 12)
        return lb
    }()
    
    init(segmentTexts: [String], hint: String) {
        texts = segmentTexts
        hintText = hint
        super.init(frame: .zero)
        setupSubView()
        setupConstraint()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: public function
    func setup(time: String, index: Int) {
        timeLebel.text = time
        preButton.isEnabled = index > 0
    }
    
    //MARK: private function
    private func setupSubView() {
        addSubview(titleLabel)
        addSubview(segmentButton)
        addSubview(timeLebel)
        addSubview(hintLabel)
    }
    
    private func setupConstraint() {
        titleLabel.snp.makeConstraints(){ make in
            make.leading.top.equalTo(self)
        }
        segmentButton.snp.makeConstraints(){ make in
            make.leading.bottom.equalTo(self)
            make.top.equalTo(titleLabel.snp.bottom).offset(kOffset)
            make.height.equalTo(30)
        }
        timeLebel.snp.makeConstraints(){ make in
            make.leading.equalTo(segmentButton.snp.trailing).offset(kOffset)
            make.centerY.equalTo(segmentButton)
        }
        hintLabel.snp.makeConstraints(){ make in
            make.trailing.equalTo(self)
            make.width.equalTo(self).dividedBy(2)
            make.centerY.equalTo(segmentButton)
        }
    }
    
    private func makeLabel(color: UIColor) -> UILabel {
        let lb = UILabel()
        lb.textColor = color
        return lb
    }
    
    private func makeButton(title: String) -> UIButton {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.layer.borderWidth = 1
        btn.layer.borderColor = g_segmentBorderColor.cgColor
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(g_textColor, for: .normal)
        btn.setTitleColor(g_unavailableColor, for: .disabled)
        return btn
    }
    
}
