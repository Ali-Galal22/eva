//
//  SuccessViewController.swift
//  Eva
//
//  Created by AmrFawaz on 21/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
import Lottie

class SuccessViewController: UIViewController {
    @IBOutlet weak var successIconView: UIView!
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(dismissView), userInfo: nil, repeats: false)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showSplashAnimation()
    }
    
    func showSplashAnimation() {
        var loadAnimationView: AnimationView?
        loadAnimationView = AnimationView(name: "success")
        loadAnimationView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        loadAnimationView?.contentMode = .scaleAspectFill
        successIconView.addSubview(loadAnimationView!)
        loadAnimationView?.loopMode = .playOnce
        loadAnimationView?.play()
    }

    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

}
