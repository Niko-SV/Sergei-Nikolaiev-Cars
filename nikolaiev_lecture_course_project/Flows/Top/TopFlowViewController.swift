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
        Car(name: "BMW1", imageName: "BMW1"),
        Car(name: "BMWi8", imageName: "BMWi8"),
        Car(name: "BMWX5", imageName: "BMWX5"),
        Car(name: "BMWM5", imageName: "BMWM5"),
        Car(name: "Fiat500", imageName: "Fiat500"),
        Car(name: "Fiat500x", imageName: "Fiat500x"),
        Car(name: "FiatTipo", imageName: "FiatTipo"),
        Car(name: "FordEscape", imageName: "FordEscape"),
        Car(name: "FordFiesta", imageName: "FordFiesta"),
        Car(name: "FordFocuc", imageName: "FordFocus"),
        Car(name: "HondaAccord", imageName: "HondaAccord"),
        Car(name: "HondaCivic", imageName: "HondaCivic"),
        Car(name: "HondaCRV", imageName: "HondaCRV"),
        Car(name: "MercedesA", imageName: "MercedesA"),
        Car(name: "MercedesGLA", imageName: "MercedesGLA"),
        Car(name: "MercedesS", imageName: "MercedesS"),
        Car(name: "MercedesML", imageName: "MercedesML"),
        Car(name: "MiniCooper", imageName: "MiniCooper"),
        Car(name: "MiniCountryman", imageName: "MiniCountryman"),
        Car(name: "MitsubishiLancer", imageName: "MitsubishiLancer"),
        Car(name: "MitsubishiOutlander", imageName: "MitsubishiOutlander"),
        Car(name: "MitsubishiPajero", imageName: "MitsubishiPajero"),
        Car(name: "NissanSkyline", imageName: "NissanSkyline"),
        Car(name: "NissanXTrail", imageName: "NissanXTrail"),
        Car(name: "Peugeot107", imageName: "Peugeot107"),
        Car(name: "Peugeot208", imageName: "Peugeot208"),
        Car(name: "Peugeot3008", imageName: "Peugeot3008"),
        Car(name: "SkodaFabia", imageName: "SkodaFabia"),
        Car(name: "SkodaOctavia", imageName: "SkodaOctavia"),
        Car(name: "SmartForfour", imageName: "SmartForfour"),
        Car(name: "SmartFortwo", imageName: "SmartFortwo"),
        Car(name: "ToyotaCamry", imageName: "ToyotaCamry"),
        Car(name: "ToyotaPrado", imageName: "ToyotaPrado"),
        Car(name: "ToyotaCorolla", imageName: "ToyotaCorolla"),
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

