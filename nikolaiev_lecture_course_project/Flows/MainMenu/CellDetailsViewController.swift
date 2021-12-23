//
//  CellDetailsViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 22.11.2021.
//

import UIKit
import Kingfisher
import CoreData

final class CellDetailsViewController: UIViewController, UITextViewDelegate {
    
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
    
    private let manager = CoreDataManager.shared
    var brand: NSManagedObject? = nil
    var id: Int?
    var name: String?
    var imgUrl: String?
    var avgHorsepower: Double?
    var avgPrice: Double?
    var favoriteModels: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteModelsTextView.delegate = self
        if let result = brand {
            id = Int(result.value(forKeyPath: "id") as! Int32)
            name = result.value(forKeyPath: "name") as! String?
            imgUrl = result.value(forKeyPath: "imgUrl") as! String?
            avgHorsepower = result.value(forKeyPath: "avgHorsepower") as! Double?
            avgPrice = result.value(forKeyPath: "avgPrice") as! Double?
            favoriteModels = result.value(forKeyPath: "favoriteModels") as! String?
            self.setupBrandDetailsScreen(with: result)
            
            editingTextFields()
        }
    }
    
    weak var activeField: UITextField?
    
    func textViewDidChange(_ textView: UITextView) {
        brand?.setValue(textView.text, forKey: "favoriteModels")
        manager.saveMainContext()
     }
    
    func setupBrandDetailsScreen(with brand: NSManagedObject) {
        let url = URL(string: imgUrl ?? "")
        self.brandImage.kf.setImage(with: url)
        self.brandLabel.text = name?.capitalized
        self.idTextField.text = String(describing: id!)
        self.averagePriceTextField.text = String(format: "%.2f", avgPrice!) + " $"
        self.averageHorsepowerTextField.text = String(describing: Int(avgHorsepower!))
        self.favoriteModelsTextView.text = favoriteModels
    }
}
