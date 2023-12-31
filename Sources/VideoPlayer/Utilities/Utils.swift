//
//  Utils.swift
//  AVPlayerDemo
//
//  Created by Md. Ashikur Rahman on 9/6/23.
//  Copyright © 2023 BJIT Ltd. All rights reserved.
//

import UIKit
import AVKit


enum Orientation: String {
    case portrait = "Portrait"
    case upsideDown = "Upside Down"
    case landscapeRight = "Landscape Right"
    case landscapeLeft = "Landscape Left"
    case cameraFacingDown = "Camera Facing Down"
    case cameraFacingUp = "Camera Facing Up"
    case unknown = "Unknown"
}

enum InternetConnection {
    case satisfied
    case notSatisfied
}

class Utils {
    
    static let shared = Utils()
    
    
    func generateImagesFromVideo(avPlayer: AVPlayer, completion: @escaping ([ Double : UIImage ]) -> ()) {
        
        var images: [ Double : UIImage ] = [:]
        guard let asset = avPlayer.currentItem?.asset else {
            return
        }
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.maximumSize = CGSize(width: 150, height: 80)
        let seconds = asset.duration.seconds
        
        imageGenerator.generateCGImagesAsynchronously(forTimes: Array(1...99).map{ NSValue(time:CMTimeMake(value: $0 * Int64(seconds), timescale: 100))  }) { (requestedTime, cgImage, actualTime, result, error) in
            guard let image = cgImage else {
                return
            }
            images[actualTime.seconds] = UIImage(cgImage: image)
            completion(images)
        }
        
    }
    
    
    // MARK: - Checks the orientation of device
    /// This function is to check the orientation of the ios device
    /// - Returns: Return the orientation status of device as String
    func deviceOrientation() -> String! {
        
        let device = UIDevice.current
        if device.isGeneratingDeviceOrientationNotifications {
            device.beginGeneratingDeviceOrientationNotifications()
            var deviceOrientation: String
            let deviceOrientationRaw = device.orientation.rawValue
            switch deviceOrientationRaw {
            case 1:
                deviceOrientation = Orientation.portrait.rawValue
                debugPrint("portrait")
            case 2:
                deviceOrientation = Orientation.upsideDown.rawValue
                debugPrint("upsideDown")
            case 3:
                deviceOrientation = Orientation.landscapeRight.rawValue
                debugPrint("landscapeRight")
            case 4:
                deviceOrientation = Orientation.landscapeLeft.rawValue
                debugPrint("landscapeLeft")
            case 5:
                deviceOrientation = Orientation.cameraFacingDown.rawValue
                debugPrint("cameraFacingDown")
            case 6:
                deviceOrientation = Orientation.cameraFacingUp.rawValue
                debugPrint("cameraFacingUp")
            default:
                deviceOrientation = Orientation.unknown.rawValue
                debugPrint("unknown")
            }
            return deviceOrientation
        } else {
            return nil
        }
        
    }
    
    
    // MARK: - Function to convert degree to radian
    /// This function to convert degree to radian
    /// - Parameter x: Takes degree as CGFloat
    /// - Returns: Returns radian value as CGFloat of given degree
    func degreeToRadian(_ x: CGFloat) -> CGFloat {
        
        return .pi * x / 180.0
        
    }
    
    
    // MARK: - Function to center any button inside any UIView
    /// This function is to set any button in the middle of of any UIView.
    /// - Parameters:
    ///   - view: Takes UIView, where the button will be placed (in the middle)
    ///   - button: Takes button, which will be placed in middle of the given UIView
    func setButtonCenter(view: UIView, button: UIButton) {
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.frame = CGRect(
            x: (view.bounds.width - button.bounds.width) / 2,
            y: (view.bounds.height - button.bounds.height) / 2,
            width: button.bounds.width,
            height: button.bounds.height
        )
        
    }
    
    
    /// This function used to create UIButton
    /// - Parameters:
    ///   - tintColor: color of the button
    ///   - title: title of the button
    ///   - imageName: image of the button (image name should be in String)
    /// - Returns: returns a button
    func createButton(tintColor: UIColor, title: String, imageName: String) -> UIButton {
        
        let button = UIButton()
        button.tintColor = tintColor
        button.setTitle(title, for: .normal)
        let image = UIImage(systemName: imageName)
        button.setImage(image, for: .normal)
        return button
        
    }
    
    
    /// This function creates UIView
    /// - Parameter view: takes the parent view where the newly created UIView will be placed
    /// - Returns: returns the c reated UIView
    func createUIView(view: UIView) -> UIView {
        
        let myNewView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        // Change UIView background colour
        myNewView.backgroundColor = UIColor.lightGray
        
        // Add border to UIView
        myNewView.layer.borderWidth = 1
        
        // Change UIView Border Color to Red
        myNewView.layer.borderColor = UIColor.black.cgColor
        
        // Add UIView as a Subview
        view.addSubview(myNewView)
        
        return myNewView
        
    }
    
    
    // MARK: - Get Current Time Of Video
    /// This function get the current time and return
    /// - Returns: returns the current time of video
    func getCurrentTimeOfVideo(avPlayer: AVPlayer) -> Float64 {
        
        let currentTime = avPlayer.currentItem?.currentTime()
        guard let currentTime = currentTime else {
            return 0.0
        }
        let currentTimeInSeconds : Float64 = CMTimeGetSeconds(currentTime)
        return currentTimeInSeconds
        
    }
    
    /// Convert seconds to HH:MM:SS format
    /// - Parameter seconds: Takes seconds as integer
    /// - Returns: returns the time in HH:MM:SS format
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        let hour = (seconds / 3600)
        let minute = (seconds % 3600) / 60
        let second = (seconds % 3600) % 60
        
        if hour > 0 {
            return String(format: "%i:%02i:%02i", hour, minute, second)
        }
        else {
            return String(format: "%02i:%02i", minute, second)
        }

    }
    
    
    /// This function  is to get the closest integer from an array of integers
    /// - Parameters:
    ///   - v: this is the given integer which will be compared with the array
    ///   - arr: This is the array of integers
    /// - Returns: returns the closest ineteger
    func getClosestInteger(value: Int, arr: [Int]) -> Int? {
        var closest: Int? = nil
        var minimumDifference = Int.max

        for number in arr {
            let difference = abs(value - number)
            if difference < minimumDifference {
                minimumDifference = difference
                closest = number
            }
        }

        return closest
    }
    
}

