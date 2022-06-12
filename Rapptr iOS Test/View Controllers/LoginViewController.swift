//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    
    // MARK: - Properties
    
    private let loginStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 24
        return stackView
    }()
    
    private let emailField: LoginTextField = {
        let tf = LoginTextField(frame: .zero)
        tf.placeholder = "Email"
        return tf
    }()
    
    private let passwordField: LoginTextField = {
        let tf = LoginTextField(frame: .zero)
        tf.placeholder = "Password"
        return tf
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("LOGIN", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.titleLabel?.textColor = .white
        button.backgroundColor = HexColor("0E5C89")
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        
        if #available(iOS 13.0, *) {
            let backArrow = UIBarButtonItem(image: UIImage(systemName: "chevron.back"), style: .plain, target: self, action: #selector(goBack))
            backArrow.tintColor = .white
            navigationController?.navigationBar.topItem?.backBarButtonItem = backArrow
        } else {
            let backArrow = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
            backArrow.tintColor = .white
            navigationController?.navigationBar.topItem?.backBarButtonItem = backArrow
        }
        
        setUpStackView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    private func setUpStackView() {
        passwordField.isSecureTextEntry = true
        loginButton.addTarget(self, action: #selector(didPressLoginButton), for: .touchUpInside)
        
        loginStackView.addArrangedSubview(emailField)
        loginStackView.addArrangedSubview(passwordField)
        loginStackView.addArrangedSubview(loginButton)
        
        view.addSubview(loginStackView)
        
        loginStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginStackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 30),
            loginStackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -30),
            loginStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 64),
            loginStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailField.heightAnchor.constraint(equalToConstant: 55),
            passwordField.heightAnchor.constraint(equalToConstant: 55),
            loginButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    @objc private func didPressLoginButton(_ sender: Any) {
        login()
    }
    
    private func login() {
        let client = LoginClient()
        let alert = UIAlertController(title: "Login Failed", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        client.login(email: emailField.text ?? "", password: passwordField.text ?? "",
                     completion: { result, time in
            DispatchQueue.main.async {
                if result == "Login Successful!" {
                    alert.message = "Time Elapsed: \(time) milliseconds"
                    }
                alert.title = result
                self.present(alert, animated: true)
            }
        },
                     error: { error in
            DispatchQueue.main.async {
                if let error = error {
                    alert.title = error
                }
                self.present(alert, animated: true)
            }
        })
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
