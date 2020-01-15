//
//  HoroscopeAPIClient.swift
//  HoroscopeApp
//
//  Created by Tiffany Obi on 1/13/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation
import NetworkHelper

struct HoroscopeAPIClient {
    

    static func getHoroscope(with zodiacSign: String,completion: @escaping (Result<Horoscope,AppError>) -> ()) {
        
        let zodiacsign = zodiacSign.lowercased()
    
    let horoscopeEndpoint = "http://sandipbgt.com/theastrologer/api/horoscope/\(zodiacsign)/today"
 
    guard let url = URL(string: horoscopeEndpoint) else {
        completion(.failure(.badURL(horoscopeEndpoint)))
        return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
     
        switch result {
        case .failure(let appError):
            completion(.failure(.networkClientError(appError)))
            
        case .success(let horoscope):
            
            do {
                let details = try JSONDecoder().decode(Horoscope.self, from: horoscope)
             
                completion(.success(details))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
    }
    
}
}
