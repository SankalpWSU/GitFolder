//
//  DetailViewController.swift
//  BookSearch
//
//  Created by MCS on 12/26/19.
//  Copyright © 2019 PaulRenfrew. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var resultDetail: SearchResult!
    @IBOutlet var detailInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailInfo.text = "Title = \(resultDetail.title). \n\n Publish Year = \(resultDetail.publishYear)"
    }
}
