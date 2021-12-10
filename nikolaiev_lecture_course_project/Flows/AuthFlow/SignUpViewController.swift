//
//  SignUpViewController.swift
//  nikolaiev_lecture_course_project
//
//  Created by NikoS on 17.11.2021.
//
import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func signUpButton(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: DefaultKeys.userLoggedIn)
    }
    
    weak var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let placeholder = textField.placeholder {
            UserDefaults.standard.set(textField.text, forKey: placeholder)
        }
        activeField = nil
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
