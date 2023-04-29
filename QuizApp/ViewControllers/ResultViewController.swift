//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Vsevolod Lashin on 27.04.2023.
//

import UIKit

final class ResultViewController: UIViewController {
    
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var reloadButton: UIButton!
    
    var countOfRightAnswers: Int!
    var countOfQuestions: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        resultLabel.text = """
            Вы правильно ответили на
            \(countOfRightAnswers ?? 0) из \(countOfQuestions ?? 0) вопросов! ✅
            """
    }
    
    override func viewWillLayoutSubviews() {
        reloadButton.layer.cornerRadius = reloadButton.frame.height / 2
    }
    
    @IBAction private func reloadButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}
