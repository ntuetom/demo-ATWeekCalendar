//
//  CalendarView.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

class CalendarView: BaseView<CalendarViewModel> {
    
    lazy var headerView: CalendarHeaderView = {
        return CalendarHeaderView(segmentTexts: viewModel.segmentStrings, hint: viewModel.hintString)
    }()
    
    lazy var collectinView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        cv.isScrollEnabled = false
        cv.backgroundColor = .white
        return cv
    }()
    
    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        return layout
    }()
    
    override func initSetupSubviews() {
        super.initSetupSubviews()
        contenView.addSubview(headerView)
        contenView.addSubview(collectinView)
    }
    
    override func makeSubviewConstraints() -> Void{
        super.makeSubviewConstraints()
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(kOffset)
            make.trailing.equalToSuperview().offset(-kOffset)
            make.height.equalToSuperview().dividedBy(8)
        }
        collectinView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(kOffset)
            make.leading.trailing.equalTo(headerView)
            make.bottom.equalToSuperview()
        }
    }
    
    override func setupOutlets(owner: AnyObject?){
        super.setupOutlets(owner: owner)
        if let vc = owner as? CalendarViewController {
            vc.collectionView = collectinView
            vc.calendarHeaderView = headerView
            vc.nextButton = headerView.nextButton
            vc.preButton = headerView.preButton
        }
    }
    
    override func setupReferencingOutlets(owner: AnyObject?){
        super.setupReferencingOutlets(owner: owner)
        if let vc = owner as? CalendarViewController {
            collectinView.delegate = vc
            collectinView.dataSource = vc
        }
    }
    
    override func setupReceivedActions(owner: AnyObject?){
        super.setupReceivedActions(owner: owner)
        if let vc = owner as? CalendarViewController{
            headerView.preButton.addTarget(vc, action: #selector(CalendarViewController.onWeekChangedChick), for: .touchUpInside)
            headerView.nextButton.addTarget(vc, action: #selector(CalendarViewController.onWeekChangedChick), for: .touchUpInside)
        }
        
    }
    
}
