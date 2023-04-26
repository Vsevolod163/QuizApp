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
        let shared = Answer.shared
        let allAnswers = shared.answers.shuffled()
        
        var result: [Question] = []
        var indexOfAnswer = 0
        
        for _ in allAnswers {
            let rightAnswer = allAnswers[indexOfAnswer]
            var wrongAnswers: [String] = []
            
            while wrongAnswers.count < 3 {
                let wrongAnswer = allAnswers.randomElement() ?? ""
                
                if !wrongAnswers.contains(wrongAnswer) && !wrongAnswer.contains(rightAnswer) {
                    wrongAnswers.append(wrongAnswer)
                }
            }
            
            result.append(
                Question(
                    flag: rightAnswer,
                    answers: [
                        rightAnswer,
                        wrongAnswers[0],
                        wrongAnswers[1],
                        wrongAnswers[2]
                    ]
                        .shuffled(),
                    rightAnswer: rightAnswer
                )
            )
            
            indexOfAnswer += 1
        }
        
        return result
    }
}
