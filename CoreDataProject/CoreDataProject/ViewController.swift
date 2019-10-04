//
//  ViewController.swift
//  CoreDataProject
//
//  Created by MCS on 9/27/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var url: String = "https://sv443.net/jokeapi/category/Any"
    var categoriedJokes: [Jokes] = []
    var favJokes: [Jokes] = []
    var showJoke: [Jokes] = []
    var fav: Bool = false
    
    @IBOutlet var categorySegment: UISegmentedControl!
    
    @IBAction func categorySegment(_ sender: UISegmentedControl) {
        switch categorySegment.selectedSegmentIndex {
        case 0: url = "https://sv443.net/jokeapi/category/Any"
           // print("any joke")
            checkFav()
            sortedJokes(with: "Any")
        
        case 1: url = "https://sv443.net/jokeapi/category/Programming"
          //  print("programming joke")
            sortedJokes(with: "Programming")
            
        case 2: url = "https://sv443.net/jokeapi/category/Miscellaneous"
          //  print("misc joke")
            sortedJokes(with: "Miscellaneous")
            
        case 3: url = "https://sv443.net/jokeapi/category/Dark"
          //  print("dark joke")
            sortedJokes(with: "Dark")
            
        case 4: categoriedJokes = favJokes
          //  print("fav jokes")
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            
        default:
            break
        }
    }
    
    @IBAction func getJokeButton(_ sender: UIButton) {
       // print(url)
        let chosen = categorySegment.selectedSegmentIndex
      //  print(chosen)
        getJokes(from: url) { (showJokes) in
            DispatchQueue.main.async {
                if chosen == 0 {
                    self.sortedJokes(with: "Any")
                }
            }
        }
        
        
        
    }
    
    @IBOutlet var tableview: UITableView!
    
    override func viewDidLoad() {
        
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib (nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        
        super.viewDidLoad()
        favJokes = CoreDataManager.shared.getSavedJoke()
        
        print("initial load")
    }
    
    // Start of getJokes func
    func getJokes (from url: String, completed: @escaping ([Jokes]) -> Void){
        guard let url = URL(string: url) else {print("not passing the url"); return }
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in

            do {
                let data = data; let json = try JSONDecoder().decode(Jokes.self, from: data!)
                self.showJoke.append(json)
            
          //     print(self.showJoke)
    
            } catch {
                print(error)
            }
                DispatchQueue.main.async {
                self.tableview.reloadData()
            }
            completed(self.showJoke)
        }.resume()
     //   print("got the joke")
    } // end of getJokes func

    // Start of sort func
    func sortedJokes (with category: String){
        categoriedJokes.removeAll()
        for alljokes in showJoke{
        //    print(category)
            if category == "Any"{
                    self.categoriedJokes.append(alljokes)
                }
            else if category == alljokes.category {
                    self.categoriedJokes.append(alljokes)
                }
            }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    //    print("sorted joke should display")
    } // end of sort func

    func checkFav() {
        
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriedJokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "tableViewCell")
        cell.textLabel?.numberOfLines = 0
      //  print(showJoke.type)
        if categoriedJokes[indexPath.row].type == "single" {
            cell.textLabel?.text = categoriedJokes[indexPath.row].joke
        } else {
            cell.textLabel?.text = "\(categoriedJokes[indexPath.row].setup ?? "") \n\n \(categoriedJokes[indexPath.row].delivery ?? "")"
        }
        for favJoke in favJokes {
            if categoriedJokes[indexPath.row].id == favJoke.id {
                cell.backgroundColor = .yellow
            }
        }
        
        cell.contentView.layer.borderColor = UIColor.black.cgColor
        cell.contentView.layer.borderWidth = 1
        return cell
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        let favJoke = categoriedJokes[indexPath.row]
        if !fav{
        favJokes.append(favJoke)
            cell?.contentView.backgroundColor = .yellow
            CoreDataManager.shared.createJoke(with: favJoke)
            CoreDataManager.shared.saveFav()
            fav = true
            print(favJokes)
        }
        else if fav{
            print(indexPath.row)
                    favJokes.removeAll { (jokeElement) -> Bool in
                        categoriedJokes[indexPath.row].id == jokeElement.id
                    }
            
            cell?.contentView.backgroundColor = .white
            fav = false
        }
    }
}
