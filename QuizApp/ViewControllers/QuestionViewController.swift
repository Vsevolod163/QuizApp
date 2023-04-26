//
//  ViewController.swift
//  QuizApp
//
//  Created by Vsevolod Lashin on 26.04.2023.
//

import UIKit

final class QuestionViewController: UIViewController {

    @IBOutlet var buttonsStackVIew: UIStackView!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var flagImage: UIImageView!
    
    private let questions = Question.getQuestions().shuffled()
    private var questionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsUI()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        nextQuestion()
    }
    
    private func setButtonsUI() {
        guard let buttons = buttonsStackVIew.arrangedSubviews as? [UIButton] else { return }
        
        for button in buttons {
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    private func updateUI() {
        guard let buttons = buttonsStackVIew.arrangedSubviews as? [UIButton] else { return }
        
        for (button, answer) in zip(buttons, questions[questionIndex].answers) {
            button.setTitle(answer, for: .normal)
        }
        
        let progress = Float(questionIndex) / Float(questions.count)
        progressView.setProgress(progress, animated: true)
        
        let flag = questions[questionIndex].flag
        flagImage.image = UIImage(named: flag)
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        }
    }
}

