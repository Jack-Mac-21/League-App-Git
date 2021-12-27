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
    var Age: Int;
    var SkillLevel: Double;
    var Matches = [String: [[Int]]]();
    var Scores: [Int];
    var ParNums: [Int];
    
    init(givenName: String, givenAge: Int, givenSkill: Double){
        self.Name = givenName;
        self.Age = givenAge;
        self.SkillLevel = givenSkill;
        self.Scores = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.ParNums = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    }
    
}
