//
//  ViewController.swift
//  Milestones7-9
//
//  Created by Edgaras Blauzdys on 2022-12-08.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var wordToGuessTextField: UITextField!
    @IBOutlet var allButtons: [UIButton]!
    
    var englishAlphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    var wordsToGuess = ["dog", "cat", "mouse", "letter", "house", "vehicle", "microwave"]
    //var wordsToGuess = ["dog"]
    
    /*
    var wordsToGuess =
    [
        "animal": "dog",
        "animal": "cat"
    ]
     */
     
    
    var currentWord = ""
    var stringToShow = ""
    
    var stepsTillDeath = 11
    var score = 0
    {
        didSet
        {
            scoreLabel.text = "Score: \(score)"
        }
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        wordToGuessTextField.isEnabled = false
        
        setupButtons()
        pickWord()
    }
    
    func setupButtons() {
        englishAlphabet.shuffle()
        
        var buttonIndex = 0
        for button in allButtons {
            button.setTitle(englishAlphabet[buttonIndex].uppercased(), for: .normal)
            button.isHidden = false
            button.isEnabled = true
            
            buttonIndex += 1
        }
        
        self.view.layoutIfNeeded()
    }
    
    func pickWord()
    {
        wordsToGuess.shuffle()
        stepsTillDeath = 11
        
        if(wordsToGuess.count == 0)
        {
            if self.presentedViewController==nil
            {
                let ac = UIAlertController(title: "Congratulations!", message: "You have successfully guessed all words!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart", style: .default, handler:
                {
                    [weak self] action in
                    self?.restartGame()
                }))
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async
                {
                    self.present(ac, animated: true)
                }
            }
        }
        else
        {
            currentWord = wordsToGuess[0]
            
            wordsToGuess.remove(at: 0)
           
            stringToShow = ""
            
            for _ in currentWord
            {
                stringToShow += "?"
            }
            
            wordToGuessTextField.text = stringToShow
        }
    }
    
    func restartGame()
    {
        stepsTillDeath = 11
        score = 0
        
        wordsToGuess = ["dog", "cat", "mouse", "letter", "house", "vehicle", "microwave"]
        
        pickWord()
        setupButtons()
    }
    
    @IBAction func letterButtonTapped(_ sender: UIButton)
    {
        let buttonTitle = (sender.titleLabel?.text)!.lowercased()
        
        sender.isEnabled = false
        sender.titleLabel?.textColor = .red
        
        var index = 0
        var letterPresentInWord = false
        for letter in currentWord
        {
            if String(letter) == buttonTitle
            {
                stringToShow = stringToShow.replace(buttonTitle.uppercased(), at: index)
                print(stringToShow)
                
                letterPresentInWord = true
            }
            index += 1
        }
        
        if(letterPresentInWord == false)
        {
            stepsTillDeath -= 1
            if(stepsTillDeath == 1)
            {
                let ac = UIAlertController(title: "Unlucky!", message: "Your game is over!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Restart", style: .default, handler:
                { [weak self] action in
                    self?.restartGame()
                }))
                present(ac, animated: true)
            }
        }
        if(stringToShow.lowercased() == currentWord)
        {
            showBasicAlertController(title: "Congratulations!", message: "You correctly guessed the word \(currentWord)!")
            
            score += 1
            
            pickWord()
            setupButtons()
            
            return
        }
        
        wordToGuessTextField.text = stringToShow
    }
    
    func showBasicAlertController(title: String, message: String)
    {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

extension String
{
    func replace(_ with: String, at index: Int) -> String {
        var modifiedString = String()
        for (i, char) in self.enumerated() {
            modifiedString += String((i == index) ? with : String(char))
        }
        return modifiedString
    }
}
