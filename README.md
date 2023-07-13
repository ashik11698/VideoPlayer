# VideoPlayer

A description of this package.

## Features:
    ###[x] For Live Stream:
        [x] Play/Resume
        [x] Pause
        [x] Full screen mode using button
        [x] Full screen in landscape
        [x] Buffer indicator
        [x] Settings: 
            [x] Qaulity
            [x] Share
            [x] Report
        [x] Play next Video
        [x] Play previous Video
        [x] Mini Player
            [x] Revert to original by touching the player
            [x] Pause
            [x] Cancel
        [x] Visible buttons when touch the player and invisible buttons after 5 seconds of last touch
        
    ###[x] For Pre-recorded Videos:
        [x] Play/Resume
        [x] Pause
        [x] Full screen mode using button
        [x] Full screen in landscape
        [x] Buffer indicator
        [x] Settings: 
            [x] Speed
            [x] Qaulity
            [x] Share
            [x] Report
        [x] Slider
        [x] Total duration
        [x] Live timer
        [x] Preview
        [x] Backward skipping 
        [x] Forward skipping
        [x] Play next Video
        [x] Play previous Video
        [x] Mini Player
            [x] Revert to original by touching the player
            [x] Pause
            [x] Cancel
            [x] Visible buttons when touch the player and invisible buttons after 5 seconds of last touch
    

### Sample code of using this library is given below:

<-------------------------->

import VideoPlayer

let avPlayerManager = AVPlayerManager(navigationController: navigationController, view: view, isLiveStream: false)
        
view.addSubview(avPlayerManager)
        
avPlayerManager.setUpPlayer()

<-------------------------->
