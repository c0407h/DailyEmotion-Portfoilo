//
//  CaledarViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/27.
//

import UIKit
import FSCalendar


class CaledarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var calendar: FSCalendar!
    
    let selectListViewModel = CalendarViewModel()
    
    var header : calendarHeader!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        calendarView()
        self.view.addSubview(calendar)
        
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor.blue
        
        calendar.delegate = self
        calendar.dataSource = self

        
        

        // Do any additional setup after loading the view.
    }
    //MARK: - Delegate
//    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition){
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YYYY년 MM월"
//    }
    
    //MARK: - dataSource

    // 날짜 선택 시 콜백 메소드
    // 날짜 선택 클릭 이벤트
    public func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        
        let dateFormatterCompare = DateFormatter()
        dateFormatterCompare.dateFormat = "yyyy-MM-dd"
        
        
        print(dateFormatter.string(from: date))
        header.calendarSelectDate.text = dateFormatter.string(from: date)
        
        
    }

    
    func calendarView() {
        calendar.scrollDirection = .vertical
        calendar.locale = Locale(identifier:  "Ko")
        calendar.appearance.todayColor = .systemRed
        calendar.appearance.titleTodayColor = .label
        calendar.appearance.headerDateFormat = "YYYY년 MM월"

        calendar.appearance.headerTitleFont = UIFont(name: "Kyobo Handwriting 2019", size: 17)
        calendar.appearance.weekdayFont = UIFont(name: "Kyobo Handwriting 2019", size: 17)
        calendar.appearance.titleFont = UIFont(name: "Kyobo Handwriting 2019", size: 12)
        calendar.allowsMultipleSelection = false
        
    }
 

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    

}

extension CaledarViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return selectListViewModel.numOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarListCell", for: indexPath) as? CalendarListCell else {
            return UICollectionViewCell()
        }
        return cell
            
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "calendarHeader", for: indexPath) as? calendarHeader
            
            guard let section = CalendarViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            var today = NSDate()
            let dateFormatterToday = DateFormatter()
            dateFormatterToday.dateFormat = "MM월 dd일"
            
            
            header.calendarSelectDate.text = dateFormatterToday.string(from: today as Date)
            

            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    
}
// 컬렉션뷰 사이즈 레이아웃
extension CaledarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 70
        return CGSize(width: width, height: height)
    }
}

class CalendarListCell: UICollectionViewCell{
    @IBOutlet var DescriptionLabel: UILabel!
    @IBOutlet var myEmotion: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    func reset() {
        // TODO: reset로직 구현
        
    }
}

class calendarHeader: UICollectionReusableView {
    
    @IBOutlet var calendarSelectDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
