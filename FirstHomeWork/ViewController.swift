//
//  ViewController.swift
//  FirstHomeWork
//
//  Created by Bilal Candemir on 9/4/22.
//

import UIKit


/// I used protocols for Data Share between two view controllers
protocol DataShare {
    /// I describe the function here and i will use this on second view controller
    func getData(nameString:String, carBrand:String, carModel:String, notificationSetting:Bool)
}

class ViewController: UIViewController, DataShare {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var carBrandLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var formButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Code for Navigation Controller hidden
        self.navigationController?.navigationBar.isHidden = true
        
        /// Form button UI Changes
        formButton.backgroundColor = UIColor.clear
        formButton.tintColor = UIColor.white
        formButton.layer.cornerRadius = 5
        formButton.layer.borderWidth = 0.5
        formButton.layer.borderColor = UIColor.gray.cgColor
    }
    
    /// This Function gets data from second view controller and show thoose informations on Labels
    func getData(nameString: String, carBrand: String, carModel: String, notificationSetting:Bool) {
        nameLabel.text = nameString
        carBrandLabel.text = carBrand
        carModelLabel.text = carModel
        
        /// Controlled notification is true or false and write to Label
        if notificationSetting {
            notificationLabel.text = "Evet"
        }
        else {
            notificationLabel.text = "Hayır"
        }
    }
    
    /// When user tap the Form Button, this button send to second view controller
    @IBAction func formButtonAction(_ sender: Any) {
        /// Describe where is the second view controller in Storyboards and also casting operations for reach to second view controller's delegate
        let formViewController = storyboard?.instantiateViewController(withIdentifier: "formViewController") as! SecondViewController
        formViewController.delegate = self
        /// Segue to second view controller using navigation controller
        self.navigationController?.pushViewController(formViewController, animated: true)
    }
    
}

