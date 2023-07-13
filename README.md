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
    

### Sample code of using this library is given below:

```
import VideoPlayer

let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false)
        
view.addSubview(avPlayerManager)
        
avPlayerManager.setUpPlayer()
```
