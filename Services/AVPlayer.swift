//
//  AVPlayer.swift
//  parse
//
//  Created by Антон Павлов on 02.05.2023.
//

import Foundation
import AVKit
import AVFoundation

// MARK: - AVPlayer Properties
let avPlayerViewController = AVPlayerViewController()
var avPlayer: AVPlayer?
let movieUrl: NSURL? = NSURL(string: "http://techslides.com/demos/sample-videos/small.mp4")

// MARK: - Запуск видео
func startVideo() {
    if let url = movieUrl {
        avPlayer = AVPlayer(url: url as URL)
        avPlayerViewController.player = avPlayer
        avPlayerViewController.player?.play()
    }
}
