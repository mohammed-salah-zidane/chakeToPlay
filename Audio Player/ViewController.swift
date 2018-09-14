//
//  ViewController.swift
//  Audio Player
//
//  Created by Mohamed Salah Zidane on 8/1/18.
//  Copyright © 2018 Mohamed Salah Zidane. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    var isPlaying = 1
    var audioPath :String = ""
    var player = AVAudioPlayer()
    var timer = Timer()
    
    @IBOutlet var slider: UISlider!
    
    
    @IBOutlet var songLbl: UILabel!
    @IBOutlet var plSlider: UISlider!
   
    @objc func updateSlider(){
        plSlider.value = Float(player.currentTime)
    
    }
    @IBAction func playingSlider(_ sender: Any) {
        
        player.currentTime = TimeInterval(plSlider.value)
    }
    @IBAction func sliderBtn(_ sender: AnyObject) {
        if activeSong != -1 && selectedSong != ""{
        player.volume = slider.value
        }
    }
    
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake && isPlaying == 1{
            
               
                if activeSong != -1 && selectedSong != ""{
                    player.play()
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
                }
                isPlaying = 2
            
            
            } else if event?.subtype == UIEventSubtype.motionShake && isPlaying == 2 {
            if activeSong != -1 && selectedSong != ""{
                player.pause()
                timer.invalidate()
            }
            isPlaying = 1
        }
        /*if event?.subtype == UIEventSubtype.motionShake {
            if activeSong != -1 && selectedSong != ""{
                timer.invalidate()
                player.stop()
                if activeSong != -1 && selectedSong != ""{
                    do {
                        try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                    }catch{
                        
                    }
                }
            }
        }
        */
    }
    @IBAction func stopBtn(_ sender: AnyObject) {
        if activeSong != -1 && selectedSong != ""{
        timer.invalidate()
        player.stop()
        if activeSong != -1 && selectedSong != ""{
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
        }catch{
            
        }
        }
    }
    }
    @IBAction func playBtn(_ sender: UIBarButtonItem) {
        if activeSong != -1 && selectedSong != ""{
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
    }
    }
    @IBAction func pauseBtn(_ sender: UIBarButtonItem) {
        if activeSong != -1 && selectedSong != ""{
        player.pause()
        timer.invalidate()
    }
    }

    @objc func playSwipeRight(gesture: UIGestureRecognizer){
        print("right")
        if activeSong != -1 && selectedSong != ""{
            player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
        }
        
    }
    @objc func  pauseSwipeLeft (gesturer : UIGestureRecognizer){
        if activeSong != -1 && selectedSong != ""{
            player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateSlider), userInfo: nil, repeats: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        
        if activeSong != -1 && selectedSong != ""{
            
            
            
            songLbl.text = selectedSong + ".mp3"
            audioPath = Bundle.main.path(forResource: selectedSong , ofType: "mp3")!
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.playSwipeRight(gesture:)))
            swipeRight.direction = UISwipeGestureRecognizerDirection.right
            self.view.addGestureRecognizer(swipeRight)
           
            let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.pauseSwipeLeft(gesturer:)))
            swipeLeft.direction = UISwipeGestureRecognizerDirection.left
            self.view.addGestureRecognizer(swipeLeft)
            
        do {
             try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
    
            plSlider.maximumValue = Float(player.duration)
        }catch{
            
        }
        
      }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidDisappear(_ animated: Bool) {
        if activeSong != -1  && selectedSong != ""{
            timer.invalidate()
            player.stop()

            do {
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }catch{
                
            }
        }
    }
}

