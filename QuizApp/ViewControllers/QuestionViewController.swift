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
    
    private var questions = Question.getQuestions().shuffled()
    private var questionIndex = 0
    private let countOfQuestions = 10
    private var timerIsOn = false
    private var countOfRightAnswers = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonsUI()
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        
        resultVC.countOfRightAnswers = countOfRightAnswers
        resultVC.countOfQuestions = countOfQuestions
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        questionIndex = 0
        countOfRightAnswers = 0
        questions = questions.shuffled()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        guard let buttons = buttonsStackVIew.arrangedSubviews as? [UIButton] else { return }
        guard !timerIsOn else { return }
        
        timerIsOn = true
        let question = questions[questionIndex]
        
        if sender.currentTitle == question.rightAnswer {
            sender.backgroundColor = .green
            countOfRightAnswers += 1
        } else {
            sender.backgroundColor = .red
        }
        
        for button in buttons {
            if button.currentTitle == question.rightAnswer && button.backgroundColor != .green {
                button.backgroundColor = .green
                break
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { timer in
            self.timerIsOn = false
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
        
        let question = questions[questionIndex]
        
        for (button, answer) in zip(buttons, question.answers) {
            button.backgroundColor = .systemBlue
            button.setTitle(answer, for: .normal)
        }
        
        let progress = Float(questionIndex) / Float(countOfQuestions)
        progressView.setProgress(progress, animated: true)
        
        let flag = question.flag
        flagImage.image = UIImage(named: flag)
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < countOfQuestions {
            updateUI()
        } else {
            performSegue(withIdentifier: "showResult", sender: nil)
        }
    }
}

