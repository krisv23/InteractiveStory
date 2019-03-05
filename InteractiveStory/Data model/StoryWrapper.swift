//
//  StoryWrapper.swift
//  InteractiveStory
//
//  Created by Kristopher Valas on 10/22/18.
//  Copyright © 2019 Kristopher Valas. All rights reserved.
//

import Foundation

//Creates the adventure, linking the story and the page together.
struct Adventure {
    
    static func Story(name : String) ->  StoryPage {
        
        let returnTrip = StoryPage(with: .ReturnTrip)
        returnTrip.name = name
        
        let touchDown = returnTrip.addChoiceWith(title: "Stop and Investigate", storyItem: .TouchDown)
        let homeward = returnTrip.addChoiceWith(title: "Continue home to earth", storyItem: .Homeward)
        
        let rover = touchDown.addChoiceWith(title: "Explore the Rover", storyItem: .Rover)
        let crate = touchDown.addChoiceWith(title: "Open the Crate", storyItem: .Crate)
        
        homeward.addChoiceWith(title: "Head back to Mars", storyItem: .TouchDown)
        let home = homeward.addChoiceWith(title: "Continue home to Earth", storyItem: .Home)
        
        let cave = rover.addChoiceWith(title: "Explore the Coordinate", storyItem: .Cave)
        rover.addChoiceWith(title: "Return to Earth", storyItem: .Home)
        
        cave.addChoiceWith(title: "Continue towards the faint light", storyItem: .Droid)
        cave.addChoiceWith(title: "Refill the ship and explore the rover", storyItem: .Rover)
        
        crate.addChoiceWith(title: "Explore the rover", storyItem: .Rover)
        crate.addChoiceWith(title: "Use the Key", storyItem: .Monster)
        
        return returnTrip
    }
    
}
