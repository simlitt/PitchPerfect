//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Parabsimran Litt on 11/30/15.
//  Copyright © 2015 Parabsimran Litt. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    //Mark: Global Variables
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    //Mark:Outlets
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var RecordingButton: UIButton!
    
    //Mark Actions
    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.hidden = false
        RecordingButton.hidden = true
        stopRecordingButton.hidden = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
//        let currentDateTime = NSDate()
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "ddMMyyyy-HHmmss"
//        let recordingName = dateFormatter.stringFromDate(currentDateTime)+".wav"
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.hidden = true
        RecordingButton.hidden = false
        stopRecordingButton.hidden = true
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    //Mark: Delegate Functions
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        
        if(flag) {
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
        
        self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("recording was not successful")
            RecordingButton.enabled = true
            stopRecordingButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let data = sender as! RecordedAudio
            playSoundsVC.recievedAudio = data
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        recordingLabel.hidden = true
        stopRecordingButton.hidden = true
    }

    
}

