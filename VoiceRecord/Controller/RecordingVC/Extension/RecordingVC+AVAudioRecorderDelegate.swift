//
//  RecordingVC+AVAudioRecorderDelegate.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import AVFoundation

// MARK:- Extension For :-
extension RecordingVC: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            
            btnRecord.setImage(UIImage(named: "v_Play"), for: .normal)
            btnStop.isHidden = true
            stopTimer()
            finishRecording(success: false)
            
        }
    }
    
} //extension
