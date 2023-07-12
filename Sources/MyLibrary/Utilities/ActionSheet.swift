//
//  ActionSheet.swift
//  AVPlayerDemo
//
//  Created by Mac on 15/6/23.
//

import UIKit
import AVKit

class ActionSheet {
    
    static let shared = ActionSheet()
    
    /// This function sets rate of AVPlayer through action sheet
    /// - Parameters:
    ///   - avPlayer: change the rate of this player
    /// - Returns: returns UIAlertController to show sheet in viewController where the functions called
    func speedActionSheet(avPlayer: AVPlayer) -> UIAlertController {
        
        let title = NSLocalizedString("Speed", comment: "")
        let selectAny = NSLocalizedString("Select any", comment: "")
        let normal = NSLocalizedString("Normal", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
         
        let speedAlert = UIAlertController(title: title, message: selectAny, preferredStyle: .actionSheet)
        
        speedAlert.addAction(UIAlertAction(title: "6x", style: .default , handler:{ (UIAlertAction)in
            MyLibrary.shared.setSpeedToAVPlayer(rate: 6.0, avPlayer: avPlayer)
        }))
        
        speedAlert.addAction(UIAlertAction(title: "4x", style: .default , handler:{ (UIAlertAction)in
            MyLibrary.shared.setSpeedToAVPlayer(rate: 4.0, avPlayer: avPlayer)
        }))

        speedAlert.addAction(UIAlertAction(title: "2x", style: .default , handler:{ (UIAlertAction)in
            MyLibrary.shared.setSpeedToAVPlayer(rate: 2.0, avPlayer: avPlayer)
        }))
        
        speedAlert.addAction(UIAlertAction(title: normal, style: .default, handler:{ (UIAlertAction)in
            MyLibrary.shared.setSpeedToAVPlayer(rate: 1.0, avPlayer: avPlayer)
        }))
        
        speedAlert.addAction(UIAlertAction(title: "0.1x", style: .default, handler:{ (UIAlertAction)in
            MyLibrary.shared.setSpeedToAVPlayer(rate: 0.1, avPlayer: avPlayer)
        }))
        speedAlert.addAction(UIAlertAction(title: cancel, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        //uncomment for iPad Support
        //speedAlert.popoverPresentationController?.sourceView = self.view
        
        return speedAlert
    }
    
    
    /// This function sets quality of AVPlayer through action sheet
    /// - Parameters:
    ///   - avPlayer: change the quality of this player
    /// - Returns: returns UIAlertController to show sheet in viewController where the functions called
    func qualityActionSheet(avPlayer: AVPlayer) -> UIAlertController {
        
        let quality = NSLocalizedString("Quality", comment: "")
        let selectAny = NSLocalizedString("Select any", comment: "")
        let cancel = NSLocalizedString("Cancel", comment: "")
        let auto = NSLocalizedString("Auto", comment: "")
        
        let qualityAlert = UIAlertController(title: quality, message: selectAny, preferredStyle: .actionSheet)
        
        qualityAlert.addAction(UIAlertAction(title: "1080p", style: .default , handler:{ (UIAlertAction)in
            
        }))
        
        qualityAlert.addAction(UIAlertAction(title: "720p", style: .default , handler:{ (UIAlertAction)in
            
        }))

        qualityAlert.addAction(UIAlertAction(title: "480p", style: .default , handler:{ (UIAlertAction)in
            
        }))
        
        qualityAlert.addAction(UIAlertAction(title: "360p", style: .default, handler:{ (UIAlertAction)in
            
        }))
        
        qualityAlert.addAction(UIAlertAction(title: "240p", style: .default, handler:{ (UIAlertAction)in
            
        }))
        qualityAlert.addAction(UIAlertAction(title: "144p", style: .default, handler:{ (UIAlertAction)in
            
        }))
        qualityAlert.addAction(UIAlertAction(title: auto, style: .default, handler:{ (UIAlertAction)in
            
        }))
        qualityAlert.addAction(UIAlertAction(title: cancel, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        //uncomment for iPad Support
        //qualityAlert.popoverPresentationController?.sourceView = self.view
        
        return qualityAlert
    }
    
}
