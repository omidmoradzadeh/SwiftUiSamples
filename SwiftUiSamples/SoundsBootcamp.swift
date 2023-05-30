//
//  SoundsBootcamp.swift
//  SwiftUiSamples
//
//  Created by Omid on 30.05.2023.
//

import SwiftUI
import AVKit

class SoundManger {
    
    // single ton calss
    static let instance = SoundManger()
    var player : AVAudioPlayer?
    
    enum soundOption : String{
        case tada
        case badum
    }
    
    
    func playSound( sound : soundOption){
        
        // guard let url = URL(string: "") else { return }
        
        guard let url = Bundle.main.url(
            forResource: sound.rawValue,
            withExtension: ".mp3"
        ) else { return }
        
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }
        catch let error{
            print("Error in playing sound \(error.localizedDescription)")
        }
    }
}

struct SoundsBootcamp: View {
    
    var soundManager : SoundManger = SoundManger()
    
    var body: some View {
        VStack(spacing: 40){
            Button("Play Sound 1") {
                soundManager.playSound(sound: .badum)
            }
            
            Button("Play Sound 2") {
                soundManager.playSound(sound: .tada)
            }
        }
    }
}

struct SoundsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SoundsBootcamp()
    }
}
