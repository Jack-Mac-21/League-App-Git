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
    
    init(givenName: String){
        self.Name = givenName;
        self.Scores = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.ParNums = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    }
    
}
