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
    private let countOfQuestions = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsUI()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let buttons = buttonsStackVIew.arrangedSubviews as? [UIButton] else { return }
        
        for button in buttons {
            if button.currentTitle == questions[questionIndex].rightAnswer {
                button.backgroundColor = .green
            }
        }
        
        sender.backgroundColor = sender.currentTitle == questions[questionIndex].rightAnswer
        ? .green
        : .red
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.nextQuestion()
        }
    
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
            button.backgroundColor = .systemBlue
            button.setTitle(answer, for: .normal)
        }
        
        let progress = Float(questionIndex) / Float(countOfQuestions)
        progressView.setProgress(progress, animated: true)
        
        let flag = questions[questionIndex].flag
        flagImage.image = UIImage(named: flag)
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < countOfQuestions {
            updateUI()
        }
    }
}

