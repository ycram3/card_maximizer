//
//  ViewController.swift
//  card_maximizer
//
//  Created by Marcello Rusciano on 11/4/22.
//

import UIKit
import GooglePlaces
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    private var placesClient: GMSPlacesClient!
    
    lazy var responseFromGoogle: String = "bakery"
    
    lazy var storeCategory: String = getCategory()
    
    @IBOutlet weak var creditCardNumber: UILabel!

    @IBOutlet weak var creditCard: UILabel!
    
    @IBOutlet private var storeName: UIButton!
    
    @IBOutlet weak var storeAddress: UILabel!
    
    @IBAction func confirmStore(_ sender: UIButton) {
        showTheCardToBeUsed(storeCategory: storeCategory)
        sender.backgroundColor = UIColor.green
        storeName.setTitle("Pizzeria Marcello", for: .normal)
        //print(nameOfStore)
    }

    @IBAction func getCurrentPlace(_ sender: UIButton) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress]
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: placeFields) { [weak self] (placeLikelihoods, error) in
          guard let strongSelf = self else {
            return
          }

          guard error == nil else {
            print("Current place error: \(error?.localizedDescription ?? "")")
            return
          }

          guard let place = placeLikelihoods?.first?.place else {
            strongSelf.storeName.setTitle("No current place", for: .normal)
            strongSelf.storeAddress.text = ""
            return
          }

            strongSelf.storeName.setTitle(place.name , for: .normal)
            strongSelf.storeAddress.text = place.formattedAddress
            print(place.formattedAddress)
            print(place.name)
        }
    }
    
    
    var dict = ["amusement_park":"entertainment",
                "aquarium":"entertainment",
                "bakery":"dining",
                "bar":"dining",
                "bowling_alley":"entertainment",
                "cafe":"dining",
                "car_rental":"travel",
                "gas_station":"gas",
                "museum":"entertainment",
                "night_club":"dining",
                "restaurant":"dining",
                "supermarket":"grocery",
                "tourist_attraction":"entertainment",
                "zoo":"entertainment"]

    func getCategory() -> String {
        var category : String = "Unknown"
        for key in dict.keys{
            if responseFromGoogle == key{
               category = dict[key]!
            }
        }
        return category
    }
    
    func showTheCardToBeUsed(storeCategory: String){
        switch storeCategory{
        case "dining": creditCard.text = "Discover"; creditCardNumber.text = "6011 0009 9013 9424"
        case "entertainment": creditCard.text = "Chase"
        case "travel": creditCard.text = "Amex"
        case "gas": creditCard.text = "Bank of America"
        case "grocery": creditCard.text = "Capitol One"
            default: creditCard.text = "Wells Fargo"
                print("I am here instead")
        }
    }

    override func viewDidLoad() {
        print("I arrived in viewDidLoad prior")

        super.viewDidLoad()
        LocationManager.shared.requestLocationAuthorization()
        placesClient = GMSPlacesClient.shared()
        print("I arrived in viewDidLoad")
        // Do any additional setup after loading the view.
    }


}



