//
//  SendRequestViewModel.swift
//  Eva
//
//  Created by AmrFawaz on 21/10/2021.
//  Copyright © 2021 AmrFawaz. All rights reserved.
//

import Foundation

enum RequstType {
    case service
    case project
    case contactUs
}
protocol SendRequestDelegate: AnyObject {
    func onStateChanged(state: LoadingState)
    func showNameError(_ show: Bool, error: String)
    func showEmailError(_ show: Bool, error: String)
    func showMobileError(_ show: Bool, error: String)

}
protocol SendRequestViewModelCoordinator: AnyObject {
    func showSuccessView()
}

class SendRequestViewModel {
    private let coordinator: SendRequestViewModelCoordinator
    private unowned var delegate: SendRequestDelegate?
    private let service: Service?
    private let project: Project?
    private let requestType: RequstType
    var isValidForm = true
    
    private var name: String?
    private var email: String?
    private var mobile: String?
    private var details: String?
    
    // MARK: - State management
    private var state: LoadingState = .loading {
        didSet {
            delegate?.onStateChanged(state: state)
        }
    }

    // MARK: - Initializer

    init(coordinator: SendRequestViewModelCoordinator, service: Service?, project: Project?, requestType: RequstType) {
        self.coordinator = coordinator
        self.service = service
        self.project = project
        self.requestType = requestType
    }
    
    func configure(with delegate: SendRequestDelegate) {
        self.delegate = delegate
    }
    
    func getRequestType() -> RequstType {
        return requestType
    }
    
    func getServiceImageUrl() -> String {
        switch requestType {
        case .project:
            return project?.image ?? ""
        case .service:
            return service?.image ?? ""
        case .contactUs:
            return ""
        }
    }
    
    func getServiceTitle() -> String {
        switch requestType {
        case .project:
            return project?.title ?? ""
        case .service:
            return service?.title ?? ""
        case .contactUs:
            return ""
        }
    }

    func getServiceContent() -> String {
        switch requestType {
        case .project:
            return project?.content ?? ""
        case .service:
            return service?.content ?? ""
        case .contactUs:
            return ""
        }
    }
    
    func getService() -> Service? {
        return service
    }
    
    func getProject() -> Project? {
        return project
    }

    // Form Setters
    func setName(name: String) {
        self.name = name
    }
    func setEmail(email: String) {
        self.email = email
    }
    func setMobile(mobile: String) {
        self.mobile = mobile
    }
    func setMoreDetails(details: String) {
        self.details = details
    }


    // MARK: - Validation
    func validateName() {
        if let name = self.name {
            if !name.isEmpty {
                delegate?.showNameError(false, error: "")
                return
            }
        }
        isValidForm = false
        delegate?.showNameError(true, error: "هذا الحقل مطلوب.")
    }
    
    
    func validateEmail() {
        
        if let email = self.email {
            if !email.isEmpty {
                if self.isValidEmail() {
                    delegate?.showEmailError(false, error: "")
                    return
                } else {
                    isValidForm = false
                    delegate?.showEmailError(true, error: "البريد الالكتروني الذي تم إدخاله غير صالح.")
                    return
                }
            }
        }
        isValidForm = false
        delegate?.showEmailError(true, error: "هذا الحقل مطلوب.")
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.email)

    }

    func validateMobile() {
        if let mobile = self.mobile {
            if !mobile.isEmpty {
                delegate?.showMobileError(false, error: "")
                return
            }
        }
        isValidForm = false
        delegate?.showMobileError(true, error: "هذا الحقل مطلوب.")
    }

    
    func sendRequest() {
        self.delegate?.onStateChanged(state: .loading)
        APIClient.sendRequest(parameters: SendRequestRequest(name: name, email: email, mobile: mobile, message: details)) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if response.data?.status == "spam" {
                    self.delegate?.onStateChanged(state: .error(error: ""))
                } else {
                    self.delegate?.onStateChanged(state: .ready())
                }
            case .failure(let error):
                self.delegate?.onStateChanged(state: .error(error: error.localizedDescription))
            }
        }
    }
    
    func showSuccessView() {
        self.coordinator.showSuccessView()
    }
}
