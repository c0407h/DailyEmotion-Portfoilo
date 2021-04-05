//
//  EmotionViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/08.
//

import UIKit
import SwipeCellKit
import GoogleMobileAds

class EmotionViewController: UIViewController, SwipeCollectionViewCellDelegate, GADBannerViewDelegate{
    
    var bannerView: GADBannerView!
    
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {

        guard orientation == .right else { return nil }

         let deleteAction = SwipeAction(style: .destructive, title: "삭제") { action, indexPath in
            
            (self.collectionView.cellForItem(at: indexPath) as? EmotionListCell)?.deleteButtonTapHandler?()
         
         }
          deleteAction.image = UIImage(named: "delete")

         return [deleteAction]
       
    }
    
    
    @IBOutlet var addBtnView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
        
    let emotionListViewModel = EmotionViewModel()
     
    override func viewDidLoad() {
        
        emotionListViewModel.loadTasks()
          super.viewDidLoad()
        
        addBtnView.layer.cornerRadius = addBtnView.frame.width / 2
        addBtnView.layer.cornerRadius = addBtnView.frame.height / 2
        addBtnView.layer.shadowOpacity = 1
        addBtnView.layer.shadowOffset = CGSize(width: 3, height: 3)
        addBtnView.layer.shadowRadius = 10
        addBtnView.layer.masksToBounds = false
        addBtnView.layer.shadowColor = UIColor.systemGray2.cgColor

        
        DispatchQueue.main.async {
            let plist = UserDefaults.standard
            let darkModeSelect = plist.integer(forKey: "darkModeSelect")
            
            if darkModeSelect == 0 {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .unspecified
                    self.addBtnView.layer.shadowColor = UIColor.systemGray2.cgColor
                }
            } else if darkModeSelect == 1 {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .light
                    self.addBtnView.layer.shadowColor = UIColor.systemGray2.cgColor
                }
            } else {
                UIApplication.shared.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                    self.addBtnView.layer.shadowColor = UIColor.systemGray2.cgColor

                }
            }
        }
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
                if launchedBefore
                {
                    print("Not first launch.")
                }
                else
                { 
                    print("First launch")
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                    
                }
        emotionListViewModel.loadTasks()

        //배너 사이즈 설정
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        // 화면에 배너뷰 추가
        addBannerViewToView(bannerView)
        //광고단위 아이디
        bannerView.adUnitID = "ca-app-pub-1400043170071998/2257879909"

        bannerView.rootViewController = self
        //광고로드
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        collectionView.reloadData()
        
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        //오토레이아웃으로 뷰를 설정
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        //루트뷰에 배너를 추가
        view.addSubview(bannerView)
        //앵커설정하여 토레이아웃 설정
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: bottomLayoutGuide,
                              attribute: .top,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController = segue.destination as? DetailViewController else {
            return
        }

        
        guard let indexp: [IndexPath]? = collectionView.indexPathsForSelectedItems else {
            return
        }
        
        var cc = (collectionView.cellForItem(at: indexp![0]) as? EmotionListCell)
        nextViewController.detailViewText = cc?.descriptionLabel.text
        
        
        let selectDate: String = (cc?.dateLabel.text)!

    }
    

    
    //MARK: - GADBannerViewDelegate
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
 
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: NSError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }

    
    
}

extension EmotionViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
    }
}

extension EmotionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return emotionListViewModel.numOfSection
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return emotionListViewModel.todayEmotions.count
        } else {
            return emotionListViewModel.beforeEmotions.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmotionListCell", for: indexPath) as? EmotionListCell else {
            return UICollectionViewCell()
        }
        
        cell.delegate = self
    
        var emotion: Emotion
        if indexPath.section == 0 {
            emotion = emotionListViewModel.todayEmotions[indexPath.item]
        } else {
            emotion = emotionListViewModel.beforeEmotions[indexPath.item]
        }
        cell.updateUI(emotion: emotion)
        
        cell.deleteButtonTapHandler = {
            self.emotionListViewModel.deleteEmotion(emotion)
            self.collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "EmotionListHeaderView", for: indexPath) as? EmotionListHeaderView else {
                return UICollectionReusableView()
            }
            
            guard let section = EmotionViewModel.Section(rawValue: indexPath.section) else {
                return UICollectionReusableView()
            }
            
            header.sectionTitleLabel.text = section.title
            return header
        default:
            return UICollectionReusableView()
        }
    
    }
    
}

extension EmotionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 70
        return CGSize(width: width, height: height)
    }
}








class EmotionListCell: SwipeCollectionViewCell {
    
    @IBOutlet weak var myEmotion: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var deleteButtonTapHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func updateUI(emotion: Emotion) {
        
        descriptionLabel.text = emotion.detail
        dateLabel.text = emotion.isToday
        
        if emotion.isSad {
            myEmotion.text = "😥"
            descriptionLabel.shadowColor = .systemPurple
        } else if emotion.isBad{
            myEmotion.text = "😔"
            descriptionLabel.shadowColor = .systemBlue
        } else if emotion.isUsually{
            myEmotion.text = "😶"
            descriptionLabel.shadowColor = .systemFill
        } else if emotion.isPleasure{
            myEmotion.text = "😍"
            descriptionLabel.shadowColor = .systemRed
        } else if emotion.isHappy{
            myEmotion.text = "😁"
            descriptionLabel.shadowColor = .systemGreen
        }else {
            myEmotion.text = "😶"
            descriptionLabel.shadowColor = .systemFill
        }
    }
    
    func reset() {
        descriptionLabel.alpha = 1
    }
    
}
// MARK: - SwipeCollectionViewCellDelegate
extension EmotionListCell: SwipeCollectionViewCellDelegate{
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

         let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
         
         }
         // customize the action appearance
         deleteAction.image = UIImage(named: "delete")
        
         return [deleteAction]
    }

    //셀액션에 대한 옵션 설정
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .drag
        return options
    }

}

class EmotionListHeaderView: UICollectionReusableView {

    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

