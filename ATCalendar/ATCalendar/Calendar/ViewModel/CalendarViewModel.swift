//
//  CalendarViewModel.swift
//  ATCalendar
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

protocol CalendarViewDelegate: NSObjectProtocol {
    func updateData()
}

enum WeekdayType: String, CaseIterable {
    case SUN, MON, TUE, WED, THU, FRI, SAT
    
    var title: String {
        return rawValue.toLocalize()
    }
}

class CalendarViewModel: NSObject, BookingDatable {
    
    let hintString = "TIME_HINT".toLocalize(paremers: TimeZone.zoneExpressGMT)
    let segmentStrings = ["<", ">"]
    var currentDate = Date()
    
    var cellSize: CGSize = .zero
    var weedayBooingData: [WeekDayBookingStatus] = []
    var headerDatas: [HeaderData] = []
    unowned var calendarDelegate: CalendarViewDelegate
    
    var weekOffset: Int = 0
    
    var numberOfDay: Int {
        return headerDatas.count
    }
    
    var headerString: String {
        return (headerDatas.first?.date.yyyyMMddTime ?? "") + "-" + (headerDatas.last?.date.ddTime ?? "")
    }
    
    init(delegate: CalendarViewDelegate) {
        calendarDelegate = delegate
        super.init()
        initialize()
    }
    
    //MARK: private function
    private func initialize() {
        WeekdayType.allCases.forEach { type in
            weedayBooingData.append(WeekDayBookingStatus(day: type, availableTime: [], bookedTime: []))
            headerDatas.append(HeaderData(date: currentDate))
        }
        let w = (kScreenW-2*kOffset-CGFloat(numberOfDay-1)*5)/CGFloat(numberOfDay)
        let h = (kScreenH-kSafeAreaHeight)/8*7 - kOffset
        cellSize = CGSize(width: w, height: h)
    }
    
    private func classifyBookinData(data: BookingData) {
        data.available.forEach { _ava in
            spliteDataToHalfHour(format: _ava)
        }
        
        data.booked.forEach { _book in
            spliteDataToHalfHour(format: _book, ava: false)
        }
        
        weedayBooingData.forEach {
            $0.sortTime()
        }
    }
    
    private func spliteDataToHalfHour(format: TimeFormat, ava: Bool = true){
        let start = format.start.toDate
        let end = format.end.toDate

        var tempTime = start.timeIntervalSince1970
        var times: [Date] = []
        times.append(start)
        let halfTimeStamp: TimeInterval = 1800
        
        while tempTime + halfTimeStamp < end.timeIntervalSince1970 {
            let date = Date(timeIntervalSince1970: tempTime+halfTimeStamp)
            tempTime = date.timeIntervalSince1970
            times.append(date)
        }
        

        times.forEach { time in
            let day = WeekdayType.allCases[time.weekDay]
            _ = weedayBooingData.filter({$0.day == day}).map({
                if ava {
                    $0.availableTime.append(time)
                } else {
                    $0.bookedTime.append(time)
                }
            })
        }
    }
    
    private func getSelectedWeekdays(offset: Int) -> [Date] {
        let calendar = Calendar.current
        let aimDate = currentDate.addingTimeInterval(Double(offset * 7 * 60 * 60 * 24))
        let today = calendar.startOfDay(for: aimDate)
        let dayOfWeek = calendar.component(.weekday, from: today)
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: today)!
        let days = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: today) }
        return days
    }
    
    //MARK: public function
    func updateTimeData() {
        weedayBooingData.forEach {
            $0.clearData()
        }
        headerDatas = getSelectedWeekdays(offset: weekOffset).map{ data -> HeaderData in
            return HeaderData(date: data)
        }
        fetchBookingData()
    }
    
    func fetchBookingData() {
        getBookingData(success: { data in
            classifyBookinData(data: data)
            calendarDelegate.updateData()
        }, fail: { error in
            print(error)
        })
    }
    
    func checkAndupdateWeek(isNext add: Bool) {
        if add {
            weekOffset += 1
        } else if weekOffset > 0 {
            weekOffset -= 1
        }
        updateTimeData()
    }
    
    func getCollectionViewCellVM(index: Int) -> CollectionViewCellViewModel {
        let headerData = headerDatas[index]
        let passed = headerData.date.weekDay < currentDate.weekDay && weekOffset == 0
        let passVM = CollectionViewCellViewModel(bookingData: weedayBooingData[index], headerData: headerData, passed: passed)
        return passVM
    }

}
