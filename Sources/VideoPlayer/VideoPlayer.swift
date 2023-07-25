//
//  AVPlayerManager.swift
//  AVPlayerDemo
//
//  Created by Md. Ashikur Rahman on 5/6/23.
//  Copyright © 2023 BJIT Ltd. All rights reserved.
//

import UIKit
import AVKit

public class AVPlayerManager: UIView {
    
    /// AVPlayerUIDesignManager initializer
    var avPlayerUIDesignManager = AVPlayerUIDesignManager()
    
    /// This is a UIView, where the video shows. The helps to set the position of PlayerLayer
    var playerView = UIView()
    
    /// This is a button, which can control exit/enter in full screen mode
    var fullScreenButton = UIButton()
    
    /// This is a button, which can control play and pause both
    var playAndPauseButton = UIButton()
    
    /// Slider to slide the video
    var slider = UISlider()
    
    /// Activity Indicator to show buffer
    var activityIndicator = UIActivityIndicatorView()
    
    /// To skip the video in forward
    var forwardSkipButton = UIButton()
    
    /// To skip the video in backward
    var backwardSkipButton = UIButton()
    
    /// Mini Player Button Outlet
    var miniPlayerButton = UIButton()
    
    /// Player Time/Duration Outlet
    var playerTime = UILabel()
    
    /// Player settings Outlet
    var settingButton = UIButton()
    
    /// Shows the total duration/time of the video
    var playerTotalDuration = UILabel()
    
    /// ProgressView for live
    var progressView = UIProgressView()
    
    /// Image of live red Circle
    var liveRedCircleImage = UIImageView()
    
    /// Label for live
    var liveLabel = UILabel()
    
    /// Stack of live label and red circle image
    var liveStack = UIStackView()
    
    /// Button to play next Video
    var nextVideoButton = UIButton()
    
    /// Button to play previous Video
    var previousVideoButton = UIButton()
    
    
    /// Tracks whether the video in rotated or not
    var isRotate = false
    
    /// Tracks the orientation of device
    var isLandscape = false
    
    /// Tracks whether the video is paused or playing, because a single button is working for both pause and play
    var isPause = false
    
    /// Tracks whether mini player starts or not
    var isMinimize = false
    
    /// Tracks the buffer
    var isBuffering = false
    
    /// Tracks whether live stream is on or off
    var isLiveStream = false
    
    /// AutoPlay
    var isAutoPlayOn = false
    
    /// To Track the dragging state of slider
    var isSliderDragStart = false
    
    /// track the finishing of the player
    var isFinishedPlaying = false
    
    /// Track if app runs for the first time
    var isFirstTimeRun = true
    
    
    /// Store the position of selected Video
    var selectedVideo = 0
    
    /// Origin of the mini player
    var minimizedOrigin: CGPoint {
        let x = 0.0
        let y = (UIScreen.main.bounds.height - (UIScreen.main.bounds.height/7 + 10))
        let coordinate = CGPoint.init(x: x, y: y)
        return coordinate
    }
    
    /// Mini Player Buttons and UIView
    var crossButton = UIButton()
    var miniPlayerPlayAndPauseButton = UIButton()
    var miniPlayerUIView = UIView()
    
    var playerLayer = AVPlayerLayer()
    var avPlayer: AVPlayer?
    
    /// For Preview
    var preview = SeekPreview()
    var images: [ Int : UIImage ] = [:]
    var imageGenerator: AVAssetImageGenerator?
    
    /// For hiding button after a certain time (5 seconds)
    var workItem: DispatchWorkItem?
    
    /// For playing next video after 10 seconds
    var WorkItemNextVideo: DispatchWorkItem?
    
    /// Timer
    var timer = Timer()
    
    /// Main View
    var view = UIView()
    
    /// Navigation Controller
    var navigationController: UINavigationController?
    
    /// PlayList
    var playList: [URL?]?

    
    /// System Image
    let miniPlayerPlayAndPauseButtonSystemImage = "pause"
    let miniPlayerCrossButtonSystemImage = "xmark"
    let fullScreenButtonPortraitSystemImage = "arrow.up.left.and.arrow.down.right"
    let fullScreenButtonLandscapeSystemImage = "arrow.down.right.and.arrow.up.left"
    let playButtonSystemImage = "play.fill"
    let pauseButtonSystemImage = "pause.fill"
    
    static let shared = AVPlayerManager()
    
    
    public init(navigationController: UINavigationController? = UINavigationController(), view: UIView = UIView(), isLiveStream: Bool = false, isAutoPlayOn: Bool = false, playList: [URL?] = [Urls.m3u8Video1, Urls.m3u8Video3, Urls.m3u8Video6, Urls.BigBuckBunny]) {
        if navigationController != nil {
            self.navigationController = navigationController
        }
        else {
            self.navigationController = UINavigationController()
        }
        
        self.view = view
        self.isLiveStream = isLiveStream
        self.isAutoPlayOn = isAutoPlayOn
        self.playList = playList

        super.init(frame: .zero)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// It notifies when UIView removed/added
    public override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)

        if newWindow == nil {
            // UIView is being removed from the window or hidden
            // Perform your cleanup or actions here
            stopPlayerAndPlayerObserver()
            NotificationCenter.default.removeObserver(self)
            NetworkManager.shared.reachability.stopNotifier()
            
        } else {
            // UIView is being added to the window or shown
            NetworkManager.shared.MonitorConnectionReachability { connection in
                if connection == .satisfied && self.isFirstTimeRun == false {
                    let alert = ActionSheet.shared.alertMessage(title: "Internet", message: "Internet Connected")
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                }
                
                else if connection == .notSatisfied {
                    let alert = ActionSheet.shared.alertMessage(title: "Internet", message: "No Internet")
                    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    self.isFirstTimeRun = false
                }
            }
        }
    }
    
    
    public func setUpPlayer() {
        
        avPlayerUIDesignManager = AVPlayerUIDesignManager(playerView: playerView, playAndPauseButton: playAndPauseButton, forwardSkipButton: forwardSkipButton, backwardSkipButton: backwardSkipButton, activityIndicator: activityIndicator, miniPlayerButton: miniPlayerButton, settingButton: settingButton, progressView: progressView, fullScreenButton: fullScreenButton, slider: slider, playerTime: playerTime, playerTotalDuration: playerTotalDuration, liveLabel: liveLabel, liveRedCircleImage: liveRedCircleImage, liveStack: liveStack, nextVideoButton: nextVideoButton, previousVideoButton: previousVideoButton)
        
        /// Set Position of Components
        allComponentsOfPlayerView()
        
        /// When app runs for the first time, there is no previous video
        previousVideoButton.isEnabled = false
        
        /// If app runs first time with landscape mode
        let orientation = Utils.shared.deviceOrientation()
        if orientation == Orientation.landscapeRight.rawValue || orientation == Orientation.landscapeLeft.rawValue {
            navigationController?.isNavigationBarHidden = true
            self.showVideoInLandscape()
            self.isRotate = true
            self.isLandscape = true
            self.miniPlayerButton.isHidden = true
        }
        
        /// Hide the buttons of playerView
        hidePlayerControllers()
        
        /// Create UiView
        miniPlayerUIView = Utils.shared.createUIView(view: self.view)
        
        /// Create Play And Pause Button For MiniPlayer
        self.miniPlayerPlayAndPauseButton = Utils.shared.createButton(
            tintColor: UIColor.black,
            title: "",
            imageName: miniPlayerPlayAndPauseButtonSystemImage)
        
        /// Create Cross Button For MiniPlayer
        self.crossButton = Utils.shared.createButton(
            tintColor: UIColor.black,
            title: "",
            imageName: miniPlayerCrossButtonSystemImage)
        
        hidePlayerControllers()
        
        /// Preview
        preview.delegate = self
        preview.borderColor = UIColor.black
        preview.borderWidth = 1
        preview.cornerRadius = 5
        preview.attachToSlider(slider: slider)
        
        /// Touch Gesture
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.playerViewTouchGesture (_:)))
        playerView.addGestureRecognizer(gesture)

        /// When app moves to background
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)

        /// Observe if video is finished or not
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer?.currentItem)
        
        /// Play Video
        hidePlayerControllers()
        let url = playList?[0]
        playVideo(url: url)
        
        /// Navigation Controller Delegate
        navigationController?.delegate = self
        
    }
    
    
    // MARK: - Skip Video In Forward
    /// This function is to skip video in forward
    /// - Parameters:
    ///   - seconds: seconds to forward the video
    ///   - avPlayer: which avPlayer to forward
    func skipTimeForward(seconds: Int64, avPlayer: AVPlayer) {
        
        let currentTime = Utils.shared.getCurrentTimeOfVideo(avPlayer: avPlayer)
        let targetTime: CMTime = CMTimeMake(value: Int64(currentTime) + seconds, timescale: 1)
        avPlayer.seek(to: targetTime) // Skip video according to targetTime
        
    }
    
    
    // MARK: - Skip Video In Backward
    /// This function is to skip video in backward
    /// - Parameters:
    ///   - seconds: seconds to backward the video
    ///   - avPlayer: which avPlayer to backward
    func skipTimeBackward(seconds: Int64, avPlayer: AVPlayer) {
        
        let currentTime = Utils.shared.getCurrentTimeOfVideo(avPlayer: avPlayer)
        let targetTime: CMTime = CMTimeMake(value: Int64(currentTime) - seconds, timescale: 1)
        avPlayer.seek(to: targetTime) // Skip video according to targetTime
        
    }
    
    
    // MARK: - Configure Mini Player
    /// This function is to place the mini player and it's buttons to right place
    /// - Parameters:
    ///   - view: This is the main view where the plyerView is situated
    ///   - playerView: This is the playerView where the plyerLayer is situated
    ///   - playerLayer: This is the playerLayer of AVPlayer
    ///   - crossButton: Cancel button of mini player
    ///   - playAndPauseButtonForMiniPlayer: Pause/Play button of mini player
    ///   - minimizedOrigin: This is the origin of the mini player
    ///   - buttonWidth: button width of mini player
    ///   - buttonHeight: button height of mini player
    /// - Returns: returns a tuple of buttons (cancel button and pause/play button)
    func configureMiniPlayer(view: UIView, playerView: UIView, playerLayer: AVPlayerLayer, crossButton: UIButton, playAndPauseButtonForMiniPlayer: UIButton, minimizedOrigin: CGPoint?, buttonWidth: Int, buttonHeight: Int) -> (UIButton, UIButton) {
        
        view.addSubview(playerView)
        
        view.backgroundColor = UIColor.lightGray
        view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/7)
        view.frame.origin = minimizedOrigin!
        
        playerView.translatesAutoresizingMaskIntoConstraints = true
        playerView.frame = CGRect(x: 5, y: 0, width: view.bounds.width/2, height: view.bounds.height)
        
        playerLayer.frame = playerView.bounds
        
        let x = (Int(view.bounds.width - playerView.bounds.width) - Int(buttonWidth)) / 2 + Int(playerView.bounds.width)
        
        playAndPauseButtonForMiniPlayer.frame = CGRect(
            x: x - 20,
            y: (Int(view.bounds.height) - buttonHeight) / 2,
            width: Int(buttonWidth),
            height: Int(buttonHeight)
        )
        
        crossButton.frame = CGRect(
            x: x + 35,
            y: (Int(view.bounds.height) - buttonHeight) / 2,
            width: Int(buttonWidth),
            height: Int(buttonHeight)
        )
        
        view.addSubview(playAndPauseButtonForMiniPlayer)
        view.addSubview(crossButton)
        
        return (crossButton, playAndPauseButtonForMiniPlayer)
        
    }
    
    
    // MARK: - Set Speed to AVPlayer
    /// This functions sets the speed of avPlayer
    /// - Parameter rate: In which speed the avPlayer should play
    func setSpeedToAVPlayer(rate: Float, avPlayer: AVPlayer) {
        
        avPlayer.currentItem?.audioTimePitchAlgorithm = .timeDomain
        avPlayer.play()
        avPlayer.rate = rate // In this rate (speed) the video will play
        
    }
    
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        
        isFinishedPlaying = true
        playAndPauseButton.setImage(UIImage(systemName: "goforward"), for: .normal)
        miniPlayerPlayAndPauseButton.setImage(UIImage(systemName: "goforward"), for: .normal)

        if isAutoPlayOn {
            var counter = 9
            
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { time in
                self.playerTotalDuration.text = ""
                self.playerTime.text = "Up next in \(counter)"
                counter -= 1
            }
        }
        
        WorkItemNextVideo?.cancel()
        
        if isAutoPlayOn {
            WorkItemNextVideo = DispatchWorkItem {
                
                self.previousVideoButton.isEnabled = true
                
                guard let playList = self.playList else {
                    return
                }
                
                if self.selectedVideo < playList.count - 1 {
                    self.selectedVideo += 1
                    
                    self.playSelectedVideo(selectedVideo: self.selectedVideo)
                }
                
                if self.selectedVideo == playList.count - 1 {
                    self.nextVideoButton.isEnabled = false
                }
            }
        }
        
        guard let WorkItemNextVideo = WorkItemNextVideo else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10), execute: WorkItemNextVideo)
        
    }
    
    
    /// Executes this function when the app moves to background
    @objc func appMovedToBackground() {
        
        playAndPauseButton.setImage(UIImage(systemName: playButtonSystemImage), for: .normal)
        
        miniPlayerPlayAndPauseButton.setImage(UIImage(systemName: playButtonSystemImage), for: .normal)
        
        isPause = !isPause
    }
    
    
    // MARK: - Executes when phone orientation changes
    /// This is to observe the phone orientation
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        debugPrint("Orientation changed")

        if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass ||
            traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {

            let orientation = Utils.shared.deviceOrientation()
            if orientation == Orientation.portrait.rawValue {
                navigationController?.isNavigationBarHidden = false
                self.showVideoInPortrait()
                self.isRotate = false
                self.isLandscape = false
                self.hideMiniPlayerButtons()
                self.hidePlayerControllers()
                self.miniPlayerUIView.isHidden = true
            }
            if orientation == Orientation.landscapeRight.rawValue || orientation == Orientation.landscapeLeft.rawValue {
                navigationController?.isNavigationBarHidden = true
                self.showVideoInLandscape()
                self.isRotate = true
                self.isLandscape = true
                self.miniPlayerButton.isHidden = true
            }

            if orientation == Orientation.upsideDown.rawValue {
                navigationController?.isNavigationBarHidden = false
                self.changeDeviceOrientation(to: .portrait)
                self.showVideoInPortrait()
            }
        }
    }
    
    
    // MARK: - Observe Buffering
    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "timeControlStatus", let change = change, let newValue = change[NSKeyValueChangeKey.newKey] as? Int, let oldValue = change[NSKeyValueChangeKey.oldKey] as? Int {
            let oldStatus = AVPlayer.TimeControlStatus(rawValue: oldValue)
            let newStatus = AVPlayer.TimeControlStatus(rawValue: newValue)
            if newStatus != oldStatus {
                DispatchQueue.main.async {[weak self] in
                    if newStatus == .playing || newStatus == .paused {
                        self?.activityIndicator.stopAnimating()
                        self?.activityIndicator.isHidden = true
                        
                        if self?.isMinimize == false {
                            self?.unhidePlayerControllers()
                            self?.hideButtonsAfterCertainTime(seconds: 5)
                        }
                        self?.isBuffering = false
                    }
                    else {
                        self?.activityIndicator.startAnimating()
                        self?.activityIndicator.isHidden = false
                        self?.isBuffering = true
                    }
                }
            }
        }
    }
    
    
    @objc func closeMiniPlayer() {
        
        UIView.animate(withDuration: 0.3) {
            self.playerLayer.player?.pause()
            self.miniPlayerUIView.frame.origin.x = -self.view.bounds.width - 20
        } completion: { _ in
            self.miniPlayerUIView.isHidden = true
            self.avPlayer?.pause()
            self.playerLayer.removeFromSuperlayer()
            self.playerLayer.player = nil
        }
        
    }
    
    
    /// Touch Gesture Action
    @objc func playerViewTouchGesture(_ sender:UITapGestureRecognizer){
        
        // Expand Mini Player to actual player size
        UIView.animate(withDuration: 0.3, animations: {
            if self.isMinimize {
                self.view.backgroundColor = UIColor.white
                self.unhidePlayerControllers()
                self.hideMiniPlayerButtons()
                self.view.bounds = UIScreen.main.bounds
                self.view.frame.origin = CGPoint.init(x: 0, y: 0)
                self.showVideoInPortrait()
                self.miniPlayerUIView.isHidden = true
                self.isMinimize = false
            }
        })
        
        // Touch gesture to invisible the buttons after 5 seconds and visible when it touched
        unhidePlayerControllers() // Unhide buttons when playerView touched
        
        changeOpacityOfPlayerLayer(opacity: 0.5) // change opacity of payerLayer
        
        hideButtonsAfterCertainTime(seconds: 5) // Hide buttons after 5 seconds
        
    }
    
    
    @objc func pauseAndPlayMiniPlayerAction() {
        
        togglePauseAndPlay()
        
    }
    
    
    // MARK: - Plays the video from beginning
    /// This is a function to start a video for a specific url. Here configures the player and set the frame of playerLayer to an UIView (playerView)
    func playVideo(url: URL?) {

        /// Remove playerLayer from its parent layer
        playerLayer.removeFromSuperlayer()
        playerLayer.player = nil
        timer.invalidate()
        
        /// Audio: It helps to play sound even when phone is in the silent mode.
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: [])
        }
        catch {
            debugPrint("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        /// Initially the Pause button will be Visisble
        playAndPauseButton.setImage(UIImage(systemName: pauseButtonSystemImage), for: .normal)
        
        guard let url = url else {
            debugPrint("Video doesn't exist or format issue. Please make sure the correct name of the video and format.")
            return
        }
        
        avPlayer = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: avPlayer ?? AVPlayer())
        
        /// Buffer
        avPlayer?.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        
        self.playerView.layer.addSublayer(playerLayer)
        
        /// Set the frame of the player Layer according to the playerView bound
        playerLayer.frame = self.playerView.layer.bounds
        
        /// Set the full Screen Button to playerView
        self.playerView.addSubview(fullScreenButton)
        
        /// Set the play Button to playerView
        self.playerView.addSubview(playAndPauseButton)
        
        /// Set the slider to playerView
        self.playerView.addSubview(slider)
        
        /// Set the activity indicator to playerView
        self.playerView.addSubview(activityIndicator)
        
        /// Set the forwardSkipButtonOutlet to playerView
        self.playerView.addSubview(forwardSkipButton)
        
        /// Set the backwardSkipButtonOutlet to playerView
        self.playerView.addSubview(backwardSkipButton)
        
        /// Set the mini player outlet to playerView
        self.playerView.addSubview(miniPlayerButton)
        
        /// Set the preview to playerView
        self.playerView.addSubview(preview)
        
        // Set the player time to playerView
        self.playerView.addSubview(playerTime)
        
        /// Set the player total time/duration to playerView
        self.playerView.addSubview(playerTotalDuration)
        
        /// Set the settings to playerView
        self.playerView.addSubview(settingButton)
        
        /// Set the live stack (live label and red circle image) to playerView
        self.playerView.addSubview(liveStack)
        
        /// Set the progressView to playerView
        self.playerView.addSubview(progressView)
        
        /// Set the nextVideoButton to playerView
        self.playerView.addSubview(nextVideoButton)
        
        /// Set the previousVideoButton to playerView
        self.playerView.addSubview(previousVideoButton)
        
        
        /// Preview
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.bottomAnchor.constraint(equalTo: self.slider.topAnchor).isActive = true
        preview.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        if !isLiveStream {
            configureSlider(color: UIColor.red)
            generateImages()
        }
        
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        
        if isLandscape {
            showVideoInLandscape()
        }
        else {
            showVideoInPortrait()
        }
        
        // Play the video
        avPlayer?.play()
    }
    
    
    // MARK: - Function to show the video in portrait mode
    /// This functions calls, when we need to show the video in portrait mode. This function rotates playerLayer and playAndPauseBtnOutlet 360 degree to set the video straight.
    func showVideoInPortrait() {
        
        fullScreenButton.setImage(UIImage(systemName: fullScreenButtonPortraitSystemImage), for: .normal)
        
        if isRotate {
            playerView.transform = CGAffineTransform(rotationAngle: Utils.shared.degreeToRadian(360))
        }
        
        playerView.isHidden = false
        
        avPlayerUIDesignManager.setPositionPlayerView(view: self.view, navigationController: navigationController)
        
        playerLayer.frame = playerView.bounds
        
    }
    
    
    // MARK: - Function to show the video in landscape mode
    /// This function calls when the device is in landscape mode. It hides all the button and UIView and set the playerViewframe to the main view (To cover entire screen).
    func showVideoInLandscape() {
        
        fullScreenButton.setImage(UIImage(systemName: fullScreenButtonLandscapeSystemImage), for: .normal)
        
        if isRotate {
            playerView.transform = CGAffineTransform(rotationAngle: Utils.shared.degreeToRadian(360))
        }
        
        self.view.addSubview(self.playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = true
        self.playerView.frame = self.view.bounds
        self.playerLayer.frame = self.playerView.bounds
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        
    }
    
    
    // MARK: - Function for entering in full screen
    /// This function works when we click the full screen button to enter in full screen mode. It rotates playerView and set the playerView frame to the main view.
    func enterFullScreen() {
        
        changeDeviceOrientation(to: .landscapeLeft)
        showVideoInLandscape()
        self.isRotate = true
        
    }
    
    
    // MARK: - Function for exiting full screen
    /// This function calls when we are in portrait mode.
    func ExitFullScreen() {
        
        if isLandscape {
            changeDeviceOrientation(to: .portrait)
        }
        
        showVideoInPortrait()
        self.isRotate = false
        
    }
    
    
    // MARK: - Configure the Slider
    /// Did all the tasks of slider here
    public func configureSlider(color: UIColor) {
        
        slider.tintColor = color
        
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        let mainQueue = DispatchQueue.main
        avPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue) { [weak self] time in
            guard let currentItem = self?.avPlayer?.currentItem else {return}
            if self?.avPlayer?.currentItem!.status == .readyToPlay {
                self?.slider.minimumValue = 0
                self?.slider.maximumValue = Float(currentItem.duration.seconds)

                if self?.isBuffering == false && self?.isSliderDragStart == false && self?.isPause == false {
                    self?.slider.setValue(Float(time.seconds), animated: true)
                    self?.playerTime.text = time.durationText
                    self?.setPlayerTime()
                }
            }
        }
        
        slider.addTarget(self, action: #selector(self.playbackSliderValueChanged(_:_:)), for: .valueChanged)
        
    }
    
    
    @objc func playbackSliderValueChanged(_ playbackSlider: UISlider, _ event: UIEvent) {
        
        let seconds: Int64 = Int64(playbackSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        avPlayer?.seek(to: targetTime)
        
        /// To detect the dragging state of slider
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                isSliderDragStart = true
            case .moved:
                isSliderDragStart = true
            case .ended:
                isSliderDragStart = false
            default:
                break
            }
        }
        
        setPlayerTime()
        
    }
    
    
    // MARK: - Hide Player Controllers
    /// Hides the buttons, stackView, slilder and activity Indicator of player
    func hidePlayerControllers() {
        
        activityIndicator.isHidden = true
        playAndPauseButton.isHidden = true
        fullScreenButton.isHidden = true
        progressView.isHidden = true
        liveLabel.isHidden = true
        liveRedCircleImage.isHidden = true
        slider.isHidden = true
        forwardSkipButton.isHidden = true
        backwardSkipButton.isHidden = true
        miniPlayerButton.isHidden = true
        playerTime.isHidden = true
        playerTotalDuration.isHidden = true
        settingButton.isHidden = true
        nextVideoButton.isHidden = true
        previousVideoButton.isHidden = true
        preview.alpha = 0
        
        changeOpacityOfPlayerLayer(opacity: 1.0) // change opacitiy of player
        
    }
    
    
    // MARK: - Unhide Player Controllers
    /// Unhide the buttons, stackView, slilder and activity Indicator of player
    func unhidePlayerControllers() {
        
        playAndPauseButton.isHidden = false
        fullScreenButton.isHidden = false
        nextVideoButton.isHidden = false
        previousVideoButton.isHidden = false
        
        if isLiveStream {
            progressView.isHidden = false
            playerTotalDuration.isHidden = true
            playerTime.isHidden = true
            forwardSkipButton.isHidden = true
            backwardSkipButton.isHidden = true
            
            liveLabel.isHidden = false
            liveRedCircleImage.isHidden = false
            
            UIView.animate(withDuration: 0.7, delay: 0.7, options: [.repeat, .autoreverse]) {
                self.liveRedCircleImage.layer.opacity = 0.0
            }

        }
        else {
            slider.isHidden = false
            playerTime.isHidden = false
            playerTotalDuration.isHidden = false
            forwardSkipButton.isHidden = false
            backwardSkipButton.isHidden = false
            
            liveLabel.isHidden = true
            liveRedCircleImage.isHidden = true
        }
        
        if isLandscape || isRotate {
            miniPlayerButton.isHidden = true
        }
        else {
            miniPlayerButton.isHidden = false
        }
        
        settingButton.isHidden = false
        preview.alpha = 1
        
        changeOpacityOfPlayerLayer(opacity: 0.5) // change opacitiy of player
        
    }
    
    
    // MARK: - Hide mini player buttons
    /// Hides the buttons of mini player
    func hideMiniPlayerButtons() {
        
        self.miniPlayerPlayAndPauseButton.isHidden = true
        self.crossButton.isHidden = true
        
    }
    
    
    // MARK: - Unhide mini player buttons
    /// Unhide Mini Player Buttons
    func unhideMiniPlayerButtons() {
        
        self.miniPlayerPlayAndPauseButton.isHidden = false
        self.crossButton.isHidden = false
        
    }
    
    
    // MARK: - Toggle Pause and Play Button
    /// Convert play button to pause button and vice versa
    func togglePauseAndPlay() {
        
        if isFinishedPlaying {
            
            WorkItemNextVideo?.cancel()
            timer.invalidate()
            
            let startTime = CMTime(seconds: 0, preferredTimescale: 1)
            avPlayer?.seek(to: startTime)
            avPlayer?.play()
            playAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            miniPlayerPlayAndPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            isFinishedPlaying = false
            return
        }
        
        if !isPause {
            avPlayer?.pause()
            
            playAndPauseButton.setImage(UIImage(systemName: playButtonSystemImage), for: .normal)
            miniPlayerPlayAndPauseButton.setImage(UIImage(systemName: playButtonSystemImage), for: .normal)
        }
        else {
            avPlayer?.play()
            
            playAndPauseButton.setImage(UIImage(systemName: pauseButtonSystemImage), for: .normal)
            miniPlayerPlayAndPauseButton.setImage(UIImage(systemName: pauseButtonSystemImage), for: .normal)
        }
        
        isPause = !isPause
        
    }
    
    
    /// Hide buttons after 5 seconds and visible those again after touching the playerView
    /// - Parameter seconds: task will axecute after this time (seconds)
    func hideButtonsAfterCertainTime(seconds: Int) {
        
        workItem?.cancel()
        
        workItem = DispatchWorkItem {
            self.hidePlayerControllers()
            self.changeOpacityOfPlayerLayer(opacity: 1.0)
        }
        
        guard let workItem = workItem else {
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(seconds), execute: workItem)
        
    }
    
    
    /// This function change the current orientation of device
    /// - Parameter orientation: desired orientation
    func changeDeviceOrientation(to orientation: UIDeviceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
    
    
    /// This function sets the duration of the video (slider value) to playerTime label
    func setPlayerTime() {
        let sliderValue = slider.value
        let time = Utils.shared.secondsToHoursMinutesSeconds(Int(sliderValue))
        
        // Player total duration
        let duration = self.avPlayer?.currentItem?.asset.duration
        
        guard let duration = duration else {
            return
        }
        
        let durationInSeconds : Float64 = CMTimeGetSeconds(duration)
        
        let playerTotalTimeInString = Utils.shared.secondsToHoursMinutesSeconds(Int(durationInSeconds))
        
        playerTime.text = time
        playerTotalDuration.text = " /  \(playerTotalTimeInString)"
        
    }
    
    
    /// This change the opacity of player layer
    /// - Parameter opacity: takes the value of opacity
    func changeOpacityOfPlayerLayer(opacity: Float) {
        
        let desiredOpacity: Float = opacity
        
        playerLayer.opacity = desiredOpacity
    }
    
    
    /// This function needs to present the action sheet for iPad
    /// - Parameter sheet: Takes the sheet as parameter
    func iPadActionSheet(sheet: UIAlertController) {
        
        sheet.popoverPresentationController?.sourceView = self.view
        sheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        sheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        
    }
    
    
    // MARK: - This function pause and nil avPlayer. Also remove the avPlayer observer
    func stopPlayerAndPlayerObserver() {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: avPlayer?.currentItem)

        avPlayer?.pause()
        avPlayer = nil
        avPlayer?.replaceCurrentItem(with: nil)

        playerLayer.removeFromSuperlayer()
        playerLayer.player = nil

        avPlayer?.currentItem?.cancelPendingSeeks()
        avPlayer?.currentItem?.asset.cancelLoading()
        
    }
    
    
    func playSelectedVideo(selectedVideo: Int) {
        
        avPlayer?.pause()
        avPlayer?.replaceCurrentItem(with: nil)
        avPlayer = nil
        
        let url = playList?[selectedVideo]
        playVideo(url: url)
        
    }
    
}

/// Extension For Preview
extension AVPlayerManager: SeekPreviewDelegate {
    
    /// Function of SeekPreviewDelegate
    public func getSeekPreview(value: Float) -> UIImage? {

        let close = Utils.shared.getClosestInteger(value: Int(slider.value), arr: Array(images.keys))
        
        guard let close = close else {
            return nil
        }
        
        let image = images[close]

        return image

    }

    /// Generate images according to time
    func generateImages() {
        self.images = [:]
        imageGenerator?.cancelAllCGImageGeneration()
        
        guard let asset = avPlayer?.currentItem?.asset else {
            return
        }

        imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator?.maximumSize = CGSize(width: 150, height: 80)
        let seconds = asset.duration.seconds
        
        var nsValueArray: [NSValue] = []

        for i in 0..<Int(seconds) {
            let time = CMTimeMake(value: Int64(i), timescale: 1)
            let nsValue = NSValue(time: time)
            nsValueArray.append(nsValue)
        }
        
        imageGenerator?.generateCGImagesAsynchronously(forTimes: nsValueArray) { (requestedTime, cgImage, actualTime, result, error) in
            if let image = cgImage {
                DispatchQueue.main.async {
                    self.images[Int(actualTime.seconds)] = UIImage(cgImage: image)
                }
            }
        }
    }

}


/// Extension for set the positions of components of playerView
extension AVPlayerManager {

    // MARK: - Set icons of playAndPauseBtnOutlet
    /// This is a button to pause and play video. This can toggle from pause to play and vice versa
    @objc func playAndPauseVideo() {
        
        togglePauseAndPlay()
    }
    
    
    // MARK: - Forward Skip
    @objc func skipVideoInForward() {
        
        //skipTimeForward(seconds: 10)
        AVPlayerManager.shared.skipTimeForward(seconds: 10, avPlayer: avPlayer ?? AVPlayer())
        setPlayerTime()
        
    }
    
    
    // MARK: - Backward Skip
    @objc func skipVideoInBackward() {
        
        //skipTimeBackward(seconds: 10)
        AVPlayerManager.shared.skipTimeBackward(seconds: 10, avPlayer: avPlayer ?? AVPlayer())
        setPlayerTime()
        
    }
    
    
    // MARK: - Mini Player Button
    @objc func startMiniPlayer() {
        
        UIView.animate(withDuration: 0.3 , animations: {
            if self.isMinimize == false {
                self.hidePlayerControllers()
                self.unhideMiniPlayerButtons()
                self.miniPlayerUIView.isHidden = false
                
                (self.crossButton, self.miniPlayerPlayAndPauseButton) = AVPlayerManager.shared.configureMiniPlayer(
                    view: self.miniPlayerUIView,
                    playerView: self.playerView,
                    playerLayer: self.playerLayer,
                    crossButton: self.crossButton,
                    playAndPauseButtonForMiniPlayer: self.miniPlayerPlayAndPauseButton,
                    minimizedOrigin: self.minimizedOrigin,
                    buttonWidth: Int(self.playAndPauseButton.bounds.width),
                    buttonHeight: Int(self.playAndPauseButton.bounds.height)
                )
                
                self.crossButton.addTarget(self, action:#selector(self.closeMiniPlayer), for: .touchUpInside)
                
                self.miniPlayerPlayAndPauseButton.addTarget(self, action:#selector(self.pauseAndPlayMiniPlayerAction), for: .touchUpInside)
                
                self.isMinimize = true
            }
        })
        
    }
    
    
    // MARK: - Settings button to open Action Sheet
    @objc func settingsToShowActionSheet() {
        
        let settingsTitle = NSLocalizedString("Settings", comment: "")
        let selectAnyMessage = NSLocalizedString("Select any", comment: "")
        
        let alert = UIAlertController(title: settingsTitle, message: selectAnyMessage, preferredStyle: .actionSheet)
        
        if !isLiveStream {
            
            let speedTitle = NSLocalizedString("Speed", comment: "")
            
            alert.addAction(UIAlertAction(title: speedTitle, style: .default , handler:{ _ in
                let speedAlert = ActionSheet.shared.speedActionSheet(avPlayer: self.avPlayer ?? AVPlayer())
                
                //for iPad Support
                self.iPadActionSheet(sheet: speedAlert)
                
                UIApplication.shared.keyWindow?.rootViewController?.present(speedAlert, animated: true, completion: nil)
            }))
        }
        
        let qualityTitle = NSLocalizedString("Quality", comment: "")
        
        alert.addAction(UIAlertAction(title: qualityTitle, style: .default , handler:{ (UIAlertAction)in
            
            let qualityAlert = ActionSheet.shared.qualityActionSheet(avPlayer: self.avPlayer ??  AVPlayer())
            
            //for iPad Support
            self.iPadActionSheet(sheet: qualityAlert)
            
            UIApplication.shared.keyWindow?.rootViewController?.present(qualityAlert, animated: true, completion: nil)
        }))
        
        let shareTitle = NSLocalizedString("Share", comment: "")
        
        alert.addAction(UIAlertAction(title: shareTitle, style: .default , handler:{ (UIAlertAction)in
            
        }))
        
        let reportTitle = NSLocalizedString("Report", comment: "")
        
        alert.addAction(UIAlertAction(title: reportTitle, style: .destructive , handler:{ (UIAlertAction)in
            
        }))
        
        let cancelTitle = NSLocalizedString("Cancel", comment: "")
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        //for iPad Support
        iPadActionSheet(sheet: alert)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Take the video in full screen mode
    /// This is a button and used to enter and exit full screen mode
    @objc func makeVideoFullScreen(_ sender: Any) {
        
        if self.isRotate == false {
            navigationController?.isNavigationBarHidden = true
            enterFullScreen()
            fullScreenButton.setImage(UIImage(systemName: fullScreenButtonLandscapeSystemImage), for: .normal)
            self.miniPlayerButton.isHidden = true
            self.hideMiniPlayerButtons()
        }
        else {
            navigationController?.isNavigationBarHidden = false
            ExitFullScreen()
            fullScreenButton.setImage(UIImage(systemName: fullScreenButtonPortraitSystemImage), for: .normal)
        }
        
    }
    
    
    @objc func playNextVideo() {
        
        guard let playList = playList else {
            return
        }
        
        if selectedVideo < playList.count - 1 {
            selectedVideo += 1
            
            playSelectedVideo(selectedVideo: selectedVideo)
            previousVideoButton.isEnabled = true
            
        }
        
        if selectedVideo == playList.count - 1 {
            nextVideoButton.isEnabled = false
        }
        
        
    }
    
    
    @objc func playPreviousVideo() {
        
        if selectedVideo > 0 {
            selectedVideo -= 1
            
            playSelectedVideo(selectedVideo: selectedVideo)
            nextVideoButton.isEnabled = true
        }
        
        if selectedVideo == 0 {
            previousVideoButton.isEnabled = false
        }
        
    }
    
    
    // MARK: - Set the position of all the components of playerView
    func allComponentsOfPlayerView() {
        
        avPlayerUIDesignManager.setPositionPlayerView(view: view, navigationController: navigationController)
        
        playAndPauseButton = avPlayerUIDesignManager.setPositionPlayAndPauseButton()
        
        forwardSkipButton = avPlayerUIDesignManager.setPositionForwardSkipButton()
        
        backwardSkipButton = avPlayerUIDesignManager.setPositionBackwardSkipButton()
        
        avPlayerUIDesignManager.setPositionActivityIndicator(color: UIColor.red)
        
        miniPlayerButton = avPlayerUIDesignManager.setPositionMiniPlayerButtonOutlet()
        
        settingButton = avPlayerUIDesignManager.setPositionSettingButtonOutlet()
        
        avPlayerUIDesignManager.setPositionProgressView()
        
        fullScreenButton = avPlayerUIDesignManager.setPositionFullScreenButtonOutlet(isLiveStream: isLiveStream)
        
        avPlayerUIDesignManager.setPositionSlider(
            minimumTrackTintColor: UIColor.red,
            maximumTrackTintColor: UIColor.systemGray,
            thumbTintColor: UIColor.red
        )
        
        avPlayerUIDesignManager.setPositionPlayerTime()
        
        avPlayerUIDesignManager.setPositionPlayerTotalDuration()
        
        avPlayerUIDesignManager.setPositionLiveStack()
        
        nextVideoButton = avPlayerUIDesignManager.setPositionNextVideoButton()

        previousVideoButton = avPlayerUIDesignManager.setPositionPreviousVideoButton()
        

        playAndPauseButton.addTarget(self, action: #selector(playAndPauseVideo), for: .touchUpInside)
        
        forwardSkipButton.addTarget(self, action: #selector(skipVideoInForward), for: .touchUpInside)
        
        backwardSkipButton.addTarget(self, action: #selector(skipVideoInBackward), for: .touchUpInside)
        
        miniPlayerButton.addTarget(self, action: #selector(startMiniPlayer), for: .touchUpInside)
        
        settingButton.addTarget(self, action: #selector(settingsToShowActionSheet), for: .touchUpInside)
        
        fullScreenButton.addTarget(self, action: #selector(makeVideoFullScreen), for: .touchUpInside)
        
        nextVideoButton.addTarget(self, action: #selector(playNextVideo), for: .touchUpInside)
        
        previousVideoButton.addTarget(self, action: #selector(playPreviousVideo), for: .touchUpInside)
        
    }

}


/// Extension for UINavigationControllerDelegate
extension AVPlayerManager: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let previousViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
           !navigationController.viewControllers.contains(previousViewController) {
            // The previous view controller is not in the navigation stack anymore.
            // You can perform any cleanup or deallocation tasks here.
            
            stopPlayerAndPlayerObserver()
            NotificationCenter.default.removeObserver(self)

            // For example, you could call a deinitializer or release resources.
            previousViewController.removeFromParent()
            debugPrint("Go Back To Home")
            
        }
    }
    
}
