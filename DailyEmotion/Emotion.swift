//
//  Emotion.swift
//  DailyEmotion
//
//  Created by 이충현 on 2021/03/08.
//

import UIKit

struct Emotion: Codable, Equatable {
    let id: Int
    var isDone: Bool
    var detail: String
    var isBad: Bool
    var isSad: Bool
    var isUsually: Bool
    var isPleasure: Bool
    var isHappy: Bool
    var isToday: String
    
    
    mutating func update(isDone: Bool, detail: String, isToday: String) {
        // TODO: update 로직 추가
        self.detail = detail
        self.isToday = isToday
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        // TODO: 동등 조건 추가
        return lhs.id == rhs.id
    }
    

}

class EmotionManager {
    
    static let shared = EmotionManager()
    
    static var lastId: Int = 0
    
    var emotions: [Emotion] = []
    

    
    func createEmotion(detail: String, isBad: Bool, isSad: Bool, isUsually: Bool, isPleasure: Bool, isHappy: Bool, isToday: String) -> Emotion {
        //TODO: create로직 추가
        let nextId = EmotionManager.lastId + 1
        EmotionManager.lastId = nextId
        
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let isTodayDate = dateFormatter.string(from: today as Date)
                
        return Emotion(id: nextId, isDone: false, detail: detail, isBad: isBad, isSad: isSad, isUsually: isUsually, isPleasure: isPleasure, isHappy: isHappy, isToday: isTodayDate)

    }
    
    func addEmotion(_ emotion: Emotion) {
        emotions.append(emotion)
        saveEmotion()
    }
    func deleteEmotion(_ emotion: Emotion){
        emotions = emotions.filter { $0.id != emotion.id}
        saveEmotion()
    }
    
    func saveEmotion() {
        Storage.store(emotions, to: .documents, as: "emotions.json")
    }
    
    func retrieveEmotion() {
        emotions = Storage.retrive("emotions.json", from: .documents, as: [Emotion].self) ?? []
        
        let lastId = emotions.last?.id ?? 0
        EmotionManager.lastId = lastId
    }
}

class EmotionViewModel {
    enum Section: Int, CaseIterable {
        case today
        case before
        
        var title: String {
            switch self {
            case .today: return "오늘"
            default: return "이전"
            }
        }
    }
    
    
    private let manager = EmotionManager.shared
    
    var emotions: [Emotion] {
        return manager.emotions
    }
    
    var todayEmotions: [Emotion] {
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let isTodayDate = dateFormatter.string(from: today as Date)
        
        return emotions.filter { $0.isToday ==  isTodayDate }
    }
    var beforeEmotions: [Emotion] {
        let today = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let isTodayDate = dateFormatter.string(from: today as Date)
        
        return emotions.filter { $0.isToday !=  isTodayDate }
    }
    
    func addEmotion(_ emotion: Emotion) {
        manager.addEmotion(emotion)
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    func loadTasks() {
        manager.retrieveEmotion()
    }
    func deleteEmotion(_ emotion: Emotion){
        manager.deleteEmotion(emotion)
    }
}
