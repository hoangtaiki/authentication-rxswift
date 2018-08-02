//
//  WelcomeViewController.swift
//  Authentication
//
//  Created by Hoangtaiki on 8/1/18.
//  Copyright © 2018 toprating. All rights reserved.
//

import UIKit
import Kingfisher

class WelcomeViewController: UIViewController {

    var user: User!

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avatarImageView.kf.setImage(with: user.avatarURL)
        welcomeLabel.text = "Welcome back, \(user.name)!"
    }

    @IBAction func signOutTap(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

        navigationController?.pushViewController(loginVC, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if navigationController!.viewControllers.count > 1 {
            navigationController?.viewControllers.removeFirst()
        }
    }
}
