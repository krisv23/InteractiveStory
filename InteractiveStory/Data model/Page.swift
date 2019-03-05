//
//  Page.swift
//  InteractiveStory
//
//  Created by Kristopher Valas on 10/25/18.
//  Copyright © 2019 Kristopher Valas. All rights reserved.
//

import Foundation
import UIKit

enum AdventureError : Error {
    case nameNotProvided
}

//Page model responsible for handling choice selection and maintaining a link to the next pages in the story
class StoryPage {

    var nextChoiceA: Choice?
    var nextChoiceB: Choice?
    let storyItem: Story
    var name : String?
    
    typealias Choice = (title : String, page : StoryPage)
    
    init(with storyItem: Story) {
        self.storyItem = storyItem
    }
}

extension StoryPage {
    
    func addChoiceWith(title: String, storyItem : Story) -> StoryPage {
        let newPage = StoryPage(with: storyItem)
        newPage.name = name
        return addChoiceWith(title: title, page: newPage)
    }
    
    func addChoiceWith(title: String, page: StoryPage) -> StoryPage {
        
        switch (nextChoiceA, nextChoiceB) {
            case (.some, .some): return self
            case (.none, .none), (.none, .some): nextChoiceA = (title, page)
            case (.some, .none): nextChoiceB = (title, page)
        }
        return page
    }
    
}
