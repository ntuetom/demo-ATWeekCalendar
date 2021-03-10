//
//  ViewController.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

class CalendarViewController: UIViewController {

    var viewModel: CalendarViewModel!
    var calendarView: CalendarView!
    weak var calendarHeaderView: CalendarHeaderView!
    weak var collectionView: UICollectionView!
    weak var nextButton: UIButton!
    weak var preButton: UIButton!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        viewModel = CalendarViewModel(delegate: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        calendarView = CalendarView(vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.updateTimeData()
    }
    
    @objc func onWeekChangedChick(_ sender: UIButton) {
        viewModel.checkAndupdateWeek(isNext: sender === nextButton)
    }

}

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfDay
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell{
            cell.setup(vm: viewModel.getCollectionViewCellVM(index: indexPath.row))
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}

extension CalendarViewController: CalendarViewDelegate {
    func updateData() {
        calendarHeaderView.setup(time: viewModel.headerString, index: viewModel.weekOffset)
        collectionView.reloadData()
    }

}

