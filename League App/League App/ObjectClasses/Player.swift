//
//  Player.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import Foundation
import UIKit

class Player{
    var Name: String;
    var Age: Int?;
    var SkillLevel: Double?;
    var Matches = [String: [[Int]]]();
    var Scores: [Int];
    var ParNums: [Int];
    var OverParScore: Int?
    var GrossScore: Int?
    
    init(givenName: String){
        self.Name = givenName;
        self.Scores = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.ParNums = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    }
    
    //Calculates over par score and gross score from the current scores and
    //pars arrays
    func calcScores(){
        var ScoreTotal = 0
        var ParTotal = 0
        for num in self.Scores{
            ScoreTotal += num
        }
        for num in self.ParNums{
            ParTotal += num
        }
        
        self.GrossScore = ScoreTotal
        self.OverParScore = ScoreTotal - ParTotal
        
    }
    
    
}
