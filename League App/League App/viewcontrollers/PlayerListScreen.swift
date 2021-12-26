//
//  PlayerListScreen.swift
//  League App
//
//  Created by JackMac on 12/19/21.
// The view controller for the TableView odf players

import UIKit

class PlayerListScreen: UIViewController {
    
    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var SkillInput: UITextField!
    @IBOutlet weak var AgeInput: UITextField!
    @IBOutlet weak var TableView: UITableView!
    
    var _Players: [Player] = []
    var _League = League(givenTitle: "Temp_League")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self

    }
    
    @IBAction func AddPlayer(_ sender: Any) {
        let player = Player(givenName: NameInput.text ?? "no_name", givenAge: Int(AgeInput.text ?? "0") ?? 0, givenSkill: Double(SkillInput.text ?? "0.0") ?? 0.0) //Takes input fields to create a new player and adds to the array
        self._Players.append(player)
        
        TableView.beginUpdates()
        TableView.insertRows(at: [IndexPath(row: self._Players.count - 1, section: 0)], with: .automatic) /// animate the insertion
        TableView.endUpdates()
    }
}

extension PlayerListScreen: UITableViewDataSource, UITableViewDelegate{ //Deciding the amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._Players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = self._Players[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
        
        cell.setPlayer(player: player) //Specifiying the parameters in the cell
        
        return cell
    }
}
