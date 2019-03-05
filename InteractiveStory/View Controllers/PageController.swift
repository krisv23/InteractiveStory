//
//  PageController.swift
//  InteractiveStory
//
//  Created by Kristopher Valas on 10/25/18.
//  Copyright © 2019 Kristopher Valas. All rights reserved.
//

import UIKit


//Formats a string to have increased line spacing

extension Story {
    func attributedString(withName name: String)  -> NSAttributedString {
        
        let attributedString = NSMutableAttributedString(string: text(withName: name))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: attributedString.stringRange)
        
        return attributedString
    }
}

extension NSAttributedString {
    var stringRange : NSRange {
        return NSMakeRange(0, self.length)
    }
}

//Returns an attirbuted string
extension StoryPage {
    func attributed(isSet set: Bool) -> NSAttributedString {
        if (set){
            return self.storyItem.attributedString(withName: self.name!)
        }
        return NSAttributedString(string: self.storyItem.text(withName: self.name!))
    }
}


class PageController: UIViewController {

    var page : StoryPage?
    let soudEffectsPlayer = SoundEffectsPlayer()
    
    //MARK: - User Interface Properties
    
    lazy var artworkImage : UIImageView = {
        let art = UIImageView()
        art.translatesAutoresizingMaskIntoConstraints = false
        art.image = page?.storyItem.art
        return art
    }()
    
    lazy var storyLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = page?.attributed(isSet: true)
        return label
    }()
    
    lazy var buttonA : UIButton = {
        let button = UIButton(type: .system)
        let title = page?.nextChoiceA?.title ?? "Play Again"
        let selector = page?.nextChoiceA?.title != nil  ? #selector(PageController.loadFirstChoice) : #selector(PageController.playAgain)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        return button
    }()
    lazy var buttonB : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(page?.nextChoiceB?.title, for: .normal)
        button.addTarget(self, action: #selector(PageController.loadSecondChoice), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    //Initializer method for a new page
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(page: StoryPage) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    //MARK: - Add constraints and align views
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        view.addSubview(artworkImage)
        view.addSubview(storyLabel)
        view.addSubview(buttonA)
        view.addSubview(buttonB)
        
        NSLayoutConstraint.activate([
                artworkImage.topAnchor.constraint(equalTo: view.topAnchor),
                artworkImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                artworkImage.leftAnchor.constraint(equalTo: view.leftAnchor),
                artworkImage.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
        
        NSLayoutConstraint.activate([
                storyLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -48.00),
                storyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.00),
                storyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.00)
    ])
        
        NSLayoutConstraint.activate([
                buttonA.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonA.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.00)

            ])
        
        NSLayoutConstraint.activate([
                buttonB.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonB.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.00)
            ])
  }
    
    
    //MARK: - Action methods based on button selection. Pushes a new view controller onto the scene.
    @objc func loadFirstChoice() {
        if let page = page, let firstChoice = page.nextChoiceA {
            let newPage = firstChoice.page
            let pageController = PageController(page: newPage)
            
            soudEffectsPlayer.playsound(for: page.storyItem)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    @objc func loadSecondChoice() {
        if let page = page, let secondChoice = page.nextChoiceB {
            let newPage = secondChoice.page
            let pageController = PageController(page: newPage)
           
            soudEffectsPlayer.playsound(for: page.storyItem)
            
            navigationController?.pushViewController(pageController, animated: true)
        }
    }
    
    //Action method to pop to root
    @objc func playAgain() {
        navigationController?.popToRootViewController(animated: true)
    }
}
