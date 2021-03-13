//
//  DetailViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/13.
//

import UIKit

class DetailViewController: UIViewController {
    var receiveItem = ""
    
    @IBOutlet var detailTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailTextView.text = receiveItem
        
        detailTextView.layer.borderWidth = 1.0
        detailTextView.layer.borderColor = UIColor.systemFill.cgColor
        detailTextView.layer.cornerRadius = 10
        detailTextView.isEditable = false
    }
    func receiveItem(_ item: String){
        receiveItem = item
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
