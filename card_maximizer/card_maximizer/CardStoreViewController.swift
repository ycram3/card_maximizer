//
//  CardStore.swift
//  card_maximizer
//
//  Created by Marcello Rusciano on 11/29/22.
//

import Foundation
import UIKit

protocol bob{
}

class CardStoreViewController: UIViewController{
    var delegate: bob?
    
    @IBOutlet weak var scroll: UIScrollView!
    
    let scrollView = UIScrollView()
    let imageStackView = UIStackView()
    //let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        //label.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.axis = .vertical

        view.addSubview(scrollView)
        scrollView.addSubview(imageStackView)
        //scrollView.addSubview(label)
        var i = 0

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            imageStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            imageStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            imageStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            /*
            label.topAnchor.constraint(equalTo: scrollView.topAnchor),
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
            */
            
        ])

        let storingCards = ["ame","Bofa","Capitol","Chse","discover_it_cash_back","Well"]

        for _ in storingCards {
            let imageView = UIImageView(image: UIImage(named: storingCards[i]))
            imageView.contentMode = .scaleAspectFit
            imageStackView.addArrangedSubview(imageView)
            imageStackView.spacing = 100

            //imageView.addSubview(label)
            //label.textColor = .black
            //label.text = storingCards[i]
            i+=1
        }
    }
//    If no card is stored display a message "No card has been added yet"
    
    func addCard(){
//        only add the last 4 digits of the card
        
//        input with only 4 possible numbers
        
//        choose the among: Amex, Discover, Chase, BofA, Capitol One and Wells Fargo
    }
    
    func deleteCard(){
//        deliting the cards
    }
    
    func updateCard(){
//        change the cards
    }
    
}

