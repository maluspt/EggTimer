//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    let eggTimes = ["Soft": 10,
                    "Medium": 420,
                    "Hard": 720]
       
    var counterTimer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressView.progress = 0.0
    }

    
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let porcentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = porcentageProgress
            
        } else {
            textLabel.text = "Your egg is done!"
            playAlarm()
            counterTimer.invalidate()
            
        }
    }


    @IBAction func hardernessSelected(_ sender: UIButton) {
        counterTimer.invalidate() // Make the other active timers stop when you start a new one
        progressView.progress = 0.0
        secondsPassed = 0
        textLabel.text = "How do you like your eggs?"
        guard let hardness = sender.currentTitle else { return }
        let pressedEgg = (eggTimes[hardness]!)
        totalTime = pressedEgg
        counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
         
        
    }
    
    func playAlarm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
