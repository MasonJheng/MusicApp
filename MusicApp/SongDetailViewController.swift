//
//  SongDetailViewController.swift
//  MusicApp
//
//  Created by masonjheng on 2021/9/6.
//

import UIKit
import AVFoundation

class SongDetailViewController: UIViewController {
    
    let item : StoreItem
    var player : AVPlayer?
    
    init?(coder: NSCoder, item:StoreItem) {
        self.item = item
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        URLSession.shared.dataTask(with: item.artworkUrl500) { data, response, Error in
            if let data = data{
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
    @IBAction func play(_ sender: Any) {
        player = AVPlayer(url: item.previewUrl)
        player?.play()
    }

}
