//
//  infoPagingViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/19.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png"]

class infoPagingViewController: UIViewController {
    @IBOutlet var infoImgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = images.count
        
        pageControl.currentPage = 0
        
        pageControl.pageIndicatorTintColor = UIColor.gray
        
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        infoImgView.image = UIImage(named:  images[0])
        

        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(infoPagingViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(infoPagingViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


    @IBAction func pageChange(_ sender: UIPageControl) {
        infoImgView.image = UIImage(named: images[pageControl.currentPage])
    }
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left:
                if (pageControl.currentPage<pageControl.numberOfPages-1) {
                    pageControl.currentPage = pageControl.currentPage + 1
                }
                print("Swiped Left")
            case UISwipeGestureRecognizer.Direction.right:
                if (pageControl.currentPage>0) {
                    pageControl.currentPage = pageControl.currentPage - 1
                }
                print("Swiped Right")
            default:
                break
            }
            
            infoImgView.image = UIImage(named: images[pageControl.currentPage])
        }
    }

    
}
