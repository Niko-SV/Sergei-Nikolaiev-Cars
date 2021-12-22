//
//  MainFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit
import Kingfisher

final class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var brands = [Brand]()
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak private var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let showDetailsBarButton = UIBarButtonItem(title: "Details", style: .done, target: self, action: #selector(showDetails))
        self.navigationItem.rightBarButtonItem = showDetailsBarButton
        
        table.refreshControl = refreshControl
        fetchData()
    }
    
    func fetchData() {
        
        guard let url = URL(string: Constants.manufacturesJsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.brands = try decoder.decode([Brand].self, from: data)
                
                DispatchQueue.main.async {
                    self.table.reloadData()
                }
            } catch let error{
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    private func configureCell(cell: CustomTableViewCell, for indexPath: IndexPath) {
        let brand = self.brands[indexPath.row]
        cell.nameOfBrandLabel.text = brand.name?.capitalized
        cell.averageHorsepowerLabel.text = "Average horsepower - \(Int(brand.avgHorsepower ?? 0))"
        let url = URL(string: brand.correctUrl ?? "")
        cell.imageOfBrand.kf.setImage(with: url)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        brands += brands
        table.reloadData()
        sender.endRefreshing()
    }
    
    @objc private func showDetails() {
        self.performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MainMenu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CellDetailsViewController") as! CellDetailsViewController
        vc.id =  brands[indexPath.row].id
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
