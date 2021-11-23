//
//  MainFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

class MainFlowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var brands = Brand.getBrands(cardBrands: Brand.carBrands)
    var currentBrand: Brand? = nil
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak private var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moveToDetailsBarButton = UIBarButtonItem(title: "Details", style: .done, target: self, action: #selector(moveToDetails))
        self.navigationItem.rightBarButtonItem = moveToDetailsBarButton
        
        table.refreshControl = myRefreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        brands += brands
        table.reloadData()
        sender.endRefreshing()
    }
    
    @objc func moveToDetails() {
        self.performSegue(withIdentifier: "moveToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MainFlow", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CellDetailsViewController") as! CellDetailsViewController
        vc.brand = brands[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brands.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        
        cell.nameOfBrandLabel.text = brands[indexPath.row].name
        cell.imageOfBrand.image = UIImage(named: brands[indexPath.row].brandImage)
        cell.countryOfBrandLabel.text = brands[indexPath.row].country
        return cell
    }
}
