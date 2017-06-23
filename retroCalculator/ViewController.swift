//
//  ViewController.swift
//  retroCalculator
//
//  Created by Christian Buendia on 18/06/17.
//  Copyright © 2017 Christian Buendia Osorio. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    var currentOperation = Operation.Empty
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    
    }

    @IBOutlet weak var outputLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
    }
    
    @IBAction func numberPressed(sender: UIButton){
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: Any){
        processOperation(operation: Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: Any){
        processOperation(operation: Operation.Multiply)
    }
    @IBAction func onSubstractPressed(sender: Any){
        processOperation(operation: Operation.Substract)
    }
    @IBAction func onAddPressed(sender: Any){
        processOperation(operation: Operation.Add)
    }
    @IBAction func onEqualPressed(sender: Any){
        processOperation(operation: currentOperation)
    }
    @IBAction func onClearPressed(sender: Any){
        processOperation(operation: Operation.Empty)
        outputLbl.text = "0"
    }
    
    

    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty{
            if runningNumber != ""{
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Substract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        
        }
    }
}

