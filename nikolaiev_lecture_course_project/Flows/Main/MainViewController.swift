//
//  MainViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

final class MainViewController: UITabBarController {
    
    @IBOutlet weak var mainTabBat: UITabBar!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            mainTabBat.standardAppearance = appearance
            mainTabBat.scrollEdgeAppearance = mainTabBat.standardAppearance
        }
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: DefaultsKeys.userLoggedIn)
        if !isUserLoggedIn {
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "auth_vc") as! AuthViewController
            let navigationController = UINavigationController(rootViewController: vc)
            navigationController.modalPresentationStyle = .overCurrentContext
            present(navigationController, animated: false, completion: nil)
        }
    }
    
    
}
