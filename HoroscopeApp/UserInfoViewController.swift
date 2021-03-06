//
//  ViewController.swift
//  HoroscopeApp
//
//  Created by Tiffany Obi on 1/13/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var zodiacsignLabel: UILabel!
    
    @IBOutlet weak var zodiacSignPicker: UIPickerView!
    
    
    @IBOutlet weak var enterButton: UIButton!
    

    
    var zodiacString = "" {
        didSet {
            UserPreference.shared.updateDefaults(with: zodiacString, for: UserPreferenceKey.zodiacSign)
        }
    }
        
    
    
    var signs = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio", "Sagittarius", "Capricorn", "Aquarius", "Pisces"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zodiacSignPicker.dataSource = self
        zodiacSignPicker.delegate = self
       nameTextField.delegate = self
        
    }
    
    
    
}

extension UserInfoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    
        UserDefaults.standard.set(textField.text ?? "No_Name", forKey:"NameKey")
        nameLabel.text = "Welcome \(UserDefaults.standard.object(forKey: "NameKey") ?? "No Name") !"

    }
}

extension UserInfoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return signs.count
    }
    

}

extension UserInfoViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return signs[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        zodiacString =  signs[row].lowercased()
        
        zodiacsignLabel.text = signs[row]
        
        UserDefaults.standard.set("\(zodiacString.uppercased())", forKey:"Zodiac Sign")
        print(zodiacString)
    }
}
