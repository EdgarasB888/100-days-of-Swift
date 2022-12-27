//
//  TableViewController.swift
//  Project5
//
//  Created by Edgaras Blauzdys on 2022-11-28.
//

import UIKit

class TableViewController: UITableViewController
{
    var allWords = [String]()
    var usedWords = [String]()
    var currentWord = String()
    var first = Bool()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "restart.circle"), style: .plain, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt")
        {
            if let startWords = try? String(contentsOf: startWordsURL)
            {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty
        {
            allWords = ["silkworm"]
        }
        
        first = true
        startGame()
        
        loadArray(key: "usedWords")
        DispatchQueue.main.async
        {
            self.tableView.reloadData()
        }
    }
    
    @objc func startGame()
    {
        loadString(key: "currentWord")
        
        if first == true {
            title = currentWord
        } else {
            title = allWords.randomElement()
        }
        
        first = false
        
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath)
        
        cell.textLabel?.text = usedWords[indexPath.row]
        
        return cell
    }

    @objc func promptForAnswer()
    {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default)
        {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String)
    {
        let lowerAnswer = answer.lowercased()
        
        if(!isSame(word: lowerAnswer))
        {
            if(isPossible(word: lowerAnswer))
            {
                if isOriginal(word: lowerAnswer)
                {
                    if(isReal(word: lowerAnswer))
                    {
                        usedWords.insert(answer, at: 0)
                        save(key: "usedWords", value: usedWords)
                        save(key: "currentWord", value: title as Any)
                        
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        
                        return
                    }
                    else
                    {
                        showErrorMessage(errorTitle: "Word not recognized or less than 3 letters", errorMessage: "You can't just make them up, you know!")
                    }
                }
                else
                {
                    showErrorMessage(errorTitle: "Word already used", errorMessage: "Be more original!")
                }
            }
            else
            {
                showErrorMessage(errorTitle: "Word not possible", errorMessage: "You can't spell that word from \(title!.lowercased()).")
            }
        }
        else
        {
            showErrorMessage(errorTitle: "Word is the same", errorMessage: "You can't use the same orginal word!")
        }
    }
    
    func isPossible(word: String) -> Bool
    {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word
        {
            if let position = tempWord.firstIndex(of: letter)
            {
                tempWord.remove(at: position)
            }
            else
            {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool
    {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool
    {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        //NSNotFound tells us whether a word was spelled correctly
        return misspelledRange.location == NSNotFound && word.count >= 3
    }
    
    func isSame(word: String) -> Bool
    {
        return word == title
    }
    
    func showErrorMessage(errorTitle: String, errorMessage: String)
    {
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func save(key: String, value: Any) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }
    
    func loadArray(key: String) {
        let defaults = UserDefaults.standard
        if defaults.hasValue(forKey: key) {
            usedWords = defaults.object(forKey: key) as? [String] ?? [String]()
            print(usedWords)
        } else {
            print("Cannot load \(key)!")
        }
    }
    
    func loadString(key: String) {
        let defaults = UserDefaults.standard
        if defaults.hasValue(forKey: key) {
            currentWord = defaults.string(forKey: key) ?? ""
            print(usedWords)
        } else {
            print("Cannot load \(key)!")
            currentWord = allWords.randomElement() ?? ""
        }
    }
}

extension UserDefaults {
    func hasValue(forKey key: String) -> Bool {
        return nil != object(forKey: key)
    }
}

