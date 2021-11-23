//
//  CellDetailsViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 22.11.2021.
//

import UIKit

import UIKit

class CellDetailsViewController: UIViewController {
    
    var brand: Brand? = nil
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var brandImage: UIImageView!
    @IBOutlet weak private var brandLabel: UILabel!
    @IBOutlet weak private var yearOfEstablishmentLabel: UILabel!
    @IBOutlet weak private var headquatersLabel: UILabel!
    @IBOutlet weak private var lastYearSalesNumbersLabel: UILabel!
    @IBOutlet weak private var currentModelsLabel: UILabel!
    @IBOutlet weak private var currentModelsTextView: UITextView!
    @IBOutlet private var textFields: [UITextField]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let resultBrand = brand {
            brandImage.image = UIImage(named: resultBrand.brandImage)
            brandLabel.text = resultBrand.name
        }
    }
    
    
    
}
