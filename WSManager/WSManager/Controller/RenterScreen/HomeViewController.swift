//
//  HomeViewController.swift
//  WeSports
//
//  Created by datNguyem on 18/11/2021.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarUIView?.backgroundColor = .red
    }
}
