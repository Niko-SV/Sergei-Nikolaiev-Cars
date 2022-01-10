//
//  UserModel.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 27.12.2021.
//

import Foundation


struct User: Codable  {
    let email: String
    let name: String
    let surName: String
    let bio: String
}
