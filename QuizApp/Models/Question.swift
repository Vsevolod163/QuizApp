//
//  Question.swift
//  QuizApp
//
//  Created by Vsevolod Lashin on 26.04.2023.
//


struct Question {
    let flag: String
    let answers: [String]
    let rightAnswer: String
    
    static func getQuestions() -> [Question] {
        [
            Question(
                flag: "Russia",
                answers: ["Иран", "Турция", "Россия", "Китай"],
                rightAnswer: "Россия"
            )
        ]
    }
}
