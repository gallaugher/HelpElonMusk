//
//  ViewController.swift
//  HelpElonMusk
//
//  Created by John Gallaugher on 4/3/17.
//  Copyright © 2017 Gallaugher. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var rocketImage: UIImageView!
    var imageNumber = 0
    let numOfImages = 5
    var yAtLanding: CGFloat?
    var offScreen = false
    var audioPlayer = AVAudioPlayer()
    @IBOutlet weak var rocketButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        yAtLanding = self.rocketImage.frame.origin.y
    }

    func playSound(soundName: String, audioPlayer: inout AVAudioPlayer) {
        if let sound = NSDataAsset(name: soundName) {
            do {
                try audioPlayer = AVAudioPlayer(data: sound.data)
                audioPlayer.play()
            } catch {
                print("ERROR: Data from \(soundName) could not be played as an audio file")
            }
        } else {
            print("ERROR: Could not load datea from file \(soundName)")
        }
    }
    
    @IBAction func rocketTapped(_ sender: UITapGestureRecognizer) {
        imageNumber += 1
        if imageNumber == numOfImages {
            imageNumber = 0
        }
        rocketImage.image = UIImage(named: "rocket\(imageNumber)")
    }
    
    @IBAction func rocketButtonPressed(_ sender: UIButton) {
        if offScreen == false {
            playSound(soundName: "rocketsound", audioPlayer: &audioPlayer)
            UIView.animate(withDuration: 2, animations: {self.rocketImage.frame.origin.y = -(self.rocketImage.frame.size.height)}, completion: {_ in self.audioPlayer.stop()})
            offScreen = true
            rocketButton.setTitle("Return", for: .normal)
        } else {
            playSound(soundName: "rocketsound", audioPlayer: &audioPlayer)
            UIView.animate(withDuration: 2, animations: {self.rocketImage.frame.origin.y = self.yAtLanding!}, completion: {_ in self.audioPlayer.stop()})
            offScreen = false
            rocketButton.setTitle("Blast Off!", for: .normal)
        }
    }
}

