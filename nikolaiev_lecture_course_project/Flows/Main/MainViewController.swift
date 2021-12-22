//
//  MainViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

final class MainViewController: UITabBarController {
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: DefaultsKeys.userLoggedIn)
        if !isUserLoggedIn {
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "auth_vc") as! AuthViewController
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.isModalInPresentation = true
            present(navigationController, animated: true, completion: nil)
        }
    }
}
