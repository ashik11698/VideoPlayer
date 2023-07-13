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
            - [X] Checkbox checked Play/Resume
            - [X] Checkbox checked Pause
            - [X] Checkbox checked Full screen mode using button
            - [X] Checkbox checked Full screen in landscape
            - [X] Checkbox checked Buffer indicator
            - [X] Checkbox checked Settings: 
                - [X] Speed
                - [] Qaulity
                - [] Share
                - [] Report
            - [X] Checkbox checked Slider
            - [X] Checkbox checked Total duration
            - [X] Checkbox checked Live timer
            - [X] Checkbox checked Preview
            - [X] Checkbox checked Backward skipping 
            - [X] Checkbox checked Forward skipping
            - [X] Checkbox checked Play next Video
            - [X] Checkbox checked Play previous Video
            - [X] Checkbox checked Mini Player
                - [X] Checkbox checked Revert to original by touching the player
                - [X] Checkbox checked Pause
                - [X] Checkbox checked Cancel
            - [X] Checkbox checked Visible buttons when touch the player and invisible buttons after 5 seconds of last touch
    

### Sample code of using this library is given below:

<-------------------------->

import VideoPlayer

let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false)
        
view.addSubview(avPlayerManager)
        
avPlayerManager.setUpPlayer()

<-------------------------->
