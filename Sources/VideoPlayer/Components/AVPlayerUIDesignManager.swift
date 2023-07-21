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
    
    /// Constraints
    let playerViewFrameX: CGFloat = 10
    let playerViewFrameYPadding: CGFloat = 10
    let playerViewFrameWidthPadding: CGFloat = 20
    let playerViewFrameHeightPadding: CGFloat = 20
    let forwardSkipButtonLeadingConstraint: CGFloat = 40
    let backwardSkipButtonTrailingConstraint: CGFloat = -40
    let miniPlayerButtonTopConstraint: CGFloat = 0
    let miniPlayerButtonLeadingConstraint: CGFloat = 0
    let settingsButtonTopConstraint: CGFloat = 0
    let settingsButtonTrailingConstraint: CGFloat = -5
    let progressViewBottomConstraint: CGFloat = -15
    let progressViewLeadingConstraint: CGFloat = 0
    let progressViewTrailingConstraint: CGFloat = 0
    let fullScreenButtonBottomConstraint: CGFloat = -10
    let fullScreenButtonTrailingConstraint: CGFloat = -5
    let sliderBottomConstraint: CGFloat = -15
    let sliderTrailingConstraint: CGFloat = -10
    let sliderLeadingConstraint: CGFloat = 10
    let playerTimeBottomConstraint: CGFloat = -4
    let playerTimeLeadingConstraint: CGFloat = 10
    let playerTotalDurationBottomConstraint: CGFloat = -4
    let playerTotalDurationLeadingConstraint: CGFloat = 4
    let liveStackBottomConstraint: CGFloat = -10
    let liveStackLeadingConstraint: CGFloat = 15
    let nextVideoButtonTopConstraint: CGFloat = 0
    let nextVideoTrailingConstraint: CGFloat = 10
    let previousVideoButtonTopConstraint: CGFloat = 0
    let previousVideoButtonTrailingConstraint: CGFloat = 10
    
    /// System Image
    let playAndPauseButtonSystemImage = "pause.fill"
    let forwardSkipButtonSystemImage = "forward.fill"
    let backwardSkipButtonSystemImage = "backward.fill"
    let miniPlayerButtonSystemImage = "chevron.down"
    let settingsButtonSystemImage = "ellipsis"
    let fullScreenButtonSystemImage = "arrow.up.left.and.arrow.down.right"
    let liveRedCircleSystemImage = "circle.fill"
    let nextVideoButtonSystemImage = "forward.end"
    let previousVideoButtonSystemImage = "backward.end"
    

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
            let y = topLayoutGuideHeight + playerViewFrameYPadding
            playerView.frame = CGRect(x: playerViewFrameX, y: y, width: view.bounds.width - playerViewFrameWidthPadding, height: view.bounds.height/3 - playerViewFrameHeightPadding)
        }
        
    }
    
    
    func setPositionPlayAndPauseButton() -> UIButton {
        
        playAndPauseButton.setImage(UIImage(systemName: playAndPauseButtonSystemImage), for: .normal)
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
        
        forwardSkipButton.setImage(UIImage(systemName: forwardSkipButtonSystemImage), for: .normal)
        forwardSkipButton.tintColor = UIColor.white
        
        forwardSkipButton.translatesAutoresizingMaskIntoConstraints = false
        
        forwardSkipButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        forwardSkipButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(forwardSkipButton)
        
        let centerYConstraint = forwardSkipButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor)
        
        let leadingConstraint = forwardSkipButton.leadingAnchor.constraint(equalTo: playAndPauseButton.trailingAnchor, constant: forwardSkipButtonLeadingConstraint)
        
        NSLayoutConstraint.activate([centerYConstraint, leadingConstraint])
        
        return forwardSkipButton

    }
    
    
    func setPositionBackwardSkipButton() -> UIButton {
        
        backwardSkipButton.setImage(UIImage(systemName: backwardSkipButtonSystemImage), for: .normal)
        backwardSkipButton.tintColor = UIColor.white
        
        backwardSkipButton.translatesAutoresizingMaskIntoConstraints = false
        
        backwardSkipButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        backwardSkipButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(backwardSkipButton)
        
        let centerYConstraint = backwardSkipButton.centerYAnchor.constraint(equalTo: playerView.centerYAnchor)
        
        let trailingConstraint = backwardSkipButton.trailingAnchor.constraint(equalTo: playAndPauseButton.leadingAnchor, constant: backwardSkipButtonTrailingConstraint)
        
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
        
        miniPlayerButton.setImage(UIImage(systemName: miniPlayerButtonSystemImage), for: .normal)
        miniPlayerButton.tintColor = UIColor.white
        
        miniPlayerButton.translatesAutoresizingMaskIntoConstraints = false
        
        miniPlayerButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        miniPlayerButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(miniPlayerButton)
        
        let topConstraint = miniPlayerButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: miniPlayerButtonTopConstraint)
        
        let leadingConstraint = miniPlayerButton.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: miniPlayerButtonLeadingConstraint)
        
        NSLayoutConstraint.activate([topConstraint, leadingConstraint])
        
        return miniPlayerButton
        
    }
    
    
    func setPositionSettingButtonOutlet() -> UIButton {
        
        settingButton.setImage(UIImage(systemName: settingsButtonSystemImage), for: .normal)
        settingButton.tintColor = UIColor.white
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        
        settingButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        settingButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(settingButton)
        
        let topConstraint = settingButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: settingsButtonTopConstraint)
        
        let trailingConstraint = settingButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: settingsButtonTrailingConstraint)
        
        NSLayoutConstraint.activate([topConstraint, trailingConstraint])
        
        return settingButton
        
    }
    
    
    func setPositionProgressView() {
        
        progressView.tintColor = UIColor.red
        
        progressView.progress = 1.0
        
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(progressView)
        
        let bottomConstraint = progressView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: progressViewBottomConstraint)
        
        let leadingConstraint = progressView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: progressViewLeadingConstraint)
        
        let trailingConstraint = progressView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: progressViewTrailingConstraint)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint, trailingConstraint])
        
    }
    
    
    func setPositionFullScreenButtonOutlet(isLiveStream: Bool) -> UIButton {
        
        fullScreenButton.setImage(UIImage(systemName: fullScreenButtonSystemImage), for: .normal)
        
        fullScreenButton.tintColor = UIColor.red
        
        fullScreenButton.translatesAutoresizingMaskIntoConstraints = false
        
        fullScreenButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        fullScreenButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(fullScreenButton)
        
        if isLiveStream {
            fullScreenButton.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: fullScreenButtonBottomConstraint).isActive = true
        }
        else {
            fullScreenButton.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: fullScreenButtonBottomConstraint).isActive = true
        }

        fullScreenButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: fullScreenButtonTrailingConstraint).isActive = true
        
        return fullScreenButton
        
    }
    
    
    func setPositionSlider(minimumTrackTintColor: UIColor, maximumTrackTintColor: UIColor, thumbTintColor: UIColor) {
        
        slider.maximumTrackTintColor = maximumTrackTintColor
        slider.minimumTrackTintColor = minimumTrackTintColor
        slider.thumbTintColor = thumbTintColor
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(slider)
        
        let bottomConstraint = slider.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: sliderBottomConstraint)

        let trailingConstraint = slider.trailingAnchor.constraint(equalTo: fullScreenButton.leadingAnchor, constant: sliderTrailingConstraint)

        let leadingConstraint = slider.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: sliderLeadingConstraint)
        
        NSLayoutConstraint.activate([bottomConstraint, trailingConstraint, leadingConstraint])
        
    }
    
    
    func setPositionPlayerTime() {
        
        playerTime.textColor = UIColor.white
        playerTime.font = UIFont.boldSystemFont(ofSize: 14)
        
        playerTime.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(playerTime)
        
        let bottomConstraint = playerTime.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: playerTimeBottomConstraint)
        
        let leadingConstraint = playerTime.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: playerTimeLeadingConstraint)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint])
        
    }
    
    
    func setPositionPlayerTotalDuration() {
        
        playerTotalDuration.textColor = UIColor.white
        playerTotalDuration.font = UIFont.boldSystemFont(ofSize: 14)
        
        playerTotalDuration.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(playerTotalDuration)
        
        let bottomConstraint = playerTotalDuration.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: playerTotalDurationBottomConstraint)
        
        let leadingConstraint = playerTotalDuration.leadingAnchor.constraint(equalTo: playerTime.trailingAnchor, constant: playerTotalDurationLeadingConstraint)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint])
        
    }
    
    
    func setPositionLiveStack() {
        
        liveLabel.text = " \(liveString)"
        liveLabel.textColor = UIColor.red
        
        liveRedCircleImage.image = UIImage(systemName: liveRedCircleSystemImage)
        liveRedCircleImage.tintColor = UIColor.red
        
        liveStack.addArrangedSubview(liveRedCircleImage)
        liveStack.addArrangedSubview(liveLabel)
        
        liveStack.translatesAutoresizingMaskIntoConstraints = false
        
        playerView.addSubview(liveStack)
        
        let bottomConstraint = liveStack.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: liveStackBottomConstraint)
        
        let leadingConstraint = liveStack.leadingAnchor.constraint(equalTo: playerView.leadingAnchor, constant: liveStackLeadingConstraint)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint])
        
    }
    
    
    /// Set Position For the Next Video Button
    func setPositionNextVideoButton() -> UIButton {
        
        nextVideoButton.setImage(UIImage(systemName: nextVideoButtonSystemImage), for: .normal)
        nextVideoButton.tintColor = UIColor.white
        
        nextVideoButton.translatesAutoresizingMaskIntoConstraints = false
        
        nextVideoButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        nextVideoButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(nextVideoButton)
        
        let topConstraint = nextVideoButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: nextVideoButtonTopConstraint)

        let trailingConstraint = nextVideoButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor, constant: nextVideoTrailingConstraint)
        
        NSLayoutConstraint.activate([topConstraint, trailingConstraint])
        
        return nextVideoButton

    }
    
    
    /// Set Position For the previous Video Button
    func setPositionPreviousVideoButton() -> UIButton {

        previousVideoButton.setImage(UIImage(systemName: previousVideoButtonSystemImage), for: .normal)
        previousVideoButton.tintColor = UIColor.white
        
        previousVideoButton.translatesAutoresizingMaskIntoConstraints = false
        
        previousVideoButton.widthAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        previousVideoButton.heightAnchor.constraint(equalToConstant: buttonHeightAndWidth).isActive = true
        
        playerView.addSubview(previousVideoButton)
        
        let topConstraint = previousVideoButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: previousVideoButtonTopConstraint)
        
        let trailingConstraint = previousVideoButton.trailingAnchor.constraint(equalTo: nextVideoButton.leadingAnchor, constant: previousVideoButtonTrailingConstraint)
        
        NSLayoutConstraint.activate([topConstraint, trailingConstraint])
        
        return previousVideoButton

    }
    
}

