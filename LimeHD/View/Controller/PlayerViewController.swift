//
//  PlayerViewController.swift
//  LimeHD
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import AVKit

final class PlayerViewController: AVPlayerViewController {
    
    // MARK: - Private Properties 
    
    private var url: URL
    private let avPlayer = AVPlayer()
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVideoAsset()
    }
    
    // MARK: - Private Methods
    
    private func setVideoAsset() {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        playerItem.preferredPeakBitRate = .greatestFiniteMagnitude
        avPlayer.replaceCurrentItem(with: playerItem)
        player = avPlayer
        entersFullScreenWhenPlaybackBegins = true
        player?.play()
    }
}
