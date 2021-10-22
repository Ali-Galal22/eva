//
//  SendRequestViewController.swift
//  Eva
//
//  Created by AmrFawaz on 20/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import UIKit

class SendRequestViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var imageViewService: UIImageView!
    @IBOutlet weak var labelServiceName: UILabel!
    @IBOutlet weak var labelServiceDetails: UILabel!
    @IBOutlet weak var buttonServiceDetails: UIButton!
    
    
    @IBOutlet weak var labelNameTitle: UILabel!
    @IBOutlet weak var textfieldName: UITextField!
    @IBOutlet weak var labelErrorName: UILabel!
    
    @IBOutlet weak var labelEmailTitle: UILabel!
    @IBOutlet weak var textfieldEmail: UITextField!
    @IBOutlet weak var labelErrorEmail: UILabel!
    
    @IBOutlet weak var labelMobileTitle: UILabel!
    @IBOutlet weak var textfieldMobile: UITextField!
    @IBOutlet weak var labelErrorMobile: UILabel!

    @IBOutlet weak var labelMoreDetailsTitle: UILabel!
    @IBOutlet weak var textviewMoreDetails: UITextView!
    
    
    
    
    private let viewModel: SendRequestViewModel
    private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Initializers
    init(viewModel: SendRequestViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "SendRequestViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator = view.addLoadingIndicator()
        viewModel.configure(with: self)
        if let imageURL = URL(string: viewModel.getServiceImageUrl()) {
            self.imageViewService.kf.setImage(with: imageURL)
        }
        
        labelServiceName.text = viewModel.getServiceTitle()
        labelServiceDetails.text = viewModel.getServiceContent()
    }

    
    // MARK: - Actions
    @IBAction func buttonBackDidClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func buttonDetailsClicked(_ sender: Any) {
    }
    
    @IBAction func buttonSendRequestClicked(_ sender: Any) {
        viewModel.isValidForm = true
        viewModel.validateName()
        viewModel.validateEmail()
        viewModel.validateMobile()
        
        if !viewModel.isValidEmail() {
            return
        } else {
            viewModel.sendRequest()
        }
        
    }
}

extension SendRequestViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        switch textField {
        case textfieldName:
            viewModel.setName(name: text)
        case textfieldEmail:
            viewModel.setEmail(email: text)
        case textfieldMobile:
            viewModel.setMobile(mobile: text)
        default:
            break
        }
    }
}

extension SendRequestViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else { return }
        viewModel.setMoreDetails(details: text)
    }
}


extension SendRequestViewController: SendRequestDelegate {
    func showNameError(_ show: Bool, error: String) {
        self.labelErrorName.isHidden = !show
        if show {
            self.labelErrorName.text = error
        }
    }
    
    func showEmailError(_ show: Bool, error: String) {
        self.labelErrorEmail.isHidden = !show
        if show {
            self.labelErrorEmail.text = error
        }

    }
    
    func showMobileError(_ show: Bool, error: String) {
        self.labelErrorMobile.isHidden = !show
        if show {
            self.labelErrorMobile.text = error
        }

    }
    
    
    func onStateChanged(state: LoadingState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .ready:
            activityIndicator.stopAnimating()
            self.dismiss(animated: true) {
                self.viewModel.showSuccessView()
            }
//            viewModel.showSuccessView()
        case .error:
            activityIndicator.stopAnimating()
            break
        }
    }
    

}
