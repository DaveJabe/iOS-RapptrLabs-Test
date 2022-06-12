//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
// Importing SpriteKit for particle effects
import SpriteKit
// Importing Lottie to add an AnimationView (using an animation downloaded from lottiefiles.com; located in Extras/drag-animation.json
import Lottie

class AnimationViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     */
    
    // MARK: - Outlets
    @IBOutlet weak var rapptrLabsLogo: UIImageView!
    @IBOutlet weak var fadeButton: UIButton!
    
    private var panGestureRecognizer = UIPanGestureRecognizer()
    
    private var animation: AnimationView?
    
    private var fireScene: SKScene {
        let scene = FireScene()
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .clear
        return scene
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        if #available(iOS 13.0, *) {
            let backArrow = UIBarButtonItem(image: UIImage(systemName: "chevron.back"), style: .plain, target: self, action: #selector(goBack))
            backArrow.tintColor = .white
            navigationController?.navigationBar.topItem?.backBarButtonItem = backArrow
        } else {
            let backArrow = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
            backArrow.tintColor = .white
            navigationController?.navigationBar.topItem?.backBarButtonItem = backArrow
        }
        
        panGestureRecognizer.addTarget(self, action: #selector(dragImage))
        rapptrLabsLogo.isUserInteractionEnabled = true
        rapptrLabsLogo.addGestureRecognizer(panGestureRecognizer)
        rapptrLabsLogo.alpha = 0
        
        configureAnimation()
        configureFireScene()
    }
    
    // MARK: - Actions
    
    @IBAction func didPressFade(_ sender: Any) {
        if rapptrLabsLogo.alpha == 1 {
            UIView.animate(withDuration: 2) {
                self.rapptrLabsLogo.alpha = 0
            }
            fadeButton.setTitle("FADE IN", for: .normal)
            showAnimation(false)
        }
        else {
            UIView.animate(withDuration: 2) {
                self.rapptrLabsLogo.alpha = 1
            }
            fadeButton.setTitle("FADE OUT", for: .normal)
            showAnimation(true)
        }
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func dragImage(_ sender: UIPanGestureRecognizer) {
        showAnimation(false)
        let translation = sender.translation(in: self.view)
        rapptrLabsLogo.center = CGPoint(x: rapptrLabsLogo.center.x + translation.x,
                                        y: rapptrLabsLogo.center.y + translation.y)
        sender.setTranslation(.zero, in: self.view)
    }
    
    private func configureAnimation() {
        animation = AnimationView(name: "drag-animation")
        animation?.frame = CGRect(x: 0,
                                  y: view.frame.size.height/2,
                                 width: 75,
                                 height: 75)
        animation?.loopMode = .loop
        view.addSubview(animation!)
        animation?.play()
        showAnimation(false)
    }
    
    // The purpose of this function is to hide the animation when the Rapptr Labs logo is hidden or dragged away from it's initial position
    private func showAnimation(_ show: Bool) {
        if show {
            animation!.isHidden = false
        }
        else {
            animation!.isHidden = true
        }
    }
    
    private func configureFireScene() {
        let spriteView = SKView()
        spriteView.frame = CGRect(x: 0,
                                  y: 0,
                                  width: view.frame.size.width*2,
                                  height: view.frame.size.height*2)
        spriteView.backgroundColor = .clear
        // Inserting spriteView below the fadeButton to ensure that it will not prevent interaction with other views
        view.insertSubview(spriteView, belowSubview: fadeButton)
        spriteView.presentScene(fireScene)
    }
}
