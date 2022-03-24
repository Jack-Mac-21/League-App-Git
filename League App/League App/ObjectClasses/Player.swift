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
    //Totals
    var OverParScore: Int!
    var GrossScore: Int!
    //Back 9 scores
    var Back9Gross: Int!
    var Back9OverPar: Int!
    //Front 9 scores
    var Front9Gross: Int!
    var Front9OverPar: Int!
    
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
        var Front9ScoreTotal = 0
        var Back9ScoreTotal = 0
        
        var i = 0 as Int;
        for num in self.Scores{
            ScoreTotal += num
            if i < 9{
                Front9ScoreTotal += num
            }
            else{
                Back9ScoreTotal += num
            }
            i += 1
        }
        var k = 0
        i = 0
        
        var Front9ParTotal = 0
        var Back9ParTotal = 0
        for num in self.ParNums{
            if self.Scores[k] > 0 {
                ParTotal += num;
                if i < 9 {
                    Front9ParTotal += num
                }else{
                    Back9ParTotal += num
                }
            }
            i += 1;
            k += 1;
        }
        
        self.GrossScore = ScoreTotal
        self.OverParScore = ScoreTotal - ParTotal
        
        self.Front9Gross = Front9ScoreTotal
        self.Front9OverPar = Front9ScoreTotal - Front9ParTotal
        
        self.Back9Gross = Back9ScoreTotal
        self.Back9OverPar = Back9ScoreTotal - Back9ParTotal
        
    }
    
    
}
