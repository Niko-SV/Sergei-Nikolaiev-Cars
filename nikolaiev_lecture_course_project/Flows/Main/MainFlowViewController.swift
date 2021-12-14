//
//  MainFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

class MainFlowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var brands = [Brand]()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak private var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moveToDetailsBarButton = UIBarButtonItem(title: "Details", style: .done, target: self, action: #selector(moveToDetails))
        self.navigationItem.rightBarButtonItem = moveToDetailsBarButton
        
        table.refreshControl = refreshControl
        fetchData()
    }
    
    func fetchData() {
        
        let jsonURLString = "https://private-anon-2b662ec671-carsapi1.apiary-mock.com/manufacturers"
        guard let url = URL(string: jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                self.brands = try JSONDecoder().decode([Brand].self, from: data)
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            } catch let error{
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    private func configureCell(cell: CustomTableViewCell, for indexPath: IndexPath) {
    
        let brand = brands[indexPath.row]
        cell.nameOfBrandLabel.text = brand.name
        
        guard let imageURL = URL(string: brand.img_url!) else { return }
        guard let imageData = try? Data(contentsOf: imageURL) else { return }
        cell.imageOfBrand.image = UIImage(data: imageData)
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
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        configureCell(cell: cell, for: indexPath)
        return cell
    }
}
