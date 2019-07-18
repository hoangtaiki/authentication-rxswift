//
//  LoginViewModel.swift
//  Authentication
//
//  Created by Hoangtaiki on 8/1/18.
//  Copyright © 2018 toprating. All rights reserved.
//

import RxCocoa
import RxSwift

class LoginViewModel {

    // Because we don't have backend api
    // So that we will use below user for checking authorize
    let userEmail = "duchoang.vp@gmail.com"
    let userPassword = "12345678"

    let email = BehaviorRelay(value: "")
    let password = BehaviorRelay(value: "")
    let needLogin = PublishSubject<Void>()

    let isEmailValid: Driver<Bool>
    let isPasswordValid: Driver<Bool>
    let isEmailPasswordValid: Driver<Bool>
    var didLogin = PublishSubject<User>()

    let isLoading: Driver<Bool>
    let error = PublishSubject<Error>()
    private let disposeBag = DisposeBag()
    private let indicator = ActivityIndicator()

    init() {
        isLoading = indicator.asDriver()

        isEmailValid = email
            .asDriver()
            .map { $0.isValidEmail() }

        isPasswordValid = password
            .asDriver()
            .map { $0.count >= 6 }

        isEmailPasswordValid = Driver.combineLatest(
            email.asDriver(),
            isEmailValid,
            isPasswordValid
        ) { email, isValidEmail, isValidPassword in
            return !email.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
                && isValidEmail
                && isValidPassword
        }

        let loginParams = Driver.combineLatest(
            email.asDriver(),
            password.asDriver()
        ) { (email: $0, password: $1) }

        needLogin
            .withLatestFrom(loginParams)
            .flatMapLatest { [unowned self] (email, password) in
                self.logIn(email: email, password: password)
                    .trackActivity(self.indicator)
                    .catchError { [unowned self] error in
                        self.error.onNext(error)
                        return Observable.empty()
                }
            }
            .bind(to: didLogin)
            .disposed(by: disposeBag)
    }

    func logIn(email: String, password: String) -> Observable<User> {
        return Observable.create { observer in
            if email == self.userEmail && password == self.userPassword {
                let reponseUser = User(id: 1, name: "Parzival",
                                       email: email,
                                       avatarURL: URL(string: "https://i.imgur.com/xs16PGl.png"),
                                       phoneNumber: "+841244881992")
                observer.onNext(reponseUser)
                observer.onCompleted()
            } else {
                let error = NSError(domain: "org.toprating.authentication", code: 1000,
                                    userInfo: [NSLocalizedDescriptionKey: "The email or password is incorrect"])
                observer.onError(error)
            }

            return Disposables.create()
            
        }.delaySubscription(DispatchTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
    }

}

extension String {

    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
