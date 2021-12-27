//
//  MainFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit
import Kingfisher
import CoreData

final class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private let manager = CoreDataManager.shared
    var managedBrands: [NSManagedObject] = []
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @IBOutlet weak private var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        let showDetailsBarButton = UIBarButtonItem(title: "Details", style: .done, target: self, action: #selector(showDetails))
        self.navigationItem.rightBarButtonItem = showDetailsBarButton
      
        table.refreshControl = refreshControl
        fetchData()
        managedBrands = managedBrands.sorted(by: { ($0.value(forKeyPath: "name") as! String) < ($1.value(forKeyPath: "name") as! String)})
    }
    
    func fetchData() {
        fetchLocalBrands()
        if(self.managedBrands.isEmpty) {
            guard let url = URL(string: Constants.manufacturesJsonURLString) else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let brands = try decoder.decode([Brand].self, from: data)
                    self.saveBrands(brands: brands)
                    
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.table.reloadData()
                    }
                } catch let error{
                    print("Error serialization json", error)
                }
                
            }.resume()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func fetchLocalBrands() {
        let context = manager.mainContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "Brand")
        
        do {
            self.managedBrands = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func saveBrands(brands: [Brand]) {
        let context = manager.mainContext
        for model in brands {
            let entity = NSEntityDescription.entity(forEntityName: "Brand", in: context)!
            let brand = NSManagedObject(entity: entity, insertInto: context)
            brand.setValue(model.id, forKey: "id")
            brand.setValue(model.name, forKey: "name")
            brand.setValue(model.imgUrl, forKey: "imgUrl")
            brand.setValue(model.avgHorsepower, forKey: "avgHorsepower")
            brand.setValue(model.avgPrice, forKey: "avgPrice")
            managedBrands.append(brand)
        }
        
        manager.saveMainContext()
    }
    
    private func configureCell(cell: CustomTableViewCell, for indexPath: IndexPath) {
        let brand = self.managedBrands[indexPath.row]
        let name = brand.value(forKeyPath: "name") as! String?
        let imgUrl = brand.value(forKeyPath: "imgUrl") as! String?
        let avgHorsepower = brand.value(forKeyPath: "avgHorsepower") as! Double?
        cell.nameOfBrandLabel.text = name?.capitalized
        cell.averageHorsepowerLabel.text = "Average horsepower - \(Int((avgHorsepower ?? 0)))"
        let url = URL(string: imgUrl ?? "")
        cell.imageOfBrand.kf.setImage(with: url)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        managedBrands += managedBrands
        table.reloadData()
        sender.endRefreshing()
    }
    
    @objc private func showDetails() {
        self.performSegue(withIdentifier: "moveToDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MainMenu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CellDetailsViewController") as! CellDetailsViewController
        vc.brand = managedBrands[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managedBrands.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomTableViewCell
        configureCell(cell: cell, for: indexPath)
        return cell
    }
}
