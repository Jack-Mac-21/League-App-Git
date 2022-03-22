//
//  Player.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import Foundation
import UIKit

class Player: Codable{
    var Name: String;
    var Scores: [Int];
    var ParNums: [Int];
    var OverParScore: Int?
    var GrossScore: Int?
    
    init(givenName: String){
        self.Name = givenName;
        self.Scores = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.ParNums = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    }
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case scores = "scores"
        case parNums = "ParNums"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(Name, forKey: CodingKeys.name)
        try container.encode(Scores, forKey: CodingKeys.scores)
        try container.encode(ParNums, forKey: CodingKeys.parNums)
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        Name = try values.decode(String.self, forKey: .name)
        Scores = try values.decode([Int].self, forKey: .scores)
        ParNums = try values.decode([Int].self, forKey: .parNums)
        calcScores()
    }
    
    //Calculates over par score and gross score from the current scores and
    //pars arrays
    func calcScores(){
        var ScoreTotal = 0
        var ParTotal = 0
        for num in self.Scores{
            ScoreTotal += num
        }
        var i = 0 as Int;
        for num in self.ParNums{
            if self.Scores[i] > 0 {
                ParTotal += num;
                print(self.Scores[i])
            }
            i += 1;
        }
        self.GrossScore = ScoreTotal
        self.OverParScore = ScoreTotal - ParTotal
        
    }
    
    
}
