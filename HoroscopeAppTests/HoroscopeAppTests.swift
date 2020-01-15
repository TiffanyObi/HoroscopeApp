//
//  HoroscopeAppTests.swift
//  HoroscopeAppTests
//
//  Created by Tiffany Obi on 1/13/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import XCTest


@testable import HoroscopeApp
import NetworkHelper

class HoroscopeAppTests: XCTestCase {

    func testUrlStringForData() {
        let string = "leo"
        
        let exp = XCTestExpectation(description: "search found")
        let elementEndpointURL = "http://sandipbgt.com/theastrologer/api/horoscope/\(string)/today/"
        let request = URLRequest(url: URL(string: elementEndpointURL)!)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
            case .success(let data):
                exp.fulfill()
                
                XCTAssertGreaterThan(data.count, 1_000, "data.count:\(data) should be greater that 1,000 bytes .")
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    func testHoroscopeDataModel() {
        struct Horoscope: Codable {
            let sunsign: String
            
        }
        
        let json = """
        {
            "sunsign": "Leo",
            "credit": "(c) Kelli Fox, The Astrologer, http://new.theastrologer.com",
            "date": "2018-03-09",
            "horoscope": "The world is your oyster today. So what are you waiting for? Get out there and find your adventure. It's a perfect day for learning something new. This can be formalized through taking a class, or it can be an informal, impromptu process. That's what 'the world is your oyster' means -- your pearl of knowledge is out there, just waiting to be discovered. So where will you search for it first?(c) Kelli Fox, The Astrologer, http://new.theastrologer.com",
            "meta": {
                "mood": "strange",
                "keywords": "one-sided, fervor",
                "intensity": "87%"
            }
        }
        """.data(using: .utf8)!
        
        let horoscope = try! JSONDecoder().decode(Horoscope.self, from: json)
        
        XCTAssertEqual(horoscope.sunsign, "Leo")
    }

}
