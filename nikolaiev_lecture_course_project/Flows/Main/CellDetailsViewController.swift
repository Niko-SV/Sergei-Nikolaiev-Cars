//
//  CellDetailsViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 22.11.2021.
//

import UIKit
import Kingfisher

final class CellDetailsViewController: UIViewController {
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var brandImage: UIImageView!
    @IBOutlet weak private var brandLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    @IBOutlet weak var averageHorsepowerLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var averagePriceTextField: UITextField!
    @IBOutlet weak var averageHorsepowerTextField: UITextField!
    @IBOutlet weak var favoriteModelsTextView: UITextView!
    
    @IBOutlet var brandDetailsView: UIView!
        
    func editingTextFields(){
        idTextField.isUserInteractionEnabled = false
        averageHorsepowerTextField.isUserInteractionEnabled = false
        averagePriceTextField.isUserInteractionEnabled = false

    }
    
    var brand: Brand? = nil
    var id: Int? = nil
    var main = MainFlowViewController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        editingTextFields()
    }

    func fetchData() {
        
        guard let url = URL(string: main.jsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let brands = try decoder.decode([Brand].self, from: data)
                self.brand = brands.filter{ $0.id == self.id }.first
               
                DispatchQueue.main.async {
                    if let result = self.brand {
                        self.setupBrandDetailsScreen(with: result)
                    }
                }
            } catch let error{
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    func setupBrandDetailsScreen(with brand: Brand) {
        let url = URL(string: brand.correctUrl ?? "")
        self.brandImage.kf.setImage(with: url)
        self.brandLabel.text = brand.name?.capitalized
        self.idTextField.text = String(describing: brand.id!)
        self.averagePriceTextField.text = String(format: "%.2f", brand.avgPrice!) + " $"
        self.averageHorsepowerTextField.text = String(describing: Int(brand.avgHorsepower!))
    }

}
