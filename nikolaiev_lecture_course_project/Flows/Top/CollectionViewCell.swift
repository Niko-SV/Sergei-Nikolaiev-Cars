//
//  CollectionViewCell.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 29.11.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    func setupSell(with car: Car) {
        self.carImageView.image = UIImage(named: car.imageName)
        self.carLabel.text = car.name
    }
}
