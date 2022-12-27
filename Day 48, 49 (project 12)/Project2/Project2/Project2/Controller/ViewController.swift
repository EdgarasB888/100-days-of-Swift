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
    var highScore = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if defaults.hasValue(forKey: "highScore") {
            highScore = defaults.integer(forKey: "highScore")
        } else {
            print("Nothing for key highScore")
            defaults.set(0, forKey: "highScore")
        }
        
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
        let defaults = UserDefaults.standard
        
        if defaults.hasValue(forKey: "highScore") {
            highScore = defaults.integer(forKey: "highScore")
        } else {
            print("Nothing for key highScore")
            defaults.set(0, forKey: "highScore")
        }
        
        questionsAskedCount = 0
        score = 0
        askQuestion()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton)
    {
        var title: String
        let defaults = UserDefaults.standard
        
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
            if score > highScore {
                let ac = UIAlertController(title: "Congratulations!", message: "You have surpassed your high score!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
                    defaults.set(self.score, forKey: "highScore")
                    
                    let ac2 = UIAlertController(title: title, message: "Your final score is \(self.score)", preferredStyle: .alert)
                    ac2.addAction(UIAlertAction(title: "Restart", style: .default, handler: self.restartGame(action:)))
                    ac2.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                    self.present(ac2, animated: true)
                }))
                present(ac, animated: true)
            } else {
                let ac2 = UIAlertController(title: title, message: "Your final score is \(self.score)", preferredStyle: .alert)
                ac2.addAction(UIAlertAction(title: "Restart", style: .default, handler: self.restartGame(action:)))
                ac2.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                self.present(ac2, animated: true)
            }
            
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
        let title = """
        Your score is \(score)
        High score is \(highScore)
        """
        
        let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
}

extension UserDefaults {
    func hasValue(forKey key: String) -> Bool {
        return nil != object(forKey: key)
    }
}


