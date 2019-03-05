//
//  ViewController.swift
//  InteractiveStory
//
//  Created by Kristopher Valas on 10/22/18.
//  Copyright © 2019 Kristopher Valas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var nameFieldBottomConstraint: NSLayoutConstraint!
    
    
    //Adds a notification obserserver to handle displaying/hiding of the keyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow(_:)), name:  UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    //Prepares the next view controller, providing it the users name and the first page of the story
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        do {
            if let name = nameLabel.text {
                if name == "" {
                    throw AdventureError.nameNotProvided
                }else {
                    if segue.identifier == "startAdventure" {
                        guard let pageController = segue.destination as? PageController else { return}
                        let firstPage = Adventure.Story(name: name)
                        pageController.page = firstPage
                    }
                }
                

            }
            
        }catch AdventureError.nameNotProvided {
            alertUser(title: "Please enter a name!")
        }catch let error {
            alertUser(title: "Default Error")
        }
        

    }
    
    
    
    //MARK: - Keyboard methods to handle changes of UILayout when the keyboard is presented/dismissed
    @objc func KeyboardWillShow(_ notification: NSNotification) {
        
       
        if let info = notification.userInfo, let keyboardframe = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = keyboardframe.cgRectValue
            nameFieldBottomConstraint.constant = frame.size.height/2 + 35
            
            UIView.animate(withDuration: 0.8) {
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
    
        nameFieldBottomConstraint.constant = 25
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    //MARK: - User alert
    func alertUser(title: String, message: String? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    
        self.present(alertVC, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

//MARK: - Resign first responder
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
