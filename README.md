# VideoPlayer

This is a library of custom video player for iOS applications. This provides services for both live stream and VOD. 

## Features:
### For Live Stream:
- [X] Play/Resume
- [X] Pause
- [X] Full screen mode using button
- [X] Full screen in landscape
- [X] Buffer indicator
- [X] Check internet connection
- [X] Settings: 
    - [ ] Qaulity
    - [ ] Share
    - [ ] Report
- [X] Repeat/Replay
- [X] Autoplay
- [X] Play next Video
- [X] Play previous Video
- [X] Mini Player
    - [X] Revert to original by touching the player
    - [X] Pause
    - [X] Cancel
- [X] Visible buttons when touch the player and invisible buttons after 5 seconds of last touch
        
### For Pre-recorded Videos:
- [X] Play/Resume
- [X] Pause
- [X] Full screen mode using button
- [X] Full screen in landscape
- [X] Buffer indicator
- [X] Check internet connection
- [X] Settings: 
    - [X] Speed
    - [ ] Qaulity
    - [ ] Share
    - [ ] Report
- [X] Slider
- [X] Total duration
- [X] Live timer
- [X] Preview
- [X] Backward skipping 
- [X] Forward skipping
- [X] Repeat/Replay
- [X] Autoplay
- [X] Play next Video
- [X] Play previous Video
- [X] Mini Player
    - [X] Revert to original by touching the player
    - [X] Pause
    - [X] Cancel
- [X] Visible buttons when touch the player and invisible buttons after 5 seconds of last touch


## Installation
- In Xcode, select your project in the Project Editor
- Go to the Package Dependencies tab
- press the + button
- Enter the Package URL: https://github.com/ashik11698/VideoPlayer.git
- Select 'VideoPlayer'and press add package.

#### Or,
- In Xcode, go to File
- Click on 'Add Packages...'
- Enter the Package URL: https://github.com/ashik11698/VideoPlayer.git
- Select 'VideoPlayer'and press add package.


## Import

```
import VideoPlayer
```

## How to use
initialize the AVPlayerManager with following parameters
- navigationController: This is optional. If there isn't any navigationController, then pass nil instead of it.
- view: Pass the view(UIView), where the player will be placed. 
- isLiveStream: This is boolean. Pass 'true' if it is a live stream, else pass 'false' if it is pre-recorded video.
- isAutoPlayOn: This is boolean. Pass 'true' to turn on autoPlay and pass 'false' to turn off autoPlay.
- playList: This is a list of urls, which will be played by the player. This is optional. User can send their own playList [URL?]. Avoid this parameter if there is no playList, player will play the default playList in that case. 

```
let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false, isAutoPlayOn: false)
```

Or,

```
let avPlayerManager = AVPlayerManager(navigationController: nil, view: view, isLiveStream: false, isAutoPlayOn: true)
```

Or,

```
let playList = [Urls.m3u8Video1, Urls.m3u8Video2, Urls.m3u8Video3]

let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false, isAutoPlayOn: true, playList: playList)
```

Add the initialized constant/variable as a subview of the view the player will be visible.

```
view.addSubview(avPlayerManager)
```

Call the 'setUpPlayer' method/function to configure all the things and play the video. 

```
avPlayerManager.setUpPlayer()
```


## Sample code of using this library

```
import VideoPlayer

let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false)
        
view.addSubview(avPlayerManager)
        
avPlayerManager.setUpPlayer()
```

Or,

```
import VideoPlayer

let playList = [Urls.m3u8Video1, Urls.m3u8Video2, Urls.m3u8Video3]

let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false, playList: playList)
        
view.addSubview(avPlayerManager)
        
avPlayerManager.setUpPlayer()
```

## Open Source Used:

- SeekPreview (github Link: https://github.com/Enricoza/SeekPreview.git)
- Reachability (github Link: https://github.com/ashleymills/Reachability.swift)

