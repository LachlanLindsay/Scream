//
//  ViewController.swift
//  Scream
//
//  Created by Lachlan Lindsay on 10/1/19.
//  https://xkcd.com/1363/
//  Copyright © 2019 Lachlan Lindsay. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    var player: AVAudioPlayer?
    var notificationCenter = NotificationCenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        guard let url = Bundle.main.url(forResource: "glassbreaking", withExtension: "wav") else { return }
        player = try? AVAudioPlayer(contentsOf: url)
        player?.setVolume(100, fadeDuration: 1)
        player?.prepareToPlay()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        motionManager.accelerometerUpdateInterval = 0.01
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { (data, error) in
            if let myData = data{
                let total = abs(myData.acceleration.x) + abs(myData.acceleration.y) + abs(myData.acceleration.z)
                if (total < 0.2) {
                    print("I'm falling")
                    self.playSound()
                } else {
                    print("I'm ok" )
                }
            }
        }
    }
    
    @objc func appMovedToBackground() {
        print("app closing")
    }
    
    func playSound(){
        player?.play()
    }
    func stopSound(){
        
    }
}

