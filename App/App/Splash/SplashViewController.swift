//
//  ViewController.swift
//  App
//
//  Created by Максим Шаптала on 27.01.2021.
//

import UIKit

final class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let vc = UIStoryboard(name: "Feed", bundle: .main).instantiateInitialViewController() else { fatalError() }
        vc.modalPresentationStyle = .currentContext
        present(vc, animated: false, completion: nil)
    }

}

