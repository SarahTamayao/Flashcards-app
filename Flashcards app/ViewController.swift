//
//  ViewController.swift
//  Flashcards app
//
//  Created by Ebun Aluko on 3/2/22.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    //Array to hold our flashcards
    var flashcards = [Flashcard]()
    var memoryName = "flashcards"
    //Current flashcard index
    var currentIndex = 0
    
    @IBOutlet weak var BtnOptionOne: UIButton!
    @IBOutlet weak var BtnOptionTwo: UIButton!
    @IBOutlet weak var BtnOptionThree: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    

    
    override func viewDidLoad() {
        print(BtnOptionOne.titleLabel!.text!)
        print(BtnOptionTwo.titleLabel!.text!)
        print(BtnOptionThree.titleLabel!.text!)
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.layer.cornerRadius = 20.0
        frontLabel.layer.shadowRadius = 15.0
        frontLabel.layer.shadowOpacity = 0.5
        frontLabel.clipsToBounds = true
        
        backLabel.layer.cornerRadius = 20.0
        backLabel.layer.shadowRadius = 15.0
        backLabel.layer.shadowOpacity = 0.5
        backLabel.clipsToBounds = true
        
        BtnOptionOne.layer.cornerRadius = 10.0
        BtnOptionOne.layer.borderWidth = 3.0
        BtnOptionOne.layer.borderColor = #colorLiteral(red: 0.292, green: 0.081, blue: 0.6, alpha: 1)
        
        BtnOptionTwo.layer.cornerRadius = 10.0
        BtnOptionTwo.layer.borderWidth = 3.0
        BtnOptionTwo.layer.borderColor = #colorLiteral(red: 0.292, green: 0.081, blue: 0.6, alpha: 1)
        
        BtnOptionThree.layer.cornerRadius = 10.0
        BtnOptionThree.layer.borderWidth = 3.0
        BtnOptionThree.layer.borderColor = #colorLiteral(red: 0.292, green: 0.081, blue: 0.6, alpha: 255)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Read saved flashcards
        readSavedFlashcards()
        
        //Adding our initial flashcard if needed
        if flashcards.count == 0{
        updateFlashcard(question: "What is the capital of Nigeria?", answer: "Abuja")
        } else{
            updateLabels()
            updateNextPrevButtons()
        }
}
    
    override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    
    @IBAction func didTaponFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    func flipFlashcard(){
        frontLabel.isHidden = !frontLabel.isHidden
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {//self.frontLabel.isHidden = true
        })
        }
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0.0)}, completion: {finished in
        //Update labels
        self.updateLabels()
        //Run other animation
        self.animateCardIn()
        })
    }
    
    func animateCardIn(){
        //Start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0)
        //Animate card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    func newanimateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: 300, y: 0.0)}, completion: {finished in
        //Update labels
        self.updateLabels()
        //Run other animation
        self.newanimateCardIn()
        })
    }
    
    func newanimateCardIn(){
        //Start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: -300, y: 0)
        //Animate card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    
    

    
    func updateFlashcard( question: String, answer: String){
        let flashcard = Flashcard (question: question, answer: answer)
        backLabel.text = flashcard.answer
        frontLabel.text = flashcard.question
        
        //Adding flashcard to flashcards array
        flashcards.append(flashcard)
        
        //Logging into console
        print("😎Added new flashcard")
        print("😎 We now have \(flashcards.count) \(memoryName)")
        
        //Update current index
        currentIndex = flashcards.count - 1
        print("😎 Our current index is \(currentIndex)")
        
        //Update buttons
        updateNextPrevButtons()
        
        //Update label
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        if BtnOptionOne.titleLabel!.text == backLabel.text{
            frontLabel.isHidden = true
        }
        else{BtnOptionOne.isHidden = true}
        print(BtnOptionOne.titleLabel!.text!)
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        if BtnOptionTwo.titleLabel!.text == backLabel.text{
            frontLabel.isHidden = true
        }
        else{BtnOptionTwo.isHidden = true}
        print(BtnOptionTwo.titleLabel!.text!)
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        if BtnOptionThree.titleLabel!.text == backLabel.text{
            frontLabel.isHidden = true
        }
        else{BtnOptionThree.isHidden = true}
        print(BtnOptionThree.titleLabel!.text!)
}
 
    @IBAction func didTapOnPrev(_ sender: Any) {
        //Increase current index
        currentIndex = currentIndex - 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
        
        
        self.newanimateCardOut()
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        //Increase current index
        currentIndex = currentIndex + 1
        
        //Update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
        
        self.animateCardOut()
    }
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        let alert = UIAlertController (title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction( title: "Delete", style: .destructive) {action in
            print(self.flashcards)
            self.deleteCurrentFlashcard()
            print(self.flashcards)
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title:"Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    func deleteCurrentFlashcard(){
        //Delete current
        flashcards.remove(at:currentIndex)
        currentIndex = currentIndex - 1
        //Special case: Check if last card was deleted
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        print(UserDefaults.standard.array(forKey: memoryName))
        //Update buttons
        updateNextPrevButtons()
        //Saving flashcards
        UserDefaults.standard.removeObject(forKey: memoryName)
        self.saveAllFlashcardsToDisk()
        readSavedFlashcards()
        self.updateLabels()
    }
    
    func updateNextPrevButtons() {
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1{
            nextButton.isEnabled = false }
        else{
            nextButton.isEnabled = true
            }
        //Diasble prev button if at the beginning
        if currentIndex == 0{
            prevButton.isEnabled = false }
        else{
            prevButton.isEnabled = true
            }
    }
    
    func updateLabels() {
        //Get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        
        //Update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk() {
        //From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question" : card.question, "answer" : card.answer]}
        
        
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: memoryName)
        
        //Log it
        print("🎉Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards(){
        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: memoryName) as? [[String: String]] {
        //In here we know for sure we have a dictionary array
        let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question:  dictionary["question"]!, answer: dictionary["answer"]!)
        }
        //Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
    }
}
}

