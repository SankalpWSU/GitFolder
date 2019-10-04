//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by MCS on 10/4/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var url:String = "https://pixabay.com/api/?key=13840195-23543e1b2bdf09ef740592e83&q=penitent&image_type=photo"
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard  let url = URL(string: url) else { print("not getting the url"); return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                let data = data; let json = try JSONDecoder().decode(Dictionary.self, from: data!)
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        return cell
}

}
