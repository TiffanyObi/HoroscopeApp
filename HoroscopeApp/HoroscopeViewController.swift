//
//  DetailViewController.swift
//  HoroscopeApp
//
//  Created by Tiffany Obi on 1/14/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

class HoroscopeViewController: UIViewController {

    @IBOutlet weak var signImageView: UIImageView!
    
    
    @IBOutlet weak var horoscopeTextView: UITextView!
    
    
    @IBOutlet weak var signNameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    var horoscope: Horoscope? {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    let welcomeMessage = "Horoscope of the Day"
    
    var zodiacString = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = welcomeMessage
        
        if zodiacString == "" {
            zodiacString = "libra"
        }
        getZodiacSign(with: zodiacString)
    }
    
    
    
    @IBAction func savePreferencesButtonPressed(segue:UIStoryboardSegue) {
        usernameLabel.text = "Welcome \(UserDefaults.standard.object(forKey: "NameKey") as? String ?? "No Name") !"
    guard let savedChanges = segue.source as? UserInfoViewController else {
        fatalError("could not segue")
        }

        print(UserDefaults.standard.object(forKey: "NameKey") as? String ?? "no value")
        signNameLabel.text = UserDefaults.standard.object(forKey: "Zodiac Sign") as? String
        zodiacString = savedChanges.zodiacString.lowercased()
        if zodiacString.isEmpty {
            zodiacString = "aries"
        }
        getZodiacSign(with: zodiacString)
        
        
    }
        
    
    @IBAction func clearDefaultsButton(_ sender: UIBarButtonItem) {
        
        
        
        UserDefaults.standard.removeObject(forKey: "NameKey")
        
        usernameLabel.text = welcomeMessage
        
        signNameLabel.text = signNameLabel.text
    }
    
    func updateUI() {
        
        signImageView.image = UIImage(named: "horoscope")
        usernameLabel.text = UserDefaults.standard.object(forKey: "NameKey") as? String ?? "Horoscope of the Day"
        signNameLabel.text = UserDefaults.standard.object(forKey: "Zodiac Sign") as? String
        horoscopeTextView.text = horoscope?.horoscope
        
        
    }
    
    func getZodiacSign(with zodiacSign: String ) {
        HoroscopeAPIClient.getHoroscope(with: zodiacSign) { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("could not load horoscope \(error)")
            case.success(let horoscopeData):
                self?.horoscope = horoscopeData
            }
        }

    }
}

