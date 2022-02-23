//
//  ViewController.swift
//  Bullseye
//
//  Created by aaryan punia on 2/22/22.
//

import UIKit
import Foundation

var randomNumber = 0
var range = 100
var level = 1
var highScore = 0

class ViewController: UIViewController {
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var highScr: UILabel!
    
    @IBOutlet weak var numLabel: UILabel!
    
    @IBOutlet weak var numSlider: UISlider!
    
    @IBOutlet weak var exactSwitch: UISwitch!
    
    @IBOutlet weak var RangeLabel: UILabel!
    
    @IBOutlet weak var currLevel: UILabel!
    
    @IBOutlet weak var playAgain: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        randomNumber = Int(arc4random_uniform(101))
        print(randomNumber)
        numLabel.text = String(randomNumber)
        playAgain.isHidden = true
        RangeLabel.text = String(range)
        currLevel.text = String(level)
        highScr.text = String(highScore)
        
    }

    @IBAction func sliderValueChanged(_ sender: Any) {
    }
    
    @IBAction func playAgainF(_ sender: Any) {
        if highScore < level && level != 1{
            highScore = level
            highScr.text = String(highScore)
        }
        numSlider.setValue(50.0, animated: false)
        randomNumber = Int(arc4random_uniform(101))
        numLabel.text = String(randomNumber)
        resultLabel.isHidden = true
        playAgain.isHidden = true
        range = 100
        RangeLabel.text = String(range)
        numSlider.maximumValue = Float(range)
        level = 1
        currLevel.text = String(level)
        
    }
    @IBAction func checkValue(_ sender: Any) {
            if exactSwitch.isOn == false {
                if randomNumber - 3 <= Int(numSlider.value) && randomNumber + 3 >= Int(numSlider.value) {
                    resultLabel.text = "Bullseye!"
                    range += 25
                    RangeLabel.text = String(range)
                    numSlider.maximumValue = Float(range)
                    level += 1
                    currLevel.text = String(level)
                    numSlider.setValue(Float(range / 2), animated: false)
                    numLabel.text = String(range / 2)
                    randomNumber = Int(arc4random_uniform(UInt32(range + 1)))
                    resultLabel.isHidden = true
                } else {
                    resultLabel.text = "Missed :("
                    playAgain.isHidden = false
                }
            } else {
                if randomNumber == Int(numSlider.value) {
                    resultLabel.text = "Bullseye!"
                    range += 25
                    numSlider.maximumValue = Float(range)
                    level += 1
                    currLevel.text = String(level)
                    numSlider.setValue(Float(range / 2), animated: false)
                    numLabel.text = String(range / 2)
                    randomNumber = Int(arc4random_uniform(UInt32(range + 1)))
                    resultLabel.isHidden = true
                } else {
                    resultLabel.text = "Missed :("
                    playAgain.isHidden = false
            }
        }
        resultLabel.isHidden = false
    }
}
