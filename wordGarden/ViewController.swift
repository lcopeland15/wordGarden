//
//  ViewController.swift
//  wordGarden
//
//  Created by Lily Copeland on 2/9/20.
//  Copyright © 2020 Lily Copeland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "SWIFT"
    var lettersGuessed = ""
    let maxNumberOfWrongGuess = 8
    var wrongGuessRemaing = 8
    var guessCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
    
    }

    func updateUIAfterGuessed(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = " "
    }
    
    func formatUserGuessLabel() {
        var revealedWord = " "
               lettersGuessed += guessedLetterField.text!
             
               for letter in wordToGuess {
                   if lettersGuessed.contains(letter){
                       revealedWord = revealedWord + String(letter)
                   }
               else{
                   revealedWord += " _ "
                   }
                 }
                 revealedWord.removeFirst()
                 userGuessLabel.text = revealedWord
    }
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        //decrements the wrongGuessesRemaing and shows the next flower image with one less pedal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessRemaing = wrongGuessRemaing - 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessRemaing)")
        }
        
        let revealedWord = userGuessLabel.text!
        //stop game if wrongGuesses = 0
        
        if wrongGuessRemaing == 0 {
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Sorry you are out of guesses! Try again?"
        } else if !revealedWord.contains(" _") {
                //Won a game!
                playAgainButton.isHidden = false
                guessedLetterField.isEnabled = false
                guessLetterButton.isEnabled = false
            guessCountLabel.text = "You got it! It took you \(guessCount) guesses to guess the word!"
            
        } else {
            //update guess count
            let guess = (guessCount == 1 ? "guess": "guesses")
    
            guessCountLabel.text = "You've made \(guessCount) \(guess)!"
            
            
        }
        
        
         
    }

        @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last {
            guessedLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
            
        } else {
            //disable button if I don't have a single char in the guessedLetterField
            guessLetterButton.isEnabled = false
        }
        
        
    }
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuessed()
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuessed()
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessRemaing = maxNumberOfWrongGuess
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses!"
        guessCount =  0
        
        
        
    }


}

