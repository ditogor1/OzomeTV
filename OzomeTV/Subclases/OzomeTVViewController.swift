//
//  OzomeTVViewController.swift
//  OzomeTV
//
//  Created by VICTOR ALEJANDRO REZA RODRIGUEZ on 2/11/21.
//

import UIKit
import APESuperHUD

class OzomeTVViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func showLoading(_ message: String = "Please Wait...") {
        APESuperHUD.show(style: .loadingIndicator(type: .standard), title: nil, message: message)
    }
    
    func hideLoading() {
        APESuperHUD.dismissAll(animated: true)
    }
    
    func showError(_ error: Error) {
        showAlert("Error", message: error.localizedDescription)
    }
    
    func showAlert(_ title: String, message: String, _ action: UIAlertAction? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = action ?? UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}
