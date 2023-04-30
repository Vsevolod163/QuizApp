//
//  ViewController.swift
//  QuizApp
//
//  Created by Vsevolod Lashin on 26.04.2023.
//

import UIKit

final class QuestionViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private var buttonsStackVIew: UIStackView!
    @IBOutlet private var progressView: UIProgressView!
    @IBOutlet private var imageView: UIImageView!
    
    var questions: [Question]!
    
    // MARK: - Private properties
    private var questionIndex = 0
    private let countOfQuestions = 10
    private var timerIsOn = false
    private var countOfRightAnswers = 0
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Вопрос \(questionIndex + 1) из \(countOfQuestions)"
        updateUI()
    }
    
    override func viewWillLayoutSubviews() {
        guard let buttons = buttonsStackVIew.arrangedSubviews as? [UIButton] else { return }
        
        for button in buttons {
            button.layer.cornerRadius = button.frame.height / 5
        }
        
        imageView.layer.cornerRadius = imageView.frame.height / 15
        imageView.layer.borderWidth = 0.5
    }
    
    // MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        
        resultVC.countOfRightAnswers = countOfRightAnswers
        resultVC.countOfQuestions = countOfQuestions
    }
    
    // MARK: - IBActions
    @IBAction private func answerButtonPressed(_ sender: UIButton) {
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
    
    // MARK: - Private functions
    private func updateUI() {
        guard let buttons = buttonsStackVIew.arrangedSubviews as? [UIButton] else { return }
        
        let question = questions[questionIndex]
        
        for (button, answer) in zip(buttons, question.answers) {
            button.backgroundColor = .systemBlue
            button.setTitle(answer, for: .normal)
        }
        
        let progress = Float(questionIndex) / Float(countOfQuestions)
        progressView.setProgress(progress, animated: true)
        
        let image = question.image
        imageView.image = UIImage(named: image)
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

