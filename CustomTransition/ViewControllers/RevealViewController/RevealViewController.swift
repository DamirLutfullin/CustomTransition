//
//  RevealViewController.swift
//  CustomTransition
//
//  Created by Damir L on 12.06.2021.
//

import UIKit

class RevealViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var swipeInteractionController: SwipeInteractionController?
    
    var petCard: Riddle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = petCard?.name
        imageView.image = UIImage(named: petCard!.imageName)!
        swipeInteractionController = SwipeInteractionController(viewController: self)
    }
    
    @IBAction func dismissPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

