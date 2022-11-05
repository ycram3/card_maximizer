//
//  ViewController.swift
//  card_maximizer
//
//  Created by JPL-ST-SPRING2022 on 11/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var responseFromGoogle: String = "restaurant"
    
    var storeType = ["restaurant","grocery","gas"] //needs to pass the store type from maps

    func getCategory(storeType: [String]) -> String{
        var category : String = "Unknown"
        var n = 0
        for _ in storeType {
            if storeType[n] == responseFromGoogle {
                category = "dining"
            }
            n = n + 1
        }
        print("Inside getCategory ",category)
        return category
    }
    
    lazy var storeCategory: String = getCategory(storeType: storeType)

    @IBOutlet weak var creditCard: UILabel!
    
    @IBAction func confirmStore(_ sender: UIButton) {
        showTheCardToBeUsed(storeCategory: storeCategory)
    }
    
    
    func showTheCardToBeUsed(storeCategory: String){
        switch storeCategory{
        case "dining": creditCard.text = "Discover"
            default:
                print("I am here instead")
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

