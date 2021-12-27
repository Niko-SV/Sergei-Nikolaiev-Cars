//
//  CollectionViewCellDetailsController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 27.12.2021.
//

import UIKit

final class CollectionViewCellDetailsController: UIViewController {
    var car: Car? = nil
    
    @IBOutlet weak var carMarkLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carIDLabel: UILabel!
    @IBOutlet weak var carIDTextField: UITextField!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carModelTextField: UITextField!
    @IBOutlet weak var carYearLabel: UILabel!
    @IBOutlet weak var carYearTextField: UITextField!
    @IBOutlet weak var carAverageHorsepowerLabel: UILabel!
    @IBOutlet weak var carAverageHorsepowerTextField: UITextField!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var carPriceTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let loadedCar = car {
            setupBrandDetailsScreen(with: loadedCar)
        }
    }
    
    func setupBrandDetailsScreen(with car: Car) {
        let url = URL(string: car.imgUrl ?? "")
        self.carImage.kf.setImage(with: url, placeholder: UIImage(named: "depositphotos_247872612-stock-illustration-no-image-available-icon-vector"))
        self.carMarkLabel.text = car.make?.capitalized
        self.carIDTextField.text = String(describing: car.id!)
        self.carModelTextField.text = car.model?.capitalized
        self.carYearTextField.text =  String(describing: car.year!)
        self.carAverageHorsepowerTextField.text =  String(describing: car.horsepower!)
        self.carPriceTextField.text = String(format: "%.2f", car.price!) + " $"
    }
}


