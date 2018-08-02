//
//  LoginViewController.swift
//  Authentication
//
//  Created by Hoangtaiki on 8/1/18.
//  Copyright © 2018 toprating. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

class LoginViewController: UIViewController {

    var viewModel = LoginViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!

    let textValidColor = UIColor.white.withAlphaComponent(0.87)
    let textInvalidColor = UIColor.white.withAlphaComponent(0.4)

    override func viewDidLoad() {
        super.viewDidLoad()

        bindUI()
        bindViewModel()
        updateControlStatus()
        addBackgroundGesture()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true

        if navigationController!.viewControllers.count > 1 {
            navigationController?.viewControllers.removeFirst()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension LoginViewController {

    private func bindUI() {
        viewModel.isLoading
            .drive(onNext: { isLoading in
                isLoading ? SVProgressHUD.show() : SVProgressHUD.dismiss()
            })
            .disposed(by: disposeBag)

        viewModel.didLogin
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind { [weak self] user in
                self?.showWelcomeView(forUser: user)
            }
            .disposed(by: disposeBag)
    }

    private func bindViewModel() {
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        signInButton.rx.tap
            .bind(to: viewModel.needLogin)
            .disposed(by: disposeBag)
    }

    private func updateControlStatus() {

        viewModel.isEmailPasswordValid
            .drive(onNext: { [unowned self] isEnabled in
                self.signInButton.isEnabled = isEnabled
                self.signInButton.alpha = isEnabled ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)

        emailTextField.rx
            .controlEvent(UIControlEvents.editingDidEnd)
            .asDriver()
            .withLatestFrom(viewModel.isEmailValid)
            .drive(onNext: { [unowned self] isValid in
                self.emailTextField.textColor = isValid ? self.textValidColor : self.textInvalidColor
            })
            .disposed(by: disposeBag)

        Driver.combineLatest(
            emailTextField.rx.controlEvent(UIControlEvents.editingChanged).asDriver(),
            emailTextField.rx.controlEvent(UIControlEvents.editingDidEnd).asDriver(),
            resultSelector: { _,_ in return () })
            .withLatestFrom(viewModel.isEmailValid)
            .drive(onNext: { [unowned self] isValid in
                self.emailTextField.textColor = isValid ? self.textValidColor : self.textInvalidColor
            })
            .disposed(by: disposeBag)
    }

    private func addBackgroundGesture() {
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .bind { [weak self] _ in
                self?.view.endEditing(true)
            }
            .disposed(by: disposeBag)

        scrollView.addGestureRecognizer(tapBackground)
    }

    private func showWelcomeView(forUser user: User) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let welcomeVC = storyBoard.instantiateViewController(withIdentifier: "WelcomeViewController") as! WelcomeViewController
        welcomeVC.user = user

        navigationController?.pushViewController(welcomeVC, animated: true)
    }

}
