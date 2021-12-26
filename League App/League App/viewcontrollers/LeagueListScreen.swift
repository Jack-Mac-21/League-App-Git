//
//  ViewController.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import UIKit

class LeagueListScreen: UIViewController {
    @IBOutlet weak var AddLeagueButton: UIButton!
    @IBOutlet weak var LeagueNameInput: UITextField!
    @IBOutlet weak var LeagueTableView: UITableView!
    
    var leagues: [League] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        LeagueTableView.delegate = self
        LeagueTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    @IBAction func AddLeague(_ sender: Any) {
        let tempLeague = League(givenTitle: LeagueNameInput.text ?? "error")
        leagues.append(tempLeague)
        
        LeagueTableView.beginUpdates()
        LeagueTableView.insertRows(at: [IndexPath(row: self.leagues.count - 1, section: 0)], with: .automatic) /// animate the insertion
        LeagueTableView.endUpdates()
        
        LeagueNameInput.text = ""
        
        
    }
}

extension LeagueListScreen: UITableViewDataSource, UITableViewDelegate{ //Deciding the amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempLeague = self.leagues[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeagueCell
        
        cell.SetLeague(league: tempLeague) //Specifiying the parameters in the cell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
