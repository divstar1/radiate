//
//  GifViewController.swift
//  Radiate
//
//  Created by dkarivarad on 8/22/20.
//  Copyright © 2020 TeamRadiate. All rights reserved.
//

import Foundation
import UIKit

class GifViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.loadGif(name: "logo")
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            let signUpController = self.storyboard?.instantiateViewController(withIdentifier: "signUpController") as! SignUpViewController
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            self.navigationController?.pushViewController(signUpController, animated: true)
        }
    }
}
