//
//  DetailVC.swift
//  ImageListNew
//
//  Created by Admin on 24.06.2021.
//

import UIKit

class DetailVC: UIViewController {
    
    var image: UIImage?

    @IBOutlet weak var detailImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailImage.image = image
    }
}
