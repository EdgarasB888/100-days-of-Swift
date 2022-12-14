//
//  ViewController.swift
//  Project2
//
//  Created by Edgaras Blauzdys on 2022-11-24.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAskedCount = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Score", style: .done, target: self, action: #selector(showScore))
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil)
    {
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        
        questionsAskedCount += 1
    }
    
    func restartGame(action: UIAlertAction! = nil)
    {
        questionsAskedCount = 0
        score = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        var title: String
        
        if sender.tag == correctAnswer
        {
            title = "Correct"
            score += 1
        }
        else
        {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        if(questionsAskedCount == 10)
        {
            let ac = UIAlertController(title: title, message: "Your final score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartGame(action:)))
            ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            present(ac, animated: true)
            
            button1.isEnabled = false
            button2.isEnabled = false
            button3.isEnabled = false
        }
        else
        {
            let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion(action:)))
            present(ac, animated: true)
        }
    }
    
    @objc func showScore()
    {
        let ac = UIAlertController(title: "Your score is \(score)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}

