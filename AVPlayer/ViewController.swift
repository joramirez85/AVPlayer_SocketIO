//
//  ViewController.swift
//  AVPlayer
//
//  Created by Jesus Ramirez on 9/4/18.
//  Copyright © 2018 Jesus Ramirez. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import SocketIO

class ViewController: UIViewController {
    
    var playerViewController=AVPlayerViewController()
    var playerView = AVPlayer()
    var playerItem:AVPlayerItem?
    
    let manager = SocketManager(socketURL: URL(string: "http://localhost:3000")!,config: [.log(true),.connectParams(["token": "ABC438s"])])
    
    var socket:SocketIOClient!
    
    override func viewDidAppear(_ animated: Bool) {
        // playVideo()
    }
    
    func playVideo() {
        print("play video function")
        // Using Local File
        let fileURL = Bundle.main.url(forResource:"SampleVideo", withExtension: "mp4")
        // Using web URL
        // let fileURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        playerView = AVPlayer(url: fileURL!)
        playerViewController.player = playerView
        playerViewController.showsPlaybackControls = false
        self.present(playerViewController,animated: true){
            self.playerViewController.player?.play()
        }
    }
    
    func playVideoFrame() {
        print("play video function")
        // Using Local File
        let fileURL = Bundle.main.url(forResource:"SampleVideo", withExtension: "mp4")
        playerItem = AVPlayerItem(url: fileURL!)
        playerView = AVPlayer(playerItem: playerItem)
        let playerLayer=AVPlayerLayer(player: playerView)
        playerLayer.frame=CGRect(x:0, y:0, width:100, height:100)
        self.view.layer.addSublayer(playerLayer)
        playerView.play()
        
        // playerViewController.player = playerView
        // playerViewController.showsPlaybackControls = false
        /* self.present(playerViewController,animated: true){
            self.playerViewController.player?.play()
        } */
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.socket = manager.defaultSocket;
        self.setSocketEvents();
        self.socket.connect();
    }

    private func setSocketEvents()
    {
        self.socket.on(clientEvent: .connect) {data, ack in
            print("socket connected :)");
        }
        
        self.socket.on("play_video") {data, ack in
            print("play video...")
            //self.playVideoFrame()
            self.playVideo()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

