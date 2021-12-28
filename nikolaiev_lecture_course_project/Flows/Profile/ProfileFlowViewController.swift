//
//  ViewController.swift
//  nikolaiev_lecture_5_homework
//
//  Created by Sergio on 03.11.2021.
//

import UIKit

class ProfileFlowViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var topImage: UIImageView!
    @IBOutlet private var textFields: [UITextField]!
    @IBOutlet weak private var bioTextView: UITextView!
    @IBOutlet weak private var agreementText: UILabel!
    @IBOutlet weak private var editButton: UIButton!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var agreementSwitch: UISwitch!
    
    weak var activeField: UITextField?
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSelected(type: EditModeType.view)
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileFlowViewController.keyboardDidShow),name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileFlowViewController.keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func agreementSwitchValueChanged(_ sender: UISwitch) {
        saveButton.isEnabled = sender.isOn
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        viewSelected(type: EditModeType.edit)
        saveButton.isEnabled = false
        agreementSwitch.isOn = false
        textFields[0].becomeFirstResponder()
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        viewSelected(type: EditModeType.view)
    }
    
    private func viewSelected(type: EditModeType) {
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

