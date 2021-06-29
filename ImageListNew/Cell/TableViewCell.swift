//
//  TableViewCell.swift
//  ImageListNew
//
//  Created by Admin on 24.06.2021.
//

import UIKit
import Alamofire



class TableViewCell: UITableViewCell {
    
    
    var closureImage: (() -> Void)?
    var closureSend: (() -> Void)?
    var imageUrl:String?
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var invisibleButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
        self.cellImageView?.image = UIImage(named: "default")
        self.progressView.progress = 0
        self.progressLabel.text = "0% completed"
    }
    
    func applyImageData(_ imageData: ImageData) {
        if let image = imageData.cachImage {
            self.cellImageView.image = image
        }
        
        progressView.setProgress(imageData.progress, animated: false)
        let percents = Int(imageData.progress * 100)
        progressLabel.text = "\(percents)% completed"
    }
    
    @IBAction func StopStartButton(_ sender: Any) {
        self.closureImage?()
    }
    
    @IBAction func invisibleButton(_ sender: Any) {
        self.closureSend?()
    }
    
}
