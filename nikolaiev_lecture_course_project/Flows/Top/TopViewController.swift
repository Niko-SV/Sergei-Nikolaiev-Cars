//
//  EditFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit
import Kingfisher

final class TopViewController: UICollectionViewController {
    
    private var activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    private let reuseIdentefier = "cell"
    let numberOfRows: CGFloat = 4
    private var cars = [Car]()
    let service = NetworkService()
    
    private let sectionInsets = UIEdgeInsets(
        top: 24.0,
        left: 16.0,
        bottom: 24.0,
        right: 16.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
 
        activityIndicator.color = UIColor.red
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        view.addSubview(activityIndicator)
        fetchData()
    }

    func fetchData() {
        
        service.fetch(from: NetworkPath.cars, model: [Car].self) { (result: NetworkService.Result) in
            switch result {
            case let .success(value):
                self.cars = value as! [Car]
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.collectionView?.reloadData()
                }
            case let .error(error):
                print("Error ", error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentefier, for: indexPath)
        if let collectionCell = cell as? CollectionViewCell {
            let currentCar = cars[indexPath.row]
            collectionCell.setupCell(with: currentCar)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Top", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewCellDetailsController") as! CollectionViewCellDetailsController
        vc.car = cars[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 100, right: 0)
        let paddings = sectionInsets.top + sectionInsets.bottom
        let freeSpace = collectionView.bounds.size.height - paddings
        let spaceForItem = freeSpace / CGFloat(numberOfRows + 1)
        let size = CGSize(width: spaceForItem, height: spaceForItem)
        
        return size
    }
}
