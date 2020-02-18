//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Boris Nikolaev Borisov on 17/02/2020.
//  Copyright © 2020 Boris Nikolaev Borisov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var numberOfQuestionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonsStyles()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        askQuestion()
    }
    
    private func setButtonsStyles() {
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()) Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        numberOfQuestionsAsked += 1
        showAnswerAlert(title, endGame: numberOfQuestionsAsked < 10)

    }
    
    fileprivate func setAlertProperties(_ endGame: Bool, _ message: inout String, _ actionTitle: inout String) {
        if (endGame) {
            message = "Your score is \(score)."
            actionTitle = "Continue"
        } else {
            message = "Game Over. Your final score is \(score)."
            actionTitle = "Begin Again"
            score = 0
            numberOfQuestionsAsked = 0
        }
    }
    
    func showAnswerAlert(_ title: String, endGame: Bool) {
        var message = ""
        var actionTitle = ""
        
        setAlertProperties(endGame, &message, &actionTitle)
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: actionTitle, style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

