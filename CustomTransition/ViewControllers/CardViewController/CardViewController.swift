//
//  CardViewController.swift
//  CustomTransition
//
//  Created by Damir L on 12.06.2021.
//

import UIKit

class CardViewController: UIViewController {
    
    static let cardCornerRadius: CGFloat = 25
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var pageIndex: Int?
    var petCard: Riddle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = petCard?.description
        cardView.layer.cornerRadius = CardViewController.cardCornerRadius
        cardView.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segueIdentifier(for: segue) == .reveal,
           let destinationViewController = segue.destination as? RevealViewController {
            destinationViewController.petCard = petCard
        }
    }
    
    @IBAction func handleTap() {
        performSegue(withIdentifier: .reveal, sender: nil)
    }
}

extension CardViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case reveal
    }
}
