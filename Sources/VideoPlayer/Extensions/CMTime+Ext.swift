//
//  CMTime_Ext.swift
//  AVPlayerDemo
//
//  Created by Md. Ashikur Rahman on 21/6/23.
//  Copyright © 2023 BJIT Ltd. All rights reserved.
//

import UIKit
import AVKit

extension CMTime {
    var durationText: String {
        let totalSeconds = CMTimeGetSeconds(self)
        let hours: Int = Int(totalSeconds.truncatingRemainder(dividingBy: 86400) / 3600)
        let minutes: Int = Int(totalSeconds.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds: Int = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        }
        else {
            return String(format: "%02i:%02i", minutes, seconds)
        }

    }
}
