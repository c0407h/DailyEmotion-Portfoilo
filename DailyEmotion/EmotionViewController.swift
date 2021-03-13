//
//  EmotionViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/08.
//

import UIKit
import SwipeCellKit


var emotionImage = ["🟦","🟪","⬛️","🟩","🟥"]

class EmotionViewController: UIViewController{
    @IBOutlet weak var collectionView: UICollectionView!
        
    let emotionListViewModel = EmotionViewModel()
  
    override func viewDidLoad() {
          super.viewDidLoad()

          emotionListViewModel.loadTasks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        collectionView.reloadData()
    }
    
    
    //pod
    
    
    
    
 
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
        let height: CGFloat = 30
        return CGSize(width: width, height: height)
    }
}

class EmotionListCell: UICollectionViewCell {

    @IBOutlet weak var myEmotion: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet var deleteButton: UIButton!

    
    var deleteButtonTapHandler: (() -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
   
    @IBAction func cellSetting(_ sender: UIBarButtonItem) {
        deleteButton.isHidden = false
    }
    
    
    func updateUI(emotion: Emotion) {
        
        descriptionLabel.text = emotion.detail
        dateLabel.text = emotion.isToday
        
        if emotion.isSad {
            myEmotion.text = "🟪"
        } else if emotion.isBad{
            myEmotion.text = "🟦"
        } else if emotion.isUsually{
            myEmotion.text = "⬛️"
        } else if emotion.isPleasure{
            myEmotion.text = "🟩"
        } else if emotion.isHappy{
            myEmotion.text = "🟥"
        }else {
            myEmotion.text = "⬛️"
        }
    }
    
    func reset() {
        descriptionLabel.alpha = 1
        deleteButton.isHidden = false
    }
    @IBAction func deleteButtonTapped(_ sender: Any) {
        print("삭제가되나요")
        //여기 얼럿을 띄워 삭제할건지 물어보기
        
        deleteButtonTapHandler?()
    }
    

}


class EmotionListHeaderView: UICollectionReusableView {
    

    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
