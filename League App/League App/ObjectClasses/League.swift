//
//  League.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import Foundation

class League: Codable{
    var PlayersDict = [String: Player]();
    var PlayerList: [Player] = []
    var Title = "New League"; //title for a league
    
    init(givenTitle: String){
        self.Title = givenTitle
    }

    
    enum CodingKeys: String, CodingKey{
        case title = "title"
        case playerList = "player_list"
        case playersDictionary = "player_dict"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy:CodingKeys.self)
        try container.encode(Title, forKey: .title)
        try container.encode(PlayerList, forKey: .playerList)
        try container.encode(PlayersDict, forKey: .playersDictionary)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        PlayersDict = try values.decode([String: Player].self, forKey: .playersDictionary)
        PlayerList = try values.decode([Player].self, forKey: .playerList)
        Title = try values.decode(String.self, forKey: .title)
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
