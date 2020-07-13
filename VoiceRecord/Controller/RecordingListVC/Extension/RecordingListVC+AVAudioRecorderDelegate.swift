//
//  RecordingListVC+AVAudioRecorderDelegate.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import AVFoundation

// MARK:- Extension For :- AVAudioPlayerDelegate
extension RecordingListVC: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            playerDidFinishPlaying()
        }
    }
} //extension
