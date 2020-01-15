//
//  UserPreferences.swift
//  HoroscopeApp
//
//  Created by Tiffany Obi on 1/15/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import UIKit

enum UserNameAndZodiac: String {
    
    case name = " "
    case zodiacSign = ""
}

struct UserPreferenceKey {
    static let userName = "User Name"
    static let zodiacSign = "Zodiac Sign"
    
}


class UserPreference {
      private init() {}
        
      static let shared = UserPreference()
    
    
      
      func updateDefaults<T>(with value: T, for key: String) {
        
        
        UserDefaults.standard.set(value, forKey: key)
      }
    
    
      
      func getDefaultValue<T>(for key: String) -> T? {
        guard let value = UserDefaults.standard.object(forKey: key) as? T else {
          return nil
        }
        return value
      }
    }


