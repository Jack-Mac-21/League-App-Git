//
//  League.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import Foundation

class League{
    var PlayersDict = [String: Player]();
    var PlayerList: [Player] = []
    var Title = "New League"; //title for a league
    
    init(givenTitle: String){
        self.Title = givenTitle
    }
    
    func addPlayer(player: Player){
        self.PlayersDict[player.Name] = player;
    }
    
    func setPlayer(players: [Player]){
        var tempPlayers = [String: Player]()
        for player in players {
            tempPlayers[player.Name] = player
        }
        self.PlayersDict = tempPlayers
    }
}