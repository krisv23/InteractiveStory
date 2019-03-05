//
//  Audio.swift
//  InteractiveStory
//
//  Created by Kristopher Valas on 11/1/18.
//  Copyright © 2019 Kristopher Valas. All rights reserved.
//

import Foundation
import AudioToolbox


//Extends the story class to include audio functionality. 
extension Story {
    
    var soundEffectName : String {
        switch self {
        case .Homeward, .Droid: return "HappyEnding"
        case .Monster: return "Ominous"
        default: return "PageTurn"
        }
    }
    
    var soundEffectURL: URL {
        let path = Bundle.main.path(forResource: soundEffectName, ofType: "wav")!
        return URL(fileURLWithPath: path)
    }
}

class SoundEffectsPlayer {
    var sound: SystemSoundID = 0
    
    func playsound(for story: Story){
        let soundURL = story.soundEffectURL as CFURL
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}
