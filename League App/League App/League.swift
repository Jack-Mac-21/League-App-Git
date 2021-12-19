//
//  League.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import Foundation

class League{
    var Players = [String: Player]();
    
    func addPlayer(player: Player){
        self.Players[player.Name] = player;
    }
}
