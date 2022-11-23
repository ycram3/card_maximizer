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
    var variableCard : String = "discover"
    var responseFromGoogle: String = ""
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
    
    @IBOutlet weak var type: UIButton!
    @IBOutlet weak var creditCardNumber: UILabel!
    @IBOutlet weak var creditCard: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private var storeName: UIButton!
    @IBOutlet weak var storeAddress: UIButton!

    
    @IBAction func confirmStore(_ sender: UIButton) {
        let placeFields: GMSPlaceField = [.name, .formattedAddress, .types]
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
            strongSelf.storeAddress.setTitle("No Address Available", for: .normal)
            strongSelf.type.setTitle("Unknown1", for: .normal)
            return
          }
            strongSelf.storeAddress.setTitle(place.formattedAddress, for: .normal)
            self?.responseFromGoogle = place.types?[0] ?? "Unknown2"
            let storeCateg = self?.getCategory()
            strongSelf.type.setTitle(storeCateg, for: .normal)
            strongSelf.storeName.setTitle(place.name , for: .normal)
            self?.showTheCardToBeUsed(storeCategory: storeCateg ?? "Whatever")
        }
        sender.backgroundColor = UIColor.green
    }

    func getCategory() -> String {
        var category : String = "Unknown3"
        for key in dict.keys{
            if responseFromGoogle == key{
               category = dict[key]!
            }
        }
        return category
    }
    
    func showTheCardToBeUsed(storeCategory: String){
        switch storeCategory{
        case "dining": creditCard.text = "Discover"; creditCardNumber.text = "6011 0009 9013 9424"; variableCard = "Discover-logo"
        case "entertainment": creditCard.text = "Chase"
        case "travel": creditCard.text = "Amex"
        case "gas": creditCard.text = "Bank of America"
        case "grocery": creditCard.text = "Capitol One"
        default: creditCard.text = "Wells Fargo";
                print("I am in the default card")
        }
        imageView.image = UIImage(named: variableCard)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.requestLocationAuthorization()
        placesClient = GMSPlacesClient.shared()
        // Do any additional setup after loading the view.
    }
}
