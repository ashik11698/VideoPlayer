# VideoPlayer

This is a library of custom video player for iOS devices. This provides services for both live stream and pre-recorded videos. 

## Features:
### For Live Stream:
- [X] Play/Resume
- [X] Pause
- [X] Full screen mode using button
- [X] Full screen in landscape
- [X] Buffer indicator
- [X] Settings: 
    - [ ] Qaulity
    - [ ] Share
    - [ ] Report
- [X] Play next Video
- [X] Play previous Video
- [X] Mini Player
    - [X] Revert to original by touching the player
    - [X] Pause
    - [X] CCancel
- [X] Visible buttons when touch the player and invisible buttons after 5 seconds of last touch
        
### For Pre-recorded Videos:
- [X] Play/Resume
- [X] Pause
- [X] Full screen mode using button
- [X] Full screen in landscape
- [X] Buffer indicator
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
- [X] Play next Video
- [X] Play previous Video
- [X] Mini Player
    - [X] Revert to original by touching the player
    - [X] Pause
    - [X] Cancel
- [X] Visible buttons when touch the player and invisible buttons after 5 seconds of last touch


## Installation
- 1. In Xcode, select your project in the Project Editor
- 2. Go to the Package Dependencies tab
- 3. press the + button
- 4. Enter the Package URL: https://github.com/ashik11698/VideoPlayer.git
- 5. Select 'VideoPlayer'and press add package.

#### Or,
- 1. In Xcode, go to File
- 2. Click on 'Add Packages...'
- 3. Enter the Package URL: https://github.com/ashik11698/VideoPlayer.git
- 4. Select 'VideoPlayer'and press add package.


## Import

```
import VideoPlayer
```

## How to use
initialize the AVPlayerManager with following parameters
- navigationController: This is optional. If there isn't any navigationController, then pass nil instead of it.
- view: Pass the view(UIView), where the player will be placed. 
- isLiveStream: This is boolean. Pass 'true' if it is a live stream, else pass 'false' if it is pre-recorded video.

```
let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false)
```

Or,
let avPlayerManager = AVPlayerManager(navigationController: nil, view: view, isLiveStream: false)
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
