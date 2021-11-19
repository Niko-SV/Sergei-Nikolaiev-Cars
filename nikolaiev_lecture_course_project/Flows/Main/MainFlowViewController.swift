//
//  MainFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

class MainFlowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let carBrands = ["Volkswagen", "Ford", "Fiat", "Honda", "Toyota", "Mercedes", "Peugeot", "Audi", "Skoda", "Smart", "Mini", "BMW", "Mitsubishi", "Nissan"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moveToDetailsBarButton = UIBarButtonItem(title: "Details", style: .done, target: self, action: #selector(moveToDetails))
        self.navigationItem.rightBarButtonItem = moveToDetailsBarButton
    }
    
    @objc func moveToDetails() {
        self.performSegue(withIdentifier: "moveToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carBrands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        
        cell.nameOfBrandLabel.text = carBrands.sorted()[indexPath.row]
        cell.imageOfBrand.image = UIImage(named: carBrands.sorted()[indexPath.row])
        cell.backgroundColor = UIColor.systemBrown
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
