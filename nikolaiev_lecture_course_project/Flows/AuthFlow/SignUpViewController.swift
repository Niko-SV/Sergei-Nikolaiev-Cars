//
//  SignUpViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 17.11.2021.
//
import UIKit

class SignUpViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: DefaultKeys.userLoggedIn)
    }
    
}
