//
//  ViewController.swift
//  nikolaiev_lecture_5_homework
//
//  Created by Sergio on 03.11.2021.
//

import UIKit

class ProfileFlowViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var agreementText: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var agreementSwitch: UISwitch!
    
    weak var activeField: UITextField?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let placeholder = textField.placeholder {
            UserDefaults.standard.set(textField.text, forKey: placeholder)
        }
        activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelection(type: EditModeType.view)
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileFlowViewController.keyboardDidShow),name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileFlowViewController.keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        textFields.forEach({
            if let placeholder = $0.placeholder {
                $0.text = UserDefaults.standard.string(forKey: placeholder)
            }
        })
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func agreementSwitch(_ sender: UISwitch) {
        saveButton.isEnabled = sender.isOn
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        viewSelection(type: EditModeType.edit)
        saveButton.isEnabled = false
        agreementSwitch.isOn = false
        textFields[0].becomeFirstResponder()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        viewSelection(type: EditModeType.view)
    }
    
    
    @IBAction func logoutButton(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Logout", message: "Are you sure you want to logout?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Logout",style: UIAlertAction.Style.destructive, handler: {_ in
            UserDefaults.standard.set(false, forKey: DefaultKeys.userLoggedIn)
            self.textFields.forEach({
                if let placeholder = $0.placeholder {
                    UserDefaults.standard.removeObject(forKey: placeholder)
                }
            })
    
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func viewSelection(type: EditModeType){
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


