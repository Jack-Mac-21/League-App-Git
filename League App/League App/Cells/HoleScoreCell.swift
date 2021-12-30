//
//  HoleScoreCell.swift
//  League App
//
//  Created by JackMac on 12/26/21.
//

import UIKit

class HoleScoreCell: UITableViewCell {

    @IBOutlet weak var HoleNum: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var ParLabel: UILabel!
    
    @IBOutlet weak var ParStepper: UIStepper!
    @IBOutlet weak var ScoreStepper: UIStepper!
    
    var scoreDelegate: DataPlayerScore?
    
    var givenHole = Hole()
    
    //Uses the delegate to update stepper value and player value
    // in the player screen view controller
    @IBAction func stepperParValueChanged(_ sender: UIStepper){
        ParLabel.text = Int(sender.value).description
        scoreDelegate?.UpdatePar(index: givenHole.HoleNumber - 1, value: Int(sender.value))
    }
    
    @IBAction func stepperScoreValueChanged(_ sender: UIStepper) {
        ScoreLabel.text = Int(sender.value).description
        scoreDelegate?.UpdateScore(index: givenHole.HoleNumber - 1, value: Int(sender.value))
    }
    
    func setHole(hole: Hole){
        HoleNum.text = "Hole #" + (hole.HoleNumber.description)
        ScoreLabel.text = hole.Score.description
        ParLabel.text = hole.ParNumber.description
        ParStepper.value = Double(hole.ParNumber)
        ScoreStepper.value = Double(hole.Score)
        givenHole = hole
    }
    

}
