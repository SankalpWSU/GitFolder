//
//  DetailViewController.swift
//  ClueGameProject
//
//  Created by MCS on 9/24/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var isTapped: Bool = true
    
    @IBOutlet var detailInformationLabel: UILabel!
    var newDictionary: Highlight!
    
    @IBOutlet var highlightButton: UIButton!
    
    @IBAction func highlightButtonTapped(_ sender: UIButton) {
        if !isTapped {
            print("if \(isTapped)")
            
            highlightButton.setTitle("Fav", for: .normal)
            view.backgroundColor = .yellow
            isTapped = true
            
        } else {
            print("else \(isTapped)")
            highlightButton.setTitle("Tap to highlight", for: .normal)
            view.backgroundColor = .white
            isTapped = false
            
        }
        print("outside \(isTapped)")
//print(CoreDataManager.shared.createHighlight(with: isTapped))
        newDictionary.star = isTapped
      //  print(CoreDataManager.shared.context.hasChanges)
        CoreDataManager.shared.saveHighlight()
       // print(CoreDataManager.shared.saveHighlight())
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        highlightButton.setTitle("Tap to highlight", for: .normal)
        isTapped = newDictionary.star
        print("Initial \(isTapped)")
        if isTapped {
            highlightButton.setTitle("Fav", for: .normal)
            view.backgroundColor = .yellow
        } else {
            highlightButton.setTitle("Tap to highlight", for: .normal)
            view.backgroundColor = .white
        }
        detailInformationLabel.text = "Question: \(newDictionary.question)\n\n Answer: \(newDictionary.answer)\n\n Clue Value: \(newDictionary.clueValue )\n\n Air Date: \(newDictionary.airdate)\n\n Creation Date: \(newDictionary.createDate)\n\n Category Name: \(newDictionary.title)"
    }
    
}
