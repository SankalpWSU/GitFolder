//
//  ViewController.swift
//  ClueGameProject
//
//  Created by MCS on 9/24/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    var urlString: String = "http://jservice.io//api/clues"
    
    var newDictionary: [Highlight] = []
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableView.dataSource = self
        tableView.delegate = self
       tableView.register(UINib (nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
      
        
        guard let url = URL(string: urlString) else {print("not passing the url gaurd"); return}
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, _) in
        //    print("the data is : \(data)")
            do {
                let data = data; let json = try JSONDecoder().decode([Highlight].self, from: data!)
                print ("this is json :\(json)")
                for item in json {
                    _ = item.answer
                }
                self.newDictionary = json
                let savedHighlight = CoreDataManager.shared.getSavedStar()
                
                let dict = self.newDictionary
                for values in 0..<dict.count {
                    for value in 0..<savedHighlight.count {
                if dict[values].id == savedHighlight[value].id {
                    self.newDictionary[values] = savedHighlight[value]
                }
                }
                }
            }
            catch{
               print(error)
            }
            
            
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
        }.resume()
        
    }

}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(newDictionary.count)
        return newDictionary.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
       cell.questionLabel.text = "Question: \( newDictionary[indexPath.row].question)"
        cell.answerLabel.text = "Clue: \( newDictionary[indexPath.row].answer)"
        cell.valueLabel.text = "Clue Value: \( newDictionary[indexPath.row].clueValue )"
        
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 1
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dict = newDictionary[indexPath.row]
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.newDictionary = dict
        
    navigationController?.pushViewController(detailViewController, animated: true)
    }
}
