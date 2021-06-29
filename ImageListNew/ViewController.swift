//
//  ViewController.swift
//  ImageListNew
//
//  Created by Admin on 24.06.2021.
//

import UIKit
import Alamofire



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let imageNameArray = ["1. Монна Ліза", "2. Останній день Помпеї", "3. Зоряна ніч", "4. Чудо Георгия gпро змія", "5. Сад земних насолод", "6. Шулера", "7. Ватсон і акула", "8. Сатурн, пожирающий своего сына", "9. Едоки картофеля", "10. Плот Медузы", "11. Бурлаки на Волзі", "12. Сусанна и старейшины", "13. Клиника Гросса", "14. Странник над морем тумана", "15. Сборщицы колосьев", "16. Крик", "17. Велика хвиля в Канаґава", "18. Тайна вечеря", "19. Дівчина з перловою сережкою", "20.Бриг «Меркурий»"]
    let imageURLArray = ["https://15jj.short.gy/EttqEo", "https://15jj.short.gy/l7DEsU", "https://15jj.short.gy/ygCQPn", "https://15jj.short.gy/UxVmZc", "https://15jj.short.gy/LCevft", "https://15jj.short.gy/Xi8E9b", "https://15jj.short.gy/Xly1X6", "https://15jj.short.gy/oGNVvq", "https://15jj.short.gy/uZS1yO", "https://15jj.short.gy/bYO4is", "https://15jj.short.gy/kUoYO6", "https://15jj.short.gy/HuHZOX", "https://15jj.short.gy/HswACl", "https://15jj.short.gy/7llY75", "https://15jj.short.gy/GkUrpo", "https://15jj.short.gy/Mtfp6H", "https://15jj.short.gy/YGSjLf", "https://15jj.short.gy/y6GxwQ", "https://15jj.short.gy/MjsLNk", "https://15jj.short.gy/as2P7Z"]
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondVC = segue.destination as! DetailVC
        let url = sender as! String
        let data = ImageLoadService.shared.getImageDataFromUrl(url: url)
        secondVC.image = data.cachImage
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNameArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell {
            let url = imageURLArray[indexPath.row]
            cell.imageUrl = url
            
            let imgData = ImageLoadService.shared.getImageDataFromUrl(url: url)
            cell.applyImageData(imgData)
            
            cell.closureImage = {
                ImageLoadService.shared.fetchImage(fromUrl: url, cell: cell)
            }
            
            cell.closureSend = {
                let data = ImageLoadService.shared.getImageDataFromUrl(url: url)
                if  data.state == .done  {
                    self.performSegue(withIdentifier: "goToDetail", sender: url)
                }
            }
            
            cell.label.text = imageNameArray[indexPath.row]
            cell.imageView?.image = nil
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
        
    }
}

