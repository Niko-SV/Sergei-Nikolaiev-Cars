//
//  BrandsModel.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 22.11.2021.
//

import UIKit

struct Brand: Decodable {
    
    let num_models: Int
    let img_url: String?
    let max_car_id: Int
    let id: Int
    let name: String
    let avg_horsepower: Double
    let avg_price: Double
}
