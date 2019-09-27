//
//  ViewController.swift
//  CoreDataProject
//
//  Created by MCS on 9/27/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var url: String = "https://sv443.net/jokeapi/category/Programming"
    
    var showJoke: Jokes!
    var rowCount: Int = 1
    
    @IBOutlet var categorySegment: UISegmentedControl!
    
    @IBAction func categorySegment(_ sender: UISegmentedControl) {
        switch categorySegment.selectedSegmentIndex {
        case 0: print("first segment")
        
        case 1: print("second segment")
            
        case 2: print("third segment")
            
        case 3: print("forth segment")
            
        case 4: print("fifth segment")
            
        default:
            break
        }
    }
    
    @IBAction func getJokeButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet var tableview: UITableView!
    
    
    
    
    override func viewDidLoad() {
        
        tableview.dataSource = self
        tableview.register(UINib (nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let url = URL(string: url) else {print("not passing the url"); return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            print(data)
            print(error)
            do {
                let data = data; let json = try JSONDecoder().decode(Jokes.self, from: data!)
               // print(json)
                self.showJoke = json
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }.resume()
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "tableViewCell")
        cell.textLabel?.numberOfLines = 0
        if showJoke.type == "single" {
            print("reached point 1")
            cell.textLabel?.text = "\(showJoke.joke ?? "no joke")"
        } else {
            print("reached point 2")
            cell.textLabel?.text = "\(showJoke.setup ?? "no setup")\n\n\n \(showJoke.delivery)"
            
        }
        
        return cell
    }
}
