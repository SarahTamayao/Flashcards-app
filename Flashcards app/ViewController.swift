//
//  ViewController.swift
//  Flashcards app
//
//  Created by Ebun Aluko on 3/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var BtnOptionOne: UIButton!
    @IBOutlet weak var BtnOptionTwo: UIButton!
    @IBOutlet weak var BtnOptionThree: UIButton!
    
    override func viewDidLoad() {
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
    }
    
    @IBAction func didTaponFlashcard(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        BtnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
    }
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        BtnOptionThree.isHidden = true
    }
}

