//
//  RecordingListVC+TableView.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

// MARK:- Extension For :- UITableViewDelegate
extension RecordingListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        self.playURL(url: arrFiles[indexPath.row].path)
        tableView.reloadData()
    }
} //extension

// MARK:- Extension For :- UITableViewDataSource
extension RecordingListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecordingCell.self), for: indexPath) as? RecordingCell else { return RecordingCell() }
        cell.backgroundColor = (indexPath == selectedIndex) ? .lightGray : .white
        cell.lblTitle.text = arrFiles[indexPath.row].fileName
        cell.lblDuration.text = String(format: "%.2f", (getDuration(url: arrFiles[indexPath.row].path) ?? 0.0)) + " sec"
        cell.path = arrFiles[indexPath.row].path
        cell.onBtnPressed = { [weak self] path in
            guard let self = self, let path = path else { return }
            self.shareFile(url: path)
        }
        return cell
    }
} //extension
