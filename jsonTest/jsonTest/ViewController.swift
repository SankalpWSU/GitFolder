//
//  ViewController.swift
//  jsonTest
//
//  Created by MCS on 9/20/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var url: String = "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes"
    
    
  /* var dictionary: [String: Any] = [:]
    var arrayValue: [String: Any] = [:]
    var dictionaryKeys: [String] {
        return Array(dictionary.keys.sorted())
    }
    var dictionaryKeyValue: Any = ""
 */
    var arrayOfEpisodes: [Episodes] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.register(UINib (nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        // Do any additional setup after loading the view.
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , let json = try? JSONDecoder().decode(dictionary.self, from: data) else {return}
         //   self.dictionary = json["_embedded"] as! [String : Any]
         /*   guard let newData = try? self.dictionary, let episodes = try? JSONDecoder().decode(Episodes.self, from: newData) else {return} */
         //   self.arrayOfContent = self.dictionary["episodes"] as! [Any]
            
          //  print(json)
          //  print(json._embedded.episodes)
            self.arrayOfEpisodes = json._embedded.episodes
            print(self.arrayOfEpisodes)
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
            
        }.resume()
    }

}

struct dictionary: Codable {
    let _embedded: Embedded
}

struct Embedded: Codable {
    let episodes: [Episodes]
    
    enum embeddedCodingKey: String, CodingKey{
        case episodes
    }
    
   /* init(from decoder: Decoder) throws {
        let embeddedContainer = try decoder.container(keyedBy: embeddedCodingKey.self)
        episodes = try! embeddedContainer.decode([Episodes].self, forKey: .episodes)
    }*/
}

struct Episodes: Codable {
    let id: Int
    let url: String
    let name: String
    let season: Int
    let number: Int
    let airdate: String
    let airtime: String
    let airstamp: String
    let runtime: Int
    let summary: String
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEpisodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.episodeLabel.text = "Episode \(arrayOfEpisodes[indexPath.row].number)"
        cell.seasonLabel.text = "Season \(arrayOfEpisodes[indexPath.row].season)"
        cell.episodeNameLabel.text = arrayOfEpisodes[indexPath.row].name
        
     /*   dictionaryKeyValue = dictionary["episodes"] as Any
        
        for value in 0..<self.arrayOfContent.count{
            self.arrayValue = arrayOfContent[value] as! [String : Any]
            print(value, arrayValue)
            
        }
        
        cell.episodeLabel.text = "Episode \(arrayValue["number"] ?? Int.self)"
        cell.seasonLabel.text = "Season \(arrayValue["season"] ?? Int.self)"
        cell.episodeNameLabel.text = arrayValue["name"] as? String
      //  arrayValue = arrayOfContent[indexPath.row] as! [String : Any]
        
        
            //   cell.seasonLabel.text = "Season \(arrayValue["season"])"
             //  cell.episodeNameLabel.text = arrayValue["name"] as? String
        
        
    //    cell.episodeLabel.text = "Episode \(arrayValue["number"])"
    //    cell.seasonLabel.text = "Season \(arrayValue["season"])"
     //   cell.episodeNameLabel.text = arrayValue["name"] as? String
        
        print ("this should be array \(arrayValue.count)")
        */
        
        
        return cell
    }

}
