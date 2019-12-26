//
//  ViewController.swift
//  BookSearch
//
//  Created by MAC on 12/13/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var Result: SearchContainer?
   // var searchMatch: [SearchResult]?
    @IBOutlet var SearchItem: UITextField!
    
    
    @IBAction func SearchButton(_ sender: UIButton) {
        
        let searchField: String = SearchItem.text ?? " "
        
        let searchString = searchField.replacingOccurrences(of: " ", with: "+")
        
        guard let url = URL(string:"http://openlibrary.org/search.json?q=\(searchString)") else {print("URL not found"); return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                let data = data;
                let result = try JSONDecoder().decode(SearchContainer.self, from: data!)
                self.Result = result
              //  print(self.Result?.searchResult)
              //  print(self.searchMatch)
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
            catch {print(error)}
                
        }.resume()
        
    }
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
    super.viewDidLoad()
    
        tableview.dataSource = self
        tableview.delegate = self
        
        tableview.register(UINib (nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
    
  }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        cell.theInfo.text = "\(Result?.searchResult[indexPath.row].title)"
        
        return cell
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(Result?.searchFound ?? 0) matches found for \(SearchItem.text ?? " ")"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Result?.searchFound ?? 0
    }
}


extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let resultDetail = Result?.searchResult[indexPath.row]
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        
        detailViewController.resultDetail = resultDetail
        navigationController?.pushViewController(detailViewController, animated: true)
    }
 }
