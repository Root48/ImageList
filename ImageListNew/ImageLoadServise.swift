//
//  ImageLoadServise.swift
//  ImageListNew
//
//  Created by Admin on 27.06.2021.
//

import Foundation
import Alamofire

enum ImageDownloadState {
    case notStarted
    case inProgres
    case pause
    case done
}

class ImageData {
    
    var cachImage: UIImage?
    var url: String = ""
    var progress: Float = 0
    var imageRequest:DataRequest?
    var state:ImageDownloadState = .notStarted
    
    init (cachImage: UIImage? = nil, url: String = "", progress: Float = 0, imageRequest: DataRequest? = nil, state:ImageDownloadState = .notStarted) {
        self.cachImage = cachImage
        self.url = url
        self.progress = progress
        self.imageRequest = imageRequest
        self.state = .notStarted
    }
    
}

class ImageLoadService {
    
    
    static let shared = ImageLoadService()
    var imageDataArray: [ImageData] = []
    
    func getImageDataFromUrl(url:String) -> ImageData {
        for i in imageDataArray {
            if i.url == url {
                return i
            }
        }
        let imageData = ImageData.init(url: url)
        imageDataArray.append(imageData)
        return imageData
    }
    
    
    
    func fetchImage(fromUrl url: String, cell: TableViewCell) {
        
        var curentImageData: ImageData?
        for i in imageDataArray {
            if i.url == url {
                print("-")
                curentImageData = i
            }
        }
        if curentImageData == nil {
            curentImageData = ImageData.init(url: url)
            imageDataArray.append(curentImageData!)
            print("+")
        }
        
        let unwrapedData = curentImageData!
        if let cachedImage = unwrapedData.cachImage {
            cell.imageView?.image = cachedImage
        }
        cell.progressView.setProgress(unwrapedData.progress, animated: true)
        
        switch unwrapedData.state {
        case .done:
            break
            
        case .pause:
            unwrapedData.imageRequest?.resume()
            unwrapedData.state = .inProgres
            
        case .inProgres:
            unwrapedData.state = .pause
            unwrapedData.imageRequest?.suspend()
            
        case .notStarted:
            unwrapedData.state = .inProgres
            
            
            unwrapedData.imageRequest = request(url)
            unwrapedData.imageRequest?.downloadProgress(closure: { (progress) in
                unwrapedData.progress = Float(progress.fractionCompleted)
                if progress.fractionCompleted == 1 {
                    unwrapedData.state = .done
                }
                
                guard cell.imageUrl == unwrapedData.url else { return }
                cell.progressView.setProgress(Float(progress.fractionCompleted), animated: true)
                cell.progressLabel.text = progress.localizedDescription
            })
            .response { (response) in
                guard let data = response.data, let image = UIImage(data: data) else { return }
                unwrapedData.cachImage = image
                unwrapedData.state = .done
                guard cell.imageUrl == unwrapedData.url else { return }
                cell.cellImageView.image = unwrapedData.cachImage
                print("done")
                DispatchQueue.main.async {
                    cell.cellImageView.image = unwrapedData.cachImage
                }
            }
        }
    }
}
