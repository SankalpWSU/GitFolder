//
//  ViewController.swift
//  JsonNewProject
//
//  Created by MCS on 9/17/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var dictionary: [String: Any] = [:]
    var dictionaryKeys: [String] {
        return Array(dictionary.keys.sorted())
    }
    var dictionaryKeyValue: Any = ""
    var url: String = "https://pokeapi.co/api/v2"
   // var noOFRows: Int = 0
    var urlFlag = true
    var dictionaryFlag = true
    var arrayFlag = false
    var nextArray: [Any] = []
    
    @IBOutlet var tabelView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabelView.dataSource = self
        tabelView.delegate = self
        
        if urlFlag{
            getDictionary(from: url)
        }
        
        
        
    }
    
    func getDictionary(from url: String) -> Void {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
            
            self.dictionary = json
        //    self.noOFRows = self.dictionaryKeys.count
            
           print(self.dictionary)
            // to reload the tableView after we get all the data from the URL
            DispatchQueue.main.async {
                self.tabelView.reloadData()
            }
            
            }.resume()
    }
    
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return todoList.count / 2
       // return todoList.count
       // print (dictionaryKeys.count)
        if dictionaryFlag{
            return dictionaryKeys.count
        } else if arrayFlag{
            return nextArray.count
        }
        
    return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "tableViewCell")
        
        
        
        
        if dictionaryFlag {
            let key = dictionaryKeys[indexPath.row]
            dictionaryKeyValue = dictionary[key] as Any
            
       cell.textLabel?.text = dictionaryKeys[indexPath.row]
     //  print(dictionaryKeyValue)
            
            if dictionaryKeyValue is String {
                cell.detailTextLabel?.text = dictionaryKeyValue as? String
              //  print("this should be string url value : \(dictionaryKeyValue)")
            }else if dictionaryKeyValue is Int {
                cell.detailTextLabel?.text = "\(dictionaryKeyValue as! Int)"
              //  print("this should be int value : \(dictionaryKeyValue)")
            }else if dictionaryKeyValue is Bool {
                cell.detailTextLabel?.text = "\(dictionaryKeyValue as? Bool)"
             //   print("this should be bool value : \(dictionaryKeyValue)")
            }else if dictionaryKeyValue is Array<Any> {
                let arrayCount: Int = (dictionaryKeyValue as AnyObject).count
                cell.detailTextLabel?.text = "Array with \(arrayCount) elements"
             //   print("this should be string of array value : \(dictionaryKeyValue)")
            }else if dictionaryKeyValue is Dictionary<String, Any> {
                let dictionaryCount: Int = dictionary.count
                cell.detailTextLabel?.text = "Dictionary with \(dictionaryCount) elements"
                print("this should be dictionary key value pairs value : \(dictionaryKeyValue)")
            }else{
                cell.detailTextLabel?.text = "\(dictionaryKeyValue as? NSNull)"
            //    print("this should be Null value : \(dictionaryKeyValue)")
            }
        }else if arrayFlag {
            cell.textLabel?.text = "INDEX [\(indexPath.row + 1)]"
         //   print(nextArray)
        }
        
        
        
        
        
    
      // print(dictionaryKeys[indexPath.row])
    
      //  print(indexPath)
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dictionaryFlag{
        let selectedKeyValue = dictionaryKeys[indexPath.row]
        let nextLoad = dictionary[selectedKeyValue]
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextViewController = storyboard.instantiateViewController(withIdentifier: "InstanceViewController") as! ViewController
            if nextLoad is String {
                nextViewController.url = nextLoad as! String
                // print("this should be url value\(nextViewController.url)")
            }else if nextLoad is Array<Any> {
                
                nextViewController.nextArray = nextLoad as! [Any]
                nextViewController.urlFlag = false
                nextViewController.dictionaryFlag = false
                nextViewController.arrayFlag = true
           //     print("this should be array value \(nextViewController.nextArray)")
            }else if nextLoad is Dictionary<String, Any> {
                nextViewController.dictionary = nextLoad as! Dictionary<String, Any>
                print("this should be the dictionary \(nextViewController.dictionary)")
                nextViewController.arrayFlag = false
                nextViewController.dictionaryFlag = true
                nextViewController.urlFlag = false
                // print("this should be url value\(nextViewController.url)")
            }
            
            navigationController?.pushViewController(nextViewController, animated: true)
            
        } else if arrayFlag{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let arrayViewController = storyboard.instantiateViewController(withIdentifier: "InstanceViewController") as! ViewController
            
            let selectedValue = nextArray[indexPath.row]
            if selectedValue is String {
                if (selectedValue as AnyObject).contains("http"){
                    arrayViewController.url = selectedValue as! String
                   // arrayViewController.arrayFlag =
                }
            }
            if selectedValue is Dictionary<String, Any> {
               arrayViewController.dictionary = selectedValue as! Dictionary<String, Any>
                arrayViewController.dictionaryFlag = true
                arrayViewController.arrayFlag = false
                arrayViewController.urlFlag = false
                //print("this should be url value\(nextViewController.url)")
            }
            
            
            navigationController?.pushViewController(arrayViewController, animated: true)
        }
        //To go back to previous screen in the navigation stack
        //navigationController?.popViewController(animated: true)
    }
}

