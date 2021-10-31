//
//  ServiceDetailsViewController.swift
//  Eva
//
//  Created by AmrFawaz on 22/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit
import Kingfisher
class ServiceDetailsViewController: UIViewController {

    private let viewModel: ServiceDetailsViewModel

    // MARK: - Outlets
    @IBOutlet weak var imageViewService: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    
    // MARK: - Initializers
    init(viewModel: ServiceDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ServiceDetailsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navItem.title = viewModel.getServiceTitle()
        if let imageURL = URL(string: viewModel.getServiceImageUrl()) {
            self.imageViewService.kf.setImage(with: imageURL)
        }
        labelTitle.text = viewModel.getServiceTitle()
        labelContent.text = viewModel.getServiceContent()
        labelContent.setLineHeight(lineHeight: 10)

    }
    
    // MARK: - Actions
    
    @IBAction func barButtonBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
