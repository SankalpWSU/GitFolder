//
//  DetailViewController.swift
//  AnimationProject
//
//  Created by MCS on 10/1/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var poke: Pokemon!
    var detailInfo: DetailInfo!
    var url: String = ""
    var imageString: String = ""
    
    
    
    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var infoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        getInfo(from: url) { (detailInfo) in
            for text in detailInfo.textEntry {
                print(text)
                if text.language.name == "en" {
                    DispatchQueue.main.async {
                        self.infoLabel.text = "The name is : \(self.poke.name) \t Number is: \(self.poke.index) \n\n Description: \(text.text)"
                    }
                    
                }
            }
        }
        
        guard let url = URL(string: imageString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage.init(data: data) else {return}
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
            
        }.resume()
        
        
    }
    func getInfo(from url: String , completed: @escaping (DetailInfo) -> Void ){
        
        guard let url = URL(string: url) else {print("Not passing the url"); return}
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                let data = data; let json = try JSONDecoder().decode(DetailInfo.self, from: data!)
                self.detailInfo = json
                print("\(self.detailInfo)")
            } catch {
                print(error)
            }
            completed(self.detailInfo)
        }.resume()
    }
}
