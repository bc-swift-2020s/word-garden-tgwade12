//
//  ViewController.swift
//  Word Garden
//
//  Created by Thomas Wade on 2/3/20.
//  Copyright © 2020 Thomas Wade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var flowerImageView: UIImageView!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    
    override func viewDidLoad() {
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        
        
        
        super.viewDidLoad()
    }
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    func guessALetter(){
        formatUserGuessLabel()
        guessCount += 1
        let currentLetterGuessed = guessedLetterField.text!
        // flower loses a petal with a wrong letter
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining=wrongGuessesRemaining - 1
            flowerImageView.image = UIImage(named: "flower"+"\(wrongGuessesRemaining)")
        }
        let revealedWord = userGuessLabel.text!
        if wrongGuessesRemaining == 0{
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you are all out of guesses. Try again?"
            
        } else if !revealedWord.contains("_") {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You've got it! Nice work! It took you \(guessCount) to guess the word!"
        } else {
            let guess = (guessCount == 1 ? "guess" : "guesses")
            // if guessCount == 1{
            //     guess = "guess"
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
        
        
    }
    
}

func formatUserGuessLabel(){
    var revealWord = ""
    lettersGuessed += guessedLetterField.text!
    print(lettersGuessed)
    print(guessedLetterField.text!)
    for letter in wordToGuess {
        if lettersGuessed.contains(letter) {
            revealWord = revealWord + "\(letter)"
        } else {
            revealWord += " _"
        }
    }
    revealWord.removeFirst()
    userGuessLabel.text = revealWord
}

func guessLetterFieldChanged(_ sender: UITextField) {
    if let letterGuessed = guessedLetterField.text?.last {
        guessedLetterField.text = "\(letterGuessed)"
        guessLetterButton.isEnabled = true
    } else {
        guessLetterButton.isEnabled = false
    }
}

@IBAction func doneKeyPressed(_ sender: UITextField) {
    updateUIAfterGuess()
    guessALetter()
}

@IBAction func guessLetterPressed(_ sender: UIButton) {
    updateUIAfterGuess()
    guessALetter()
}

@IBAction func playAgainButtonPressed(_ sender: UIButton) {
    playAgainButton.isHidden = true
    guessedLetterField.isEnabled = false
    guessLetterButton.isEnabled = false
    flowerImageView.image = UIImage(named: "flower8")
    wrongGuessesRemaining = maxNumberOfWrongGuesses
    lettersGuessed = ""
    formatUserGuessLabel()

}


