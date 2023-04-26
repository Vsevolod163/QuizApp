//
//  Answers.swift
//  QuizApp
//
//  Created by Vsevolod Lashin on 26.04.2023.
//

final class Answer {
    static let shared = Answer()
    
    let answers = [
        "Иран",
        "Турция",
        "Россия",
        "Китай",
        "Израиль",
        "Япония",
        "Португалия",
        "Италия"
    ]
    
    private init() {}
}
