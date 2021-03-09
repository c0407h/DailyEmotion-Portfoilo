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
    var isToday: Bool
    
    mutating func update(isDone: Bool, detail: String, isToday: Bool) {
        // TODO: update 로직 추가
        
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        // TODO: 동등 조건 추가
        return true
    }
}

class EmotionManager {
    
    static let shared = EmotionManager()
    
    static var lastId: Int = 0
    
    var emotions: [Emotion] = []
    
    func createEmotion(detail: String, isToday: Bool) -> Emotion {
        //TODO: create로직 추가
        return Emotion(id: 1, isDone: false, detail: "2", isToday: true)
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
        return emotions.filter { $0.isToday == true }
    }
    
    var beforeEmotions: [Emotion] {
        return emotions.filter { $0.isToday == false }
    }
    
    var numOfSection: Int {
        return Section.allCases.count
    }
    func loadTasks() {
        manager.retrieveEmotion()
    }
}
