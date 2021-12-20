//
//  EditFlowViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 16.11.2021.
//

import UIKit
import Kingfisher

final class TopFlowViewController: UICollectionViewController {
    
    private let reuseIdentefier = "cell"
    let numberOfRows: CGFloat = 4
    private var cars = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellHeight = (collectionView.frame.height - max(0, numberOfRows)*horizontalSpacing)/(numberOfRows + 1)
            flowLayout.itemSize = CGSize(width: cellHeight, height: cellHeight)
            
        }
        
        fetchData()
    }
    
    func fetchData() {
        
        guard let url = URL(string: Constants.carsJsonURLString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.cars = try decoder.decode([Car].self, from: data)
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            } catch let error{
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentefier, for: indexPath) as! CollectionViewCell
        let currentCar = cars[indexPath.row]
        cell.setupCell(with: currentCar)
        return cell
    }
}

