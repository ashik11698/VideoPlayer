# VideoPlayer

A description of this package.

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
####Or,
- 1. In Xcode, go to File
- 2. Click on 'Add Packages...'
- 3. Enter the Package URL: https://github.com/ashik11698/VideoPlayer.git
- 4. Select 'VideoPlayer'and press add package.


## Import

```
import VideoPlayer
```

    

### Sample code of using this library:

```
import VideoPlayer

let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false)
        
view.addSubview(avPlayerManager)
        
avPlayerManager.setUpPlayer()
```
