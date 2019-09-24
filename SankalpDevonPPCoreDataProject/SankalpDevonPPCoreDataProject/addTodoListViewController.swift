//
//  addTodoListViewController.swift
//  SankalpDevonPPCoreDataProject
//
//  Created by MAC on 9/23/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//
import UIKit

protocol ViewDelegate {
    func updateValues(with newValues: String?)
}

class addTodoListViewController: UIViewController  {

  var firstScreen: ViewDelegate?
  
  @IBOutlet weak var inputItem: UITextField!
    
    
  @IBAction func addItem(_ sender: UIButton) {
    firstScreen?.updateValues(with: inputItem.text)
    navigationController?.popViewController(animated: true)
  }
  
}
