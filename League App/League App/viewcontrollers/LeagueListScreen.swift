//
//  ViewController.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import UIKit

class LeagueListScreen: UIViewController {
    @IBOutlet weak var LeagueTableView: UITableView!
    
    var leagues: [League] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
