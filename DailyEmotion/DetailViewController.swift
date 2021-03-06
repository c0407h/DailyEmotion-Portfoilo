//
//  DetailViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/13.
//

import UIKit
class DetailViewController: UIViewController {

    
    @IBOutlet var detailTextView: UITextView!
    var detailViewText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        detailTextView.layer.borderWidth = 1.0
        detailTextView.layer.borderColor = UIColor.systemFill.cgColor
        detailTextView.layer.cornerRadius = 10
        detailTextView.isEditable = false
        
        detailTextView.text = detailViewText
        
        print(detailViewText)
        
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
