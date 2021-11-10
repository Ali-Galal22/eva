//
//  StartUpViewController.swift
//  MYWE
//
//  Created by AmrFawaz on 04/10/2021.
//  Copyright © 2021 Segmatek. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var buttonSkip: UIButton!
    @IBOutlet weak var buttonOurProjects: UIButton!
    
    private let viewModel: StartUpViewModel

    // MARK: - Initializers

    init(viewModel: StartUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "StartUpViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.navigateToHome()
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    // MARK: - Actions
    @IBAction func buttonSkipClicked(_ sender: Any) {
        viewModel.navigateToHome()
    }
    
    @IBAction func buttonOurProjectsClicked(_ sender: Any) {
        viewModel.navigateToHome()
    }
}




