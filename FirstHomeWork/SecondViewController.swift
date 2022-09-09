//
//  SecondViewController.swift
//  FirstHomeWork
//
//  Created by Bilal Candemir on 9/4/22.
//

import UIKit

class SecondViewController: UIViewController {
    
    /// Describe the Delegate for data sharing
    var delegate:DataShare?
    
    /// Create picker views for select car brand and model
    var pickerViewCarBrand = UIPickerView()
    var pickerViewCarModel = UIPickerView()
    
    /// Thoose variables for data sharing
    var selectedCarBrand:String?
    var selectedCarModel:String?
    var notificationIsOn:Bool!
    
    ///Arrays for Picker View Data
    let carBrands = ["AUDI", "MERCEDES", "BMW"]
    let carMercedes = ["AMG GT63S", "S600 MAYBACH", "C63 COUPE"]
    let carAudi = ["S8", "RS7 PERFORMANCE", "A6 AVANT"]
    let carBMW = ["M5 CS", "760 Li", "M8 COMPETITITON"]
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var viewCarBrand: UIView!
    @IBOutlet weak var viewCarModel: UIView!
    @IBOutlet weak var labelCarBrand: UILabel!
    @IBOutlet weak var labelCarModel: UILabel!
    
    
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Add gesture recognizer to Car Brand View when user tap this view picker view will show
        let carBrandTapped = UITapGestureRecognizer(target: self, action: #selector(carBrandViewPressed))
        viewCarBrand.addGestureRecognizer(carBrandTapped)
        
        ///Add gesture recognizer to Car Model View when user tap this view picker view will show
        let carModelTapped = UITapGestureRecognizer(target: self, action: #selector(carModelViewPressed))
        viewCarModel.addGestureRecognizer(carModelTapped)
        
        setComponentConfigures()
    }
    
    
    /// Changed ui component's view configuration in this function
    func setComponentConfigures(){
        
        /// Set default label texts
        labelCarBrand.text = "Seçiniz"
        labelCarModel.text = "Seçiniz"
        
        ///Register button UI Configurations
        registerButton.backgroundColor = UIColor.clear
        registerButton.tintColor = UIColor.white
        registerButton.layer.cornerRadius = 5
        registerButton.layer.borderWidth = 0.5
        registerButton.layer.borderColor = UIColor.gray.cgColor
        
        ///Name and Surname UI Configurations
        nameTextField.backgroundColor = UIColor(named: "textFieldBackground")
        nameTextField.layer.cornerRadius = 3
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor(named: "textFieldBackground")?.cgColor
        
        ///Car Brand View UI Configurations
        viewCarBrand.backgroundColor = UIColor(named: "textFieldBackground")
        viewCarBrand.layer.cornerRadius = 3
        viewCarBrand.layer.borderWidth = 1
        viewCarBrand.layer.borderColor = UIColor(named: "textFieldBackground")?.cgColor
        
        ///Car Model View UI Configurations
        viewCarModel.backgroundColor = UIColor(named: "textFieldBackground")
        viewCarModel.layer.cornerRadius = 3
        viewCarModel.layer.borderWidth = 1
        viewCarModel.layer.borderColor = UIColor(named: "textFieldBackground")?.cgColor
        
        /// Given delegate for Text field ui changes i will describe on delegate section
        nameTextField.delegate = self
    }
    
    /// When user tap Car Brand View this function will be enable
    @objc func carBrandViewPressed(){
        /// We will create picker view
        createCarBrandPickerView()
    }
    
    /// When user tap Car Model View this function will be enable
    @objc func carModelViewPressed(){
        /// We will create picker view
        createCarModelPickerView()
    }
    
    func createCarBrandPickerView(){
        
        ///Give size for controller which include our picker views
        let width = self.view.frame.size.width
        let viewDatePicker: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width - 20, height: 200))
        viewDatePicker.backgroundColor = UIColor.clear
        
        /// Picker view car brand delegation and data source
        pickerViewCarBrand.delegate = self
        pickerViewCarBrand.dataSource = self
        
        /// Add picker view car brand to controller
        viewDatePicker.addSubview(pickerViewCarBrand)
        
        /// This controller will be open on bottom of our simulator or phone and includes picker views , cancel button and also okay button
        let alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertController.Style.actionSheet)
        alertController.view.addSubview(viewDatePicker)
        
        /// Create the cancel button here
        let cancelAction = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        
        /// Create okay button and action when user pick the car model and tap the okay button
        let OKAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { (action) in
            /// Take the text from label car brand
            let carBrandSelected = self.labelCarBrand.text
            /// Send to first view controller
            self.selectedCarBrand = carBrandSelected ?? ""
        }
        alertController.addAction(OKAction)
        
        alertController.view.tintColor = UIColor.blue
        
        /// Show our controller view
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    /// We did same thing for other picker view
    func createCarModelPickerView(){
        
        let width = self.view.frame.size.width
        let viewDatePicker: UIView = UIView(frame: CGRect(x: 0, y: 0, width: width - 20, height: 200))
        viewDatePicker.backgroundColor = UIColor.clear
        
        pickerViewCarModel.delegate = self
        pickerViewCarModel.dataSource = self
        
        viewDatePicker.addSubview(pickerViewCarModel)
        
        
        let alertController = UIAlertController(title: nil, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: UIAlertController.Style.actionSheet)
        alertController.view.addSubview(viewDatePicker)
        
        let cancelAction = UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel) { (action) in
            
        }
        alertController.addAction(cancelAction)
        
        
        let OKAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default) { (action) in
            let carModelSelected = self.labelCarModel.text
            self.selectedCarModel = carModelSelected ?? ""
        }
        alertController.addAction(OKAction)
        
        alertController.view.tintColor = UIColor.blue
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    /// When user tap to register button
    @IBAction func registerButtonAction(_ sender: Any) {
        /// Switch enabled or disabled we change the variable
        if notificationsSwitch.isOn {
            notificationIsOn = true
        }
        else {
            notificationIsOn = false
        }
        /// Send values to first view controller with delegation
        delegate?.getData(nameString: nameTextField.text ?? "-", carBrand: selectedCarBrand ?? "-", carModel: selectedCarModel ?? "-", notificationSetting: notificationIsOn)
        /// Turn back to first view controller using navigation controller
        navigationController?.popViewController(animated: true)
    }
}

/// Extension for Text Field Delegation
extension SecondViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        ///Changed text, border Color when user tap into the nameTextField
        textField.layer.borderColor = UIColor(named: "colorTextFieldTint")?.cgColor
        textField.tintColor = UIColor(named: "colorTextFieldTint")
        textField.textColor = UIColor(named: "colorTextFieldTint")
    }
    
    ///Changed Text Field border and text Color when user finish his editing stuff
    func textFieldDidEndEditing(_ textField: UITextField) {
        ///Changed Text Field border and text Color when user finish his editing stuff in nameTextField
        textField.layer.borderColor = UIColor(named: "textFieldBackground")?.cgColor
        textField.textColor = UIColor.white
    }
}


/// Extension for UIPickerView Delegation
extension SecondViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    
    ///Picker view will have 1 section
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /// This function for how many rows we will use on picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        /// When we use Car Brand Picker view we return car brands array
        if pickerView == pickerViewCarBrand {
            return carBrands.count
        }
        
        /// When we use Car Models Picker view we return car modals array
        else if (pickerView == pickerViewCarModel) {
            /// If selected car brand is AUDI return the carAudi array count
            if selectedCarBrand == "AUDI" {
                return carAudi.count
            }
            
            /// If selected car brand is MERCEDES return the carMercedes array count
            else if selectedCarBrand == "MERCEDES" {
                return carMercedes.count
            }
            
            /// If selected car brand is BMW return the carBmw array count
            else if selectedCarBrand == "BMW" {
                return carBMW.count
            }
            
            else {
                return 1
            }
        }
        
        else {
            return 1
        }
    }
    
    /// This function for what picker view will show
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == pickerViewCarBrand {
            /// Create a label for show data in picker view
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 50))
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = UIColor.blue
            label.text = carBrands[row]
            labelCarBrand.text = carBrands[row]
            return label
        }
        else if pickerView == pickerViewCarModel {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 50))
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.textColor = UIColor.blue
            if selectedCarBrand == "AUDI" {
                label.text = carAudi[row]
                labelCarModel.text = carAudi[row]
                return label
            }
            
            else if selectedCarBrand == "MERCEDES" {
                label.text = carMercedes[row]
                labelCarModel.text = carMercedes[row]
                return label
            }
            
            else if selectedCarBrand == "BMW" {
                label.text = carBMW[row]
                labelCarModel.text = carBMW[row]
                return label
            }
            
            else {
                return UIView()
            }
        }
        else {
            return UIView()
        }
        
    }
    
    
}
