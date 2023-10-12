//
//  LoaderViewController.swift
//  GBMChallengue
//
//  Created by javier pineda on 11/10/23.
//

import UIKit
import Lottie

class LoaderViewController: UIViewController {
    ///////////////////////////////////////
    // MARK: Outlets
    ///////////////////////////////////////
    @IBOutlet weak var animationView: LottieAnimationView!
    ///////////////////////////////////////
    // MARK: Presenter
    ///////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
    }
    
    private func setupAnimation() {
        animationView.loopMode = .loop
        animationView.play()
    }
}
