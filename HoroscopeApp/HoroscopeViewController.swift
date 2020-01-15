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
    
    var zodiacString = "pisces"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getZodiacSign(with: zodiacString)
    }
    
    
    
    @IBAction func savePreferencesButtonPressed(segue:UIStoryboardSegue) {
    
    guard let savedChanges = segue.source as? UserInfoViewController else {
        fatalError("could not segue")
        }
            signNameLabel.text = savedChanges.zodiacsignLabel.text
        zodiacString = savedChanges.zodiacString.lowercased()
        if zodiacString.isEmpty {
            zodiacString = "aries"
        }
        getZodiacSign(with: zodiacString)
        
        
    }
        
    func updateUI() {
        usernameLabel.text = "Horoscope of the Day"
        signImageView.image = UIImage(named: "horoscope")
        
        signNameLabel.text = horoscope?.sunsign
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

