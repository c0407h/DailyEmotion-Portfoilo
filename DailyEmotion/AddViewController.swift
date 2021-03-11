//
//  AddViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/09.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet var isBad: UIButton!
    @IBOutlet var isSad: UIButton!
    @IBOutlet var isUsually: UIButton!
    @IBOutlet var isPleasure: UIButton!
    @IBOutlet var isHappy: UIButton!
    
    @IBOutlet var addTextView: UITextView!
    let date = Date()
    
    let emotionistViewModel = EmotionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextView.delegate = self
        addTextView.text = """
당신의 오늘 기분은 어떤가요?
누구에게도 털어 놓지 못하는 이야기가 있나요?
편하게 적어봐요 마음이 후련해지고 행복해질때까지
"""
        addTextView.textColor = UIColor.lightGray
        
        addTextView.layer.borderWidth = 1.0
        addTextView.layer.borderColor = UIColor.black.cgColor
        addTextView.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    @IBAction func isBadButtonTapped(_ sender: Any) {
        isBad.isSelected = !isBad.isSelected
        isSad.isSelected = !isSad.isSelected
        isUsually.isSelected = !isUsually.isSelected
        isPleasure.isSelected = !isPleasure.isSelected
        isHappy.isSelected = !isHappy.isSelected
        
    }
    @IBAction func isSadButtonTapped(_ sender: Any) {
        isSad.isSelected = !isSad.isSelected
    }
    @IBAction func isUsuallyButtonTapped(_ sender: Any) {
        isUsually.isSelected = !isUsually.isSelected
    }
    @IBAction func isPleasureButtonTapped(_ sender: Any) {
        isPleasure.isSelected = !isPleasure.isSelected
    }
    @IBAction func isHappyButtonTapped(_ sender: Any) {
        isHappy.isSelected = !isHappy.isSelected
    }
    

    @IBAction func addBtn(_ sender: UIButton) {
//        guard let detail = addTextView.text,
//              detail.isEmpty == false else { return }
        let detail = addTextView.text!
        
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let isTodayDate = dateFormatter.string(from: today as Date)
        
        let emotion = EmotionManager.shared.createEmotion(detail: detail, isBad: isBad.isSelected, isSad: isSad.isSelected, isUsually: isUsually.isSelected, isPleasure: isPleasure.isSelected, isHappy: isHappy.isSelected, isToday: isTodayDate)
        
        if addTextView.text != "" {
            
            if addTextView.text == """
당신의 오늘 기분은 어떤가요?
누구에게도 털어 놓지 못하는 이야기가 있나요?
편하게 적어봐요 마음이 후련해지고 행복해질때까지
"""{            print("아무것도없어요")
                let alert = UIAlertController(title: "등록 실패", message: "내용이 없습니다.", preferredStyle: UIAlertController.Style.alert)
                let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(onAction)
                present(alert, animated: true, completion: nil)
                
            }else{
                addTextView.text = ""
                isSad.isSelected = false
                isBad.isSelected = false
                isUsually.isSelected = false
                isPleasure.isSelected = false
                isHappy.isSelected = false
                
                emotionistViewModel.addEmotion(emotion)
    
                _ = navigationController?.popViewController(animated: true)
            }
            
        } else {
            print("아무것도없어요")
            let alert = UIAlertController(title: "등록 실패", message: "내용이 없습니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(onAction)
            present(alert, animated: true, completion: nil)
            
        }
    }
}


extension AddViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ addTextView: UITextView) {

      if addTextView.textColor == UIColor.lightGray {

        addTextView.text = nil

        addTextView.textColor = UIColor.black

      }
    }

   

    func textViewDidEndEditing(_ addTextView: UITextView) {

      if addTextView.text.isEmpty {

        addTextView.text = """
당신의 오늘 기분은 어떤가요?
누구에게도 털어 놓지 못하는 이야기가 있나요?
편하게 적어봐요 마음이 후련해지고 행복해질때까지
"""
        addTextView.textColor = UIColor.lightGray

      }
    }
}

