//
//  ViewController.swift
//  nikolaiev_lecture_5_homework
//
//  Created by Sergio on 03.11.2021.
//

import UIKit
import CoreData

final class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    private let storage = SecureStorage()
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var topImage: UIImageView!
    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet weak private var bioTextView: UITextView!
    @IBOutlet weak private var agreementText: UILabel!
    @IBOutlet weak private var editButton: UIButton!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var agreementSwitch: UISwitch!
    @IBOutlet weak var lastLocationLabel: UILabel!
    
    @IBAction func showButtonTapped() {
        performSegue(withIdentifier: "locationDetailsSegue", sender: self)
    }
    
    weak var activeField: UITextField?
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapDestinationVC = segue.destination as? PlaceInfoViewController {
            mapDestinationVC.userName = textFields[1].text
        }        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lastLocationLabel.text = UserDefaults.standard.string(forKey: DefaultsKeys.userLastLocation)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelected(type: EditModeType.view)
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardDidShow),name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        showSavedData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func agreementSwitchValueChanged(_ sender: UISwitch) {
        saveButton.isEnabled = sender.isOn
    }
    
    @IBAction func editButton(_ : UIButton) {
        viewSelected(type: EditModeType.edit)
        saveButton.isEnabled = false
        agreementSwitch.isOn = false
        textFields[0].becomeFirstResponder()
    }

    @IBAction func saveButton(_ : UIButton) {
        viewSelected(type: EditModeType.view)
        UserDefaults.standard.set(textFields[1].text?.trimmingCharacters(in: .whitespaces), forKey: DefaultsKeys.name)
        UserDefaults.standard.set(textFields[2].text?.trimmingCharacters(in: .whitespaces), forKey: DefaultsKeys.surname)
        UserDefaults.standard.set(bioTextView.text?.trimmingCharacters(in: .whitespaces), forKey: DefaultsKeys.bio)
    }
    
    func showSavedData() {
        do {
            textFields[0].text = try storage.get(key: SecureStorage.Keys.email)
            textFields[1].text = UserDefaults.standard.string(forKey: DefaultsKeys.name)
            textFields[2].text = UserDefaults.standard.string(forKey: DefaultsKeys.surname)
            bioTextView.text = UserDefaults.standard.string(forKey: DefaultsKeys.bio) ?? "Please fill your bio here"
        } catch {
            print("Error: ", error)
        }
    }
    
    @IBAction func logoutButtonTapped(_ : UIBarButtonItem) {
        showAlert()
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes",style: UIAlertAction.Style.destructive, handler: {_ in
            UserDefaults.standard.set(false, forKey: DefaultsKeys.userLoggedIn)
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.name)
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.surname)
            UserDefaults.standard.removeObject(forKey: DefaultsKeys.bio)
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func viewSelected(type: EditModeType){
        let isEditMode = type == EditModeType.edit
        textFields.forEach({$0.isEnabled = isEditMode})
        editButton.isHidden = isEditMode
        bioTextView.isEditable = isEditMode
        agreementText.isHidden = !isEditMode
        agreementSwitch.isHidden = !isEditMode
        saveButton.isHidden = !isEditMode
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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

enum EditModeType {
    case edit
    case view
}


