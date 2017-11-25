//
//  ResultViewController.swift
//  Homework2 Delegate
//
//  Created by Channat Tem on 11/22/17.
//  Copyright © 2017 Channat Tem. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
   
    var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
       nameLabel.text = username!
        
    }


}
