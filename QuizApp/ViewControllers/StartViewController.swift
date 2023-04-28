//
//  StartViewController.swift
//  QuizApp
//
//  Created by Vsevolod Lashin on 28.04.2023.
//

import UIKit

final class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let questionVC = segue.destination as? QuestionViewController else { return }
        
        questionVC.questions = Question.getQuestions(answers: sender as? [String] ?? [""])
    }
    
    @IBAction func themeButtonPressed(_ sender: UIButton) {
        if sender.currentTitle == "Флаги" {
            performSegue(withIdentifier: "showQuestions", sender: Answer.shared.flags)
        } else if sender.currentTitle == "Кино" {
            performSegue(withIdentifier: "showQuestions", sender: Answer.shared.movies)
        }
    }
}
