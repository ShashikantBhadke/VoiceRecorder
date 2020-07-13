//
//  RecordingCell.swift
//  VoiceRecord
//
//  Created by Shashikant's_Macmini on 07/03/20.
//  Copyright © 2020 redbytes. All rights reserved.
//

import UIKit

final class RecordingCell: UITableViewCell {

    // MARK:- Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDuration: UILabel!
    
    // MARK:- Variables
    var path: URL?
    var onBtnPressed: ((URL?)->Void)?
    
    // MARK:- Default Methods
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- Default Methods
        
    // MARK:- Button Actions
    @IBAction private func btnSharePressed(_ sender: UIButton) {
        onBtnPressed?(path)
    }
    
} //class
