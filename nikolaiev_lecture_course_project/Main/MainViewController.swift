//
//  MainViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: DefaultKeys.userLoggedIn)
        if (!isUserLoggedIn) {
            let storyboard = UIStoryboard(name: "AuthFlow", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "auth_vc") as! AuthFlowViewController
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.isModalInPresentation = true
            present(navigationController, animated: true, completion: nil)
        }
    }
}
