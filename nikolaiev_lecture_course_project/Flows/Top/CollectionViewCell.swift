
import UIKit
import Kingfisher

final class CollectionViewCell: UICollectionViewCell {
    
    var car: Car? = nil
    
    @IBOutlet weak var carLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    func setupCell(with car: Car) {
        let url = URL(string: car.imgUrl ?? "")
        self.carImageView.kf.setImage(with: url, placeholder: UIImage(named: "depositphotos_247872612-stock-illustration-no-image-available-icon-vector"))
        self.carLabel.text = "\(car.make?.capitalized ?? "") \(car.model?.capitalized ?? " ")"
    }
}

