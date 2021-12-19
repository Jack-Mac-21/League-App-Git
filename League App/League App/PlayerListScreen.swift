//
//  PlayerListScreen.swift
//  League App
//
//  Created by JackMac on 12/19/21.
//

import UIKit

class PlayerListScreen: UIViewController {
    
    var Players: [Player] = []
    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Players = createArray()
        
        TableView.delegate = self
        TableView.dataSource = self

    }
    
    func createArray() -> [Player]{
        var tempPlayers: [Player] = [];
        
        let player1 = Player(givenName: "Maddie", givenAge: 27, givenSkill: 3.0)
        let player2 = Player(givenName: "Jack", givenAge: 21, givenSkill: 4.5)
        let player3 = Player(givenName: "John", givenAge: 70, givenSkill: 3.5)
        let player4 = Player(givenName: "Joanne", givenAge: 55, givenSkill: 3.5)
        
        tempPlayers = [player1, player2, player3, player4]
        
        return tempPlayers
    }
}

extension PlayerListScreen: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = Players[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
        
        cell.setPlayer(player: player)
        
        return cell
    }
}
