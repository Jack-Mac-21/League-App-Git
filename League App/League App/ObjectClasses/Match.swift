//
//  File.swift
//  League App
//
//  Created by JackMac on 12/26/21.
//

import Foundation


class Match{
    var Players: [Player]
    var Winner: Player
    var Score: [Int]
    
    init(givenPlayers: [Player], givenWinner: Player, givenScore: [Int]){
        self.Players = givenPlayers
        self.Winner = givenWinner
        self.Score = givenScore
    }
}
