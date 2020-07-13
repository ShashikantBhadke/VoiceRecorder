//
//  RecordingListVC.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import AVFoundation

final class RecordingListVC: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK:- Variables
    var selectedIndex: IndexPath?
    var player: AVAudioPlayer?
    var arrFiles = [(fileName: String, path: URL)]()
    
    // MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if player != nil {
            player?.stop()
        }
        player = nil
        selectedIndex = nil
    }
    
    // MARK:- SetUpView
    private func setUpView() {
        tableView.delegate = self
        tableView.dataSource = self
        arrFiles = getAllAudioFiles()
        tableView.reloadData()
    }
    
    // MARK:- Button Actions
    
    // MARK:- Custom Methods
    func playURL(url: URL) {
        
        if player != nil {
            player?.stop()
            player = nil
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            let audioData = try Data.init(contentsOf: url)
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(data: audioData)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            player.prepareToPlay()
            player.delegate = self
            player.play()
            
        } catch {
            selectedIndex = nil
            debugPrint(error.localizedDescription)
        }
    }
    
    func playerDidFinishPlaying() {
        if player != nil {
            player?.stop()
            player = nil
        }
        selectedIndex = nil
        tableView.reloadData()
    }
    
    func getDuration(url: URL)->CGFloat? {
        do {
            let audioData = try Data.init(contentsOf: url)
            let audioPlayer = try AVAudioPlayer(data: audioData)
            return CGFloat(audioPlayer.duration)
        } catch {
            debugPrint("Failed crating audio player: \(error).")
            return nil
        }
    }
    func shareFile(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // MARK:- ReceiveMemoryWarning
    override func didReceiveMemoryWarning() {
        debugPrint("⚠️🤦‍♂️⚠️ Receive Memory Warning on \(self) ⚠️🤦‍♂️⚠️")
    }
    
    // MARK:-
    deinit {
        debugPrint("🏹 Controller is removed from memory \(self) 🎯 🏆")
    }
    
} //class
