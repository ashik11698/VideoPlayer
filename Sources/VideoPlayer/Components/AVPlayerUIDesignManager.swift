//
//  AVPlayerUIDesignManager.swift
//  AVPlayerDemo
//
//  Created by Md. Ashikur Rahman on 5/7/23.
//  Copyright © 2023 BJIT Ltd. All rights reserved.
//

import UIKit

class AVPlayerUIDesignManager {
    
    var playerView = UIView()
    var playAndPauseButton = UIButton()
    var forwardSkipButton = UIButton()
    var backwardSkipButton = UIButton()
    var activityIndicator = UIActivityIndicatorView()
    var miniPlayerButton = UIButton()
    var settingButton = UIButton()
    var progressView = UIProgressView()
    var fullScreenButton = UIButton()
    var slider = UISlider()
    var playerTime = UILabel()
    var playerTotalDuration = UILabel()
    var liveLabel = UILabel()
    var liveRedCircleImage = UIImageView()
    var liveStack = UIStackView()
    var nextVideoButton = UIButton()
    var previousVideoButton = UIButton()
    
    let liveString = NSLocalizedString("Live", comment: "")
    let buttonHeightAndWidth: CGFloat = 45
    
    init() {
        
    }
    
    init(playerView: UIView, playAndPauseButton: UIButton, forwardSkipButton: UIButton, backwardSkipButton: UIButton, activityIndicator: UIActivityIndicatorView, miniPlayerButton: UIButton, settingButton: UIButton, progressView: UIProgressView, fullScreenButton: UIButton, slider: UISlider, playerTime: UILabel, playerTotalDuration: UILabel, liveLabel: UILabel, liveRedCircleImage: UIImageView, liveStack: UIStackView, nextVideoButton: UIButton, previousVideoButton: UIButton) {
        self.playerView = playerView
        self.playAndPauseButton = playAndPauseButton
        self.forwardSkipButton = forwardSkipButton
        self.backwardSkipButton = backwardSkipButton
        self.activityIndicator = activityIndicator
        self.miniPlayerButton = miniPlayerButton
        self.settingButton = settingButton
        self.progressView = progressView
        self.fullScreenButton = fullScreenButton
        self.slider = slider
        self.playerTime = playerTime
        self.playerTotalDuration = playerTotalDuration
        self.liveLabel = liveLabel
        self.liveRedCircleImage = liveRedCircleImage
        self.liveStack = liveStack
        self.nextVideoButton = nextVideoButton
        self.previousVideoButton = previousVideoButton
    }
    
    
    func setPositionPlayerView(view: UIView, navigationController: UINavigationController?) {
        
        playerView.backgroundColor = UIColor.black
        
        view.addSubview(self.playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = true
        
        if let topLayoutGuideHeight = navigationController?.navigationBar.frame.maxY {
            let y = topLayoutGuideHeight + 10
            playerView.frame = CGRect(x: 10, y: y, width: view.bounds.width - 20, height: view.bounds.height/3 - 20)
        }
        
    }
    
    
    func setPositionPlayAndPauseButton() -> UIButton {
        
        playAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        playAndPauseButton.tintColor = UIColor.white
        
        playAndPauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        playAndPauseButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        playAndPauseButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(playAndPauseButton)
        
        let centerXConstraint = playAndPauseButton.centerXAnchor.constraint(equalTo: playerView.centerXAnchor)
        let centerYConstraint = playAndPauseButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor)
        
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
        
        return playAndPauseButton
        
    }
    
    
    func setPositionForwardSkipButton() -> UIButton {
        
        forwardSkipButton.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        forwardSkipButton.tintColor = UIColor.white
        
        forwardSkipButton.translatesAutoresizingMaskIntoConstraints = false
        
        forwardSkipButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        forwardSkipButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(forwardSkipButton)
        
        let centerYConstraint = forwardSkipButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor)
        
        let leadingConstraint = forwardSkipButton.leadingAnchor.constraint(equalTo: playAndPauseButton.trailingAnchor, constant: 40)
        
        NSLayoutConstraint.activate([centerYConstraint, leadingConstraint])
        
        return forwardSkipButton

    }
    
    
    func setPositionBackwardSkipButton() -> UIButton {
        
        backwardSkipButton.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        backwardSkipButton.tintColor = UIColor.white
        
        backwardSkipButton.translatesAutoresizingMaskIntoConstraints = false
        
        backwardSkipButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        backwardSkipButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(backwardSkipButton)
        
        let centerYConstraint = backwardSkipButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor)
        
        let trailingConstraint = backwardSkipButton.trailingAnchor.constraint(equalTo: playAndPauseButton.leadingAnchor, constant: -40)
        
        NSLayoutConstraint.activate([centerYConstraint, trailingConstraint])
        
        return backwardSkipButton

    }
    
    
    func setPositionActivityIndicator(color: UIColor) {
        
        activityIndicator.color = color
        activityIndicator.style = .large
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(activityIndicator)
        
        let centerXConstraint = activityIndicator.centerXAnchor.constraint(equalTo: playerView.centerXAnchor)
        let centerYConstraint = activityIndicator.centerYAnchor.constraint(equalTo: playerView.centerYAnchor)
        
        NSLayoutConstraint.activate([centerXConstraint, centerYConstraint])
        
    }
    
    func setPositionMiniPlayerButtonOutlet() -> UIButton {
        
        miniPlayerButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        miniPlayerButton.tintColor = UIColor.white
        
        miniPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        
        miniPlayerButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        miniPlayerButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(miniPlayerButton)
        
        let topConstraint = miniPlayerButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 15)
        
        let leadingConstraint = miniPlayerButton.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 15)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint])
        
        return miniPlayerButton
        
    }
    
    
    func setPositionSettingButtonOutlet() -> UIButton {
        
        settingButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        settingButton.tintColor = UIColor.white
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(settingButton)
        
        let topConstraint = settingButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 15)
        
        let trailingConstraint = settingButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -15)
        
        NSLayoutConstraint.activate([topConstraint, trailingConstraint])
        
        return settingButton
        
    }
    
    
    func setPositionProgressView() {
        
        progressView.tintColor = UIColor.red
        
        progressView.progress = 1.0
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(progressView)
        
        let bottomConstraint = progressView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -15)
        
        let leadingConstraint = progressView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 0)
        
        let trailingConstraint = progressView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint, trailingConstraint])
        
    }
    
    
    func setPositionFullScreenButtonOutlet(isLiveStream: Bool) -> UIButton {
        
        fullScreenButton.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        
        fullScreenButton.tintColor = UIColor.red
        
        fullScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        fullScreenButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        fullScreenButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(fullScreenButton)
        
        if isLiveStream {
            fullScreenButton.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: -15).isActive = true
        }
        else {
            fullScreenButton.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -15).isActive = true
        }

        fullScreenButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -15).isActive = true
        
        return fullScreenButton
        
    }
    
    
    func setPositionSlider(minimumTrackTintColor: UIColor, maximumTrackTintColor: UIColor, thumbTintColor: UIColor) {
        
        slider.maximumTrackTintColor = maximumTrackTintColor
        slider.minimumTrackTintColor = minimumTrackTintColor
        slider.thumbTintColor = thumbTintColor
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(slider)
        
        let bottomConstraint = slider.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: -15)

        let trailingConstraint = slider.trailingAnchor.constraint(equalTo: fullScreenButton.leadingAnchor, constant: -10)

        let leadingConstraint = slider.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 10)
        
        NSLayoutConstraint.activate([bottomConstraint, trailingConstraint, leadingConstraint])
        
    }
    
    
    func setPositionPlayerTime() {
        
        playerTime.textColor = UIColor.white
        playerTime.font = UIFont.boldSystemFont(ofSize: 14)
        
        playerTime.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(playerTime)
        
        let bottomConstraint = playerTime.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -4)
        
        let leadingConstraint = playerTime.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 10)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint])
        
    }
    
    
    func setPositionPlayerTotalDuration() {
        
        playerTotalDuration.textColor = UIColor.white
        playerTotalDuration.font = UIFont.boldSystemFont(ofSize: 14)
        
        playerTotalDuration.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(playerTotalDuration)
        
        let bottomConstraint = playerTotalDuration.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -4)
        
        let leadingConstraint = playerTotalDuration.leadingAnchor.constraint(equalTo: playerTime.trailingAnchor, constant: 4)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint])
        
    }
    
    
    func setPositionLiveStack() {
        
        liveLabel.text = " \(liveString)"
        liveLabel.textColor = UIColor.red
        
        liveRedCircleImage.image = UIImage(systemName: "circle.fill")
        liveRedCircleImage.tintColor = UIColor.red
        
        liveStack.addArrangedSubview(liveRedCircleImage)
        liveStack.addArrangedSubview(liveLabel)
        
        liveStack.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(liveStack)
        
        let bottomConstraint = liveStack.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -10)
        
        let leadingConstraint = liveStack.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: 15)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint])
        
    }
    
    
    /// Set Position For the Next Video Button
    func setPositionNextVideoButton() -> UIButton {
        
        nextVideoButton.setImage(UIImage(systemName: "forward.end"), for: .normal)
        nextVideoButton.tintColor = UIColor.white
        
        nextVideoButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextVideoButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        nextVideoButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(nextVideoButton)
        
        let topConstraint = nextVideoButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 15)

        let trailingConstraint = nextVideoButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: 10)
        
        NSLayoutConstraint.activate([topConstraint, trailingConstraint])
        
        return nextVideoButton

    }
    
    
    /// Set Position For the previous Video Button
    func setPositionPreviousVideoButton() -> UIButton {

        previousVideoButton.setImage(UIImage(systemName: "backward.end"), for: .normal)
        previousVideoButton.tintColor = UIColor.white
        
        previousVideoButton.translatesAutoresizingMaskIntoConstraints = false
        
        previousVideoButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        previousVideoButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(previousVideoButton)
        
        let topConstraint = previousVideoButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 15)
        
        let trailingConstraint = previousVideoButton.trailingAnchor.constraint(equalTo: nextVideoButton.leadingAnchor, constant: 10)
        
        NSLayoutConstraint.activate([topConstraint, trailingConstraint])
        
        return previousVideoButton

    }
    
}

