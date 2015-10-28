//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    @IBOutlet weak var guess: UIButton!
    @IBOutlet weak var wrongGuess: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var currentText: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    var game = Hangman()
    var wrongAttempts: String?
    var currImage: String?
    var notHasResult:Bool?
    var previousKnownString: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        game.start()
        previousKnownString = game.knownString
        currentText.text = game.knownString
        wrongGuess.text = "Nothing wrong yet"
        wrongAttempts = ""
        currImage = "basic-hangman-img/hangman1.gif"
        image.image = UIImage(named: currImage!)
        notHasResult = true
    }
    
    @IBAction func startOver() {
        game.knownString = previousKnownString
        currentText.text = previousKnownString
        wrongGuess.text = "Nothing wrong yet"
        wrongAttempts = ""
        currImage = "basic-hangman-img/hangman1.gif"
        image.image = UIImage(named: currImage!)
        notHasResult = true
        game.guessedLetters = NSMutableArray()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func guessButtonPressed(sender: UIButton) {
        checkStatus()
        textField.text = textField.text!.uppercaseString
        let newGuess = Array(arrayLiteral: textField.text)[0]
        if (notHasResult! && (game.guessLetter(newGuess!) == false) && !wrongAttempts!.containsString(newGuess!)) {
            wrongAttempts = wrongAttempts! + newGuess!
            wrongGuess.text = wrongAttempts
            //checkStatus()
            changeImage()
        }
        checkStatus()
        textField.text = ""
        currentText.text = game.knownString
    }
    
    func changeImage() {
        currImage = "basic-hangman-img/hangman" + (((wrongAttempts?.characters.count)!+1).description) + ".gif"
        image.image = UIImage(named: currImage!)
    }
    
    func checkStatus() {
        if (game.answer == game.knownString) {
            
            notHasResult = false
            let winAlert = UIAlertController(title: "Win", message: "You win", preferredStyle: UIAlertControllerStyle.Alert)
            winAlert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(winAlert, animated: true, completion: nil)
            return
        }
        if (wrongAttempts?.characters.count >= 6) {
        //print("loss")
            notHasResult = false
            let loseAlert = UIAlertController(title: "Lose", message: "You lost", preferredStyle: UIAlertControllerStyle.Alert)
            loseAlert.addAction(UIAlertAction(title: "Back", style: UIAlertActionStyle.Default, handler: nil))
            presentViewController(loseAlert, animated: false, completion: nil)
            return
        }
    }
}

