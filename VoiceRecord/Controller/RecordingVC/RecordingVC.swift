//
//  RecordingVC.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import AVFoundation

final class RecordingVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet internal weak var btnRecord   : UIButton!
    @IBOutlet internal weak var btnStop     : UIButton!
    @IBOutlet private weak var lblTimer     : UILabel!
    
    // MARK:- Variables
    var seconds = 0
    var timer: Timer?
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        self.btnRecord.isHidden = true
        self.btnStop.isHidden = true
        
        setUpRecording()
    }
    
    private func setUpRecording() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.btnRecord.isHidden = false
                    } else {
                        self.btnRecord.isHidden = true
                        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }
            }
        } catch {
            self.btnRecord.isHidden = true
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    // MARK:- Custom Actions
    @objc private func updateTimer() {
        seconds += 1
        lblTimer.text = self.timeString(time: TimeInterval(seconds))
    }
    
    
    // MARK:- Button Actions
    @IBAction private func btnRecordPressed(_ sender: UIButton) {
        if audioRecorder == nil {
            startRecording()
        } else {
            if !audioRecorder.isRecording {
                startTimer()
                audioRecorder.prepareToRecord()
                audioRecorder.record()
                btnRecord.setImage(UIImage(named: "v_Pause"), for: .normal)
            } else {
                stopTimer()
                audioRecorder.pause()
                btnRecord.setImage(UIImage(named: "v_Play"), for: .normal)
            }
        }
    }
    
    @IBAction private func btnPausePressed(_ sender: UIButton) {
        finishRecording(success: true)
    }
    
    // MARK:- Recording Methods
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(Date.currentTime).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = nil
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            btnRecord.setImage(UIImage(named: "v_Pause"), for: .normal)
            btnStop.isHidden = false
            startTimer()
        } catch {
            debugPrint(error.localizedDescription)
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        if audioRecorder != nil {
            audioRecorder.stop()
        }
        audioRecorder = nil
        stopTimer()
        seconds = 0
        btnRecord.setImage(UIImage(named: "v_Play"), for: .normal)
        if success {
            btnStop.isHidden = true
        }
        lblTimer.text = "Tap againg to start new recording.."
        pushListingVC()
    }
    
    // MARK:- Timer Methods
    private func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if timer != nil {
            timer?.invalidate()
        }
    }
    
    // MARK:- Push Controller
    func pushListingVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: String(describing: RecordingListVC.self)) as? RecordingListVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK:- Receive Memory Warning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
