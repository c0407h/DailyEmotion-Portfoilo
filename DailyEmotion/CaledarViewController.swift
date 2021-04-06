//
//  CaledarViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/27.

import UIKit
import FSCalendar

class CaledarViewController: UIViewController, FSCalendarDelegate, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var calendar: FSCalendar!
    
    let selectListViewModel = EmotionViewModel()
    var ddd: [Emotion] = []
    var header : calendarHeader!
    
    override func viewDidLoad() {
    
//        ddd = selectListViewModel.todayEmotions
//
//        selectListViewModel.loadTasks()
     
        
        super.viewDidLoad()
        collectionView.delegate = self
        
        calendarView()
        self.view.addSubview(calendar)
        
        calendar.calendarWeekdayView.weekdayLabels[0].textColor = UIColor.red
        calendar.calendarWeekdayView.weekdayLabels[6].textColor = UIColor.blue

        calendar.delegate = self
        calendar.dataSource = self
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        collectionView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? CalendarDetailViewController else {
            return
        }
        
        guard let indexp: [IndexPath]? = collectionView.indexPathsForSelectedItems else {
            return
        }
        
        //디테일 페이지로 글 넘겨주는 것.
        var cc = (collectionView.cellForItem(at: indexp![0]) as? CalendarListCell)
        nextViewController.calendarDetailText = cc?.DescriptionLabel.text

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
        //View화면에서 섹션헤더부분 날자 포멧
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        
        //선택 날자에 따른 data를 가져오기 위한 날자 포멧
        let dateFormatterCompare = DateFormatter()
        dateFormatterCompare.dateFormat = "yyyy-MM-dd"
        
        print(dateFormatterCompare.string(from: date))
        print(dateFormatter.string(from: date))

        header.calendarSelectDate.text = dateFormatter.string(from: date)
        
//        let ccc = selectListViewModel.emotions.filter { $0.isToday == dateFormatterCompare.string(from: date) }
        
        ddd = selectListViewModel.selectDateEmotions(dateFormatterCompare.string(from: date))
        
        for dd in ddd {
            print(dd.id)
            print(dd.detail)
        }
        
        
        
        self.collectionView.reloadData()
        
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
        
        calendar.appearance.eventDefaultColor = UIColor.red
            
    }
 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //뒤로가기
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
}
extension CaledarViewController: FSCalendarDataSource{
    //캘린더 날자별 글 등록시 해당 날자 밑 도트 추가
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        // json에 있는 데이터 중 isToday 인 날자들을 집어 넣기 위해 빈배열 생성
        var alldate: Set<String> = []
        //selectListViewModel.emotions json에 저장된것들을 모두 가져옴
        let aaa = selectListViewModel.emotions
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // string으로 되어있는 포멧을 date 포멧으로 변경
        let isTodayDate = dateFormatter.string(from: date)
        
        
        for aa in aaa {
            alldate.insert(aa.isToday)
        }
        
        if alldate.contains(isTodayDate){
            return 1
        }
        
        return 0
    }
}

extension CaledarViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return selectListViewModel.numOfSelectSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return ddd.count
        }else{
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarListCell", for: indexPath) as? CalendarListCell else {
            return UICollectionViewCell()
        }
         
        var emotion: Emotion
       
        if indexPath.section == 0 {
            emotion = ddd [indexPath.item]
        } else {
            emotion = selectListViewModel.beforeEmotions [indexPath.item]
        }
        cell.updateUI(selectDate: emotion)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "calendarHeader", for: indexPath) as? calendarHeader
            
            guard let section = EmotionViewModel.Section(rawValue: indexPath.section) else {
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
extension CaledarViewController:  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 70
        return CGSize(width: width, height: height)
    }
}

class CalendarListCell: UICollectionViewCell{
    @IBOutlet var DescriptionLabel: UILabel!
    @IBOutlet var myEmotion: UILabel!
    
    var header : calendarHeader!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
   
    func updateUI(selectDate: Emotion){
        DescriptionLabel.text = selectDate.detail
        
        if selectDate.isSad {
            myEmotion.text = "😥"
            DescriptionLabel.shadowColor = .systemPurple
        } else if selectDate.isBad{
            myEmotion.text = "😔"
            DescriptionLabel.shadowColor = .systemBlue
        } else if selectDate.isUsually{
            myEmotion.text = "😶"
            DescriptionLabel.shadowColor = .systemFill
        } else if selectDate.isPleasure{
            myEmotion.text = "😍"
            DescriptionLabel.shadowColor = .systemRed
        } else if selectDate.isHappy{
            myEmotion.text = "😁"
            DescriptionLabel.shadowColor = .systemGreen
        }else {
            myEmotion.text = "😶"
            DescriptionLabel.shadowColor = .systemFill
        }
    }
}

class calendarHeader: UICollectionReusableView {
    
    @IBOutlet var calendarSelectDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
