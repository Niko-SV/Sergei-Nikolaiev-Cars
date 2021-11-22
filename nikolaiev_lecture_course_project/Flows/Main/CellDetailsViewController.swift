//
//  CellDetailsViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 22.11.2021.
//

import UIKit

import UIKit

class CellDetailsViewController: UIViewController {
    
    var imageInDetails: Brand?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var countryOfBrandLabel: UILabel!
    @IBOutlet weak var yearOfEstablishmentLabel: UILabel!
    @IBOutlet weak var headquatersLabel: UILabel!
    @IBOutlet weak var lastYearSalesNumbersLabel: UILabel!
    @IBOutlet weak var currentModelsLabel: UILabel!
    @IBOutlet weak var currentModelsTextView: UITextView!
    @IBOutlet var textFields: [UITextField]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}
