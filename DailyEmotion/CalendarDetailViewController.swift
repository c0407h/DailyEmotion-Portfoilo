//
//  CalendarDetailViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/04/02.
//

import UIKit

class CalendarDetailViewController: UIViewController {

    @IBOutlet var calendarDetail: UITextView!
    var calendarDetailText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        calendarDetail.layer.borderWidth = 1.0
        calendarDetail.layer.borderColor = UIColor.systemFill.cgColor
        calendarDetail.layer.cornerRadius = 10
        calendarDetail.isEditable = false
        
        calendarDetail.text = calendarDetailText

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        

    }

    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
