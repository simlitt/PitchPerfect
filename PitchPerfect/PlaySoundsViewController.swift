//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Parabsimran Litt on 12/2/15.
//  Copyright © 2015 Parabsimran Litt. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    //Mark: Globally Declared Variables
    
    var audioPlayer:AVAudioPlayer!
    var recievedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: recievedAudio.filePathUrl)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: recievedAudio.filePathUrl)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    //Mark: Buttons
    @IBAction func slowDownButtonPressed(sender: UIButton) {
        stopAllAudio()
        playAudioWithRate(0.5)
    }
    
    @IBAction func speedUpButtonPressed(sender: UIButton) {
        stopAllAudio()
        playAudioWithRate(2.0)
    }
    
    @IBAction func chipmunkButtonPressed(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func darthvaderButtonPressed(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton) {
        stopAllAudio()
    }
    
    func stopAllAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playAudioWithRate(rate: Float) {
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopAllAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        audioPlayerNode.play()
    }
    
}
