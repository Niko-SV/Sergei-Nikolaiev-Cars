
import UIKit
import KeychainAccess

final class SignInViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    @IBAction func signInButtonTapped(_ : UIButton) {
        do {
            let password: String? = try SecureStorage().get(key: emailTextField.text!)
            if(password == nil) {
                showError(message: "User does not exist")
            } else {
                if (password != passwordTextField.text) {
                    showError(message: "Password not correct")
                } else {
                    UserDefaults.standard.set(true, forKey: DefaultsKeys.userLoggedIn)
                    try SecureStorage().put(object: emailTextField.text!, for: SecureStorage.Keys.email)
                    self.performSegue(withIdentifier: "signInSegue", sender: self)
                }
            }
        } catch {
            showError(message: "User does not exist")
        }
   
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message , preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onTextChange(_ sender: Any){
        if (passwordTextField.hasText && emailTextField.hasText) {
            if !signInButton.isUserInteractionEnabled {
                animateButton(alpha: 1)
                signInButton.isUserInteractionEnabled = true
            }
        } else {
            signInButton.alpha = 0.5
            signInButton.isUserInteractionEnabled = false
        }
    }
    weak var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignInViewController.keyboardWillBeHidden),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        signInButton.isUserInteractionEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTextFields()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        style()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        style()
    }
    
    private func style() {
        emailTextField.center.x = view.center.x
        passwordTextField.center.x = view.center.x
    }
    
    
    private func animateTextFields() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.emailTextField.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       options: []) { [weak self] in
            guard let self = self else { return }
            self.passwordTextField.center.x -= self.view.bounds.width
        }
    }
    
    private func animateButton(alpha: Double) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            guard let self = self else { return }
            self.signInButton.alpha = alpha
            self.signInButton.isUserInteractionEnabled = true
        }
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.1,
                       options: [.curveEaseInOut, .autoreverse]) { [weak self] in
            self?.signInButton.transform = .init(scaleX: 1.12, y: 1.12)
        } completion: { _ in
            self.signInButton.transform = .identity
        }
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
