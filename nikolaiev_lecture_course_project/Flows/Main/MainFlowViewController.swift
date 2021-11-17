//
//  MainFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

class MainFlowViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moveToDetailsBarButton = UIBarButtonItem(title: "Details", style: .done, target: self, action: #selector(moveToDetails))
        self.navigationItem.rightBarButtonItem = moveToDetailsBarButton
    }
    
    @objc func moveToDetails() {
        self.performSegue(withIdentifier: "moveToDetails", sender: self)
    }
    
}
