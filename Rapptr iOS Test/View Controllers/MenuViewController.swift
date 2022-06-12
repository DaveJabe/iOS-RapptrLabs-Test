//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     */
    
    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuring all of the UI elements in this view controller to match the mock-up
        
        title = "Coding Tasks"
        
        let navBar = navigationController?.navigationBar
        
        navBar?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 64)
        navBar?.backgroundColor = HexColor("0E5C89")
        navBar?.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17, weight: .semibold), .foregroundColor: UIColor.white]
        
        chatButton.layer.masksToBounds = true
        loginButton.layer.masksToBounds = true
        animationButton.layer.masksToBounds = true
        
        chatButton.layer.cornerRadius = 8
        loginButton.layer.cornerRadius = 8
        animationButton.layer.cornerRadius = 8
        
        chatButton.alpha = 0.8
        loginButton.alpha = 0.8
        animationButton.alpha = 0.8
        
        chatButton.setIconAndLabelPadding(leftEndToIcon: 22, iconToLabel: 16)
        loginButton.setIconAndLabelPadding(leftEndToIcon: 22, iconToLabel: 16)
        animationButton.setIconAndLabelPadding(leftEndToIcon: 22, iconToLabel: 16)
    }
    
    // MARK: - Actions
    @available(iOS 13.0, *)
    @IBAction func didPressChatButton(_ sender: Any) {
        let chatViewController = ChatViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
}
