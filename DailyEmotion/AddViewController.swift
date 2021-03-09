//
//  AddViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/09.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet var addTextView: UITextView!
    
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

        addTextView.text = "내용을 입력해주세요."

        addTextView.textColor = UIColor.lightGray

      }

    }
    
}

