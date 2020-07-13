//
//  Ext+ViewController.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit
import MobileCoreServices

// MARK:- Extension For :-
extension UIViewController {
    
    func timeString(time: TimeInterval) -> String {
        let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
    
    func getDocumentsDirectory() -> URL {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first!
        let pathURL = URL.init(string: path)!
        let dataURL = pathURL.appendingPathComponent("VoiceRecordings", isDirectory: true)
        do {
            try FileManager.default.createDirectory(atPath: dataURL.absoluteString, withIntermediateDirectories: true, attributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription);
        }
        return dataURL
    }
    
    func getAllAudioFiles()->[(fileName: String, path: URL)] {
        var arrData = [(fileName: String, path: URL)]()
        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil)
            
            for path in directoryContents{
                
                let ext = path.pathExtension
                let uti = UTTypeCreatePreferredIdentifierForTag( kUTTagClassFilenameExtension, ext as CFString, nil)
                if UTTypeConformsTo((uti?.takeRetainedValue())!, kUTTypeAudio) {
                    arrData.append((fileName: path.lastPathComponent, path: path))
                }                
            }
            return arrData
        } catch {
            print(error)
            return []
        }
    }
} //extension
