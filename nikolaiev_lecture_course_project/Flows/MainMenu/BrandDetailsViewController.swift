
import UIKit
import Kingfisher
import CoreData

final class BrandDetailsViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var brandImage: UIImageView!
    @IBOutlet weak private var brandLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var averagePriceLabel: UILabel!
    @IBOutlet weak var averageHorsepowerLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var averagePriceTextField: UITextField!
    @IBOutlet weak var averageHorsepowerTextField: UITextField!
    
    @IBOutlet var brandDetailsView: UIView!
        
    weak var activeField: UITextField?
    
    private func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    private func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func editingTextFields(){
        idTextField.isUserInteractionEnabled = false
        averageHorsepowerTextField.isUserInteractionEnabled = false
        averagePriceTextField.isUserInteractionEnabled = false
    }
    
    private let manager = CoreDataManager.shared
    var brand: NSManagedObject? = nil
    var id: Int?
    var name: String?
    var imgUrl: String?
    var avgHorsepower: Double?
    var avgPrice: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(BrandDetailsViewController.keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(BrandDetailsViewController.keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        if let result = brand {
            id = Int(result.value(forKeyPath: "id") as! Int32)
            name = result.value(forKeyPath: "name") as! String?
            imgUrl = result.value(forKeyPath: "imgUrl") as! String?
            avgHorsepower = result.value(forKeyPath: "avgHorsepower") as! Double?
            avgPrice = result.value(forKeyPath: "avgPrice") as! Double?
            self.setupBrandDetailsScreen(with: result)
            
            editingTextFields()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupBrandDetailsScreen(with brand: NSManagedObject) {
        let url = URL(string: imgUrl ?? "")
        self.brandImage.kf.setImage(with: url)
        self.brandLabel.text = name?.capitalized
        self.idTextField.text = String(describing: id!)
        self.averagePriceTextField.text = String(format: "%.2f", avgPrice!) + " $"
        self.averageHorsepowerTextField.text = String(describing: Int(avgHorsepower!))
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        guard let activeField = activeField, let keyboardHeight = keyboardSize?.height else { return }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        let activeRect = activeField.convert(activeField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(activeRect, animated: true)
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
