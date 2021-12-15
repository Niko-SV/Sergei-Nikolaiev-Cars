//
//  BrandsModel.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 22.11.2021.
//

import UIKit
struct Brand: Decodable {
    
    var numModels: Int?
    var imgUrl: String?
    var maxCarId: Int?
    var id: Int?
    var name: String?
    var avgHorsepower: Double?
    var avgPrice: Double?
}
