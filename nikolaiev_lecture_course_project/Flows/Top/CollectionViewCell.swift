//
//  CollectionViewCell.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 29.11.2021.
//

import UIKit
import Kingfisher

final class CollectionViewCell: UICollectionViewCell {
    
    var car: Car? = nil
    
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    
    func setupCell(with car: Car) {
        let url = URL(string: car.correctUrl ?? "")
        self.carImageView.kf.setImage(with: url)
        self.carLabel.text = "\(car.make?.capitalized ?? "") \(car.model?.capitalized ?? " ")" 
    }
}

