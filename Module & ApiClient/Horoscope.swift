//
//  Horoscope.swift
//  HoroscopeApp
//
//  Created by Tiffany Obi on 1/13/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

struct Horoscope: Codable {
    var sunsign: String
    let credit:String
    let date:String
    let horoscope:String
    let meta:Specifics
}

struct Specifics: Codable {
    let mood: String
    let keywords: String
    let intensity: String
}
