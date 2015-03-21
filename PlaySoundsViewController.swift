//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Chuck McMullen on 3/18/15.
//  Copyright (c) 2015 Chuck McMullen. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func playSlowAudio(sender: UIButton) {
        self.playAudio(0.5)
    }
    @IBAction func playFastAudio(sender: UIButton) {
        self.playAudio(1.5)
    }
    @IBAction func stopAudio(sender: UIButton) {
        stopAudio()
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
       playAudioWithVariablePitch(1000)
    }
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    func playAudio(value: Float){
        stopAudio()
        
        audioPlayer.rate = value
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    func playAudioWithVariablePitch(pitch: Float){
        stopAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    func stopAudio(){
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
}
