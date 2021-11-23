//
//  BrandsModel.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 22.11.2021.
//

import UIKit

struct Brand {
    
    var name: String
    var country: String
    var brandImage: String
    
    // mock data
    static let carBrands = [
        "Volkswagen": "Germany", "Ford": "USA", "Fiat": "Italy", "Honda": "Japan",
        "Toyota": "Japan", "Mercedes": "Germany", "Peugeot": "France", "Audi": "Germany", "Skoda": "Chzech Republic",
        "Smart": "Germany", "Mini": "United Kingdom", "BMW": "Germany", "Mitsubishi": "Japan", "Nissan": "Japan"
    ]
    
    static func getBrands(cardBrands: [String: String]) -> [Brand] {
        
        var brands = [Brand]()
        
        for (key, value) in carBrands {
            brands.append(Brand(name: key, country: value, brandImage: key))
        }
        
        brands.sort(by: { $0.name < $1.name })
        
        return brands
    }
}
