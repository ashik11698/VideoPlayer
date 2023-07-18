//
//  Urls.swift
//  AVPlayerDemo
//
//  Created by Md. Ashikur Rahman on 12/6/23.
//  Copyright © 2023 BJIT Ltd. All rights reserved.
//

import Foundation

public struct Urls {
    
    /// Video From Online
    public static let BigBuckBunny = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
    
    /// Video of m3u8
    public static let m3u8Video1 = URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2023/10187/5/1D820D6D-4F01-48EB-8F22-901F4A4B69FE/cmaf.m3u8")
    
    /// Video of m3u8
    public static let m3u8Video2 = URL(string: "https://devstreaming-cdn.apple.com/videos/wwdc/2023/10078/5/A2493B0B-6540-4634-B38C-E2FEFC0F8DAC/cmaf/hvc/2160p_11600/hvc_2160p_11600.m3u8")
    
    public static let m3u8Video3 = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_fmp4/master.m3u8")
    
    public static let m3u8Video4 = URL(string: "https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8")
    
    public static let m3u8Video5 = URL(string: "http://amssamples.streaming.mediaservices.windows.net/69fbaeba-8e92-4740-aedc-ce09ae945073/AzurePromo.ism/manifest(format=m3u8-aapl)")
    
    public static let m3u8Video6 = URL(string: "http://amssamples.streaming.mediaservices.windows.net/634cd01c-6822-4630-8444-8dd6279f94c6/CaminandesLlamaDrama4K.ism/manifest(format=m3u8-aapl)")
}
