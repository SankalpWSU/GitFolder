//
//  ViewController.swift
//  SankalpDevonPPCoreDataProject
//
//  Created by MAC on 9/23/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ViewDelegate {

  var toDoList : [String] = []
  
  @IBOutlet weak var toDoListTableView: UITableView!
  
  @IBAction func goToAddItemPage(_ sender: Any) {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    let detailViewController = storyBoard.instantiateViewController(withIdentifier: "addToDoList") as! addTodoListViewController
   detailViewController.firstScreen = self
    navigationController?.pushViewController(detailViewController, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print(CoreDataManager().persistentContainer)
    // Do any additional setup after loading the view.
    toDoListTableView.dataSource = self
    toDoListTableView.delegate = self
  }

    func updateValues(with newValues: String?){
    if let editText = newValues {
        toDoList.append(editText)
        print(toDoList)
        toDoListTableView.reloadData()
    }
  }
    func delValues(at index: Int){
        toDoList.remove(at: index)
        toDoListTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return toDoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell.init(style: .default, reuseIdentifier: "addToList")
    cell.textLabel?.text = toDoList[indexPath.row]
    return cell
  }
}

extension ViewController: UITableViewDelegate{
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    delValues(at: indexPath.row)
  }
  
}

