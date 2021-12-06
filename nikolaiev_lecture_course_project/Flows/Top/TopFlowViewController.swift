//
//  EditFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit

class TopFlowViewController: UICollectionViewController {
    
    private let reuseIdentefier = "cell"
    let numberOfRows: CGFloat = 4
    
    private let cars = [
        Car(name: "AudiA4", imageName: "AudiA4"),
        Car(name: "AudiA7", imageName: "AudiA7"),
        Car(name: "AudiQ3", imageName: "AudiQ3"),
        Car(name: "AudiQ8", imageName: "AudiQ8"),
        Car(name: "VolkswagenBeetle", imageName: "VolkswagenBeetle"),
        Car(name: "VolkswagenGolf", imageName: "VolkswagenGolf"),
        Car(name: "VolkswagenJetta", imageName: "VolkswagenJetta"),
        Car(name: "VolkswagenPassat", imageName: "VolkswagenPassat"),
        Car(name: "VolkswagenTouareg", imageName: "VolkswagenTouareg"),
        Car(name: "AudiA", imageName: "AudiA"),
        Car(name: "AudiA4", imageName: "AudiA4"),
        Car(name: "AudiA7", imageName: "AudiA7"),
        Car(name: "AudiQ3", imageName: "AudiQ3"),
        Car(name: "AudiQ8", imageName: "AudiQ8"),
        Car(name: "VolkswagenBeetle", imageName: "VolkswagenBeetle"),
        Car(name: "VolkswagenGolf", imageName: "VolkswagenGolf"),
        Car(name: "VolkswagenJetta", imageName: "VolkswagenJetta"),
        Car(name: "VolkswagenPassat", imageName: "VolkswagenPassat"),
        Car(name: "VolkswagenTouareg", imageName: "VolkswagenTouareg"),
        Car(name: "AudiA", imageName: "AudiA"),
    ]
   
    override func viewDidLoad() {
        super.viewDidLoad()

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellHeight = (collectionView.frame.height - max(0, numberOfRows)*horizontalSpacing)/(numberOfRows + 1)
            flowLayout.itemSize = CGSize(width: cellHeight, height: cellHeight)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentefier, for: indexPath) as! CollectionViewCell
        let currentCat = cars[indexPath.row]
        cell.setupSell(with: currentCat)
        return cell
    }
}

