//
//  ViewController.swift
//  AnimationProject
//
//  Created by MCS on 10/1/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var poke: [Pokemon] = []
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        
        getPokemon()
        getPokemon()
        getPokemon()
        getPokemon()
        getPokemon()
        getPokemon()
        
        dispatchGroup.notify(queue: .main) {
            self.tableView.reloadData()
        }
        print(self.poke)
    }

    func getPokemon() {
        dispatchGroup.enter()
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(Int.random(in: 1...807))") else {print("Not passing the url"); return}
        print(url)
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            do {
                let data = data; let json = try JSONDecoder().decode(Pokemon.self, from: data!)
                self.poke.append(json)
                
                self.dispatchGroup.leave()
                print(self.poke)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poke.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = poke[indexPath.row].name
        cell.detailTextLabel?.text = "Index: \(poke[indexPath.row].index)"
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = poke[indexPath.row].species.url
        let pokemon = poke[indexPath.row]
        let imageUrl = poke[indexPath.row].sprites.front_default
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        detailViewController.poke = pokemon
        detailViewController.url = url
        detailViewController.imageString = imageUrl
        detailViewController.transitioningDelegate = self
        present(detailViewController, animated: true, completion: nil)//navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DetailViewTransition() as UIViewControllerAnimatedTransitioning
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DetailViewTransition()
    }
}
