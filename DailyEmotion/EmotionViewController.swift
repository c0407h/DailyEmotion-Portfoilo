//
//  EmotionViewController.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/08.
//

import UIKit

class EmotionViewController: UIViewController{
    

    @IBOutlet weak var collectionView: UICollectionView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: 키보드 디텍션
        
        
        // TODO: 데이터 불러오기
        
    }
    

    // TODO: BG 탭했을때, 키보드 내려오게 하기
}

extension EmotionViewController {
    @objc private func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        // TODO: 키보드 높이에 따른 인풋뷰 위치 변경
        
    }
}

extension EmotionViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // TODO: 섹션 몇개
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO: 섹션별 아이템 몇개
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // TODO: 커스텀 셀
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmotionListCell", for: indexPath) as? EmotionListCell else {
            return UICollectionViewCell()
        }
        return cell
        
        // TODO: todo 를 이용해서 updateUI
        // TODO: doneButtonHandler 작성
        // TODO: deleteButtonHandler 작성
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
        // TODO: 사이즈 계산하기
        let width: CGFloat = collectionView.bounds.width
        let height: CGFloat = 50
        return CGSize(width: width, height: height)
    }
}

class EmotionListCell: UICollectionViewCell {
    

    @IBOutlet weak var myEmotion: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func updateUI(emotion: Emotion) {
        // TODO: 셀 업데이트 하기

    }
    

    
    func reset() {
        // TODO: reset로직 구현
        
    }
    

}


class EmotionListHeaderView: UICollectionReusableView {
    

    @IBOutlet weak var sectionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
