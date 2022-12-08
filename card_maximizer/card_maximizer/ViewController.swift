//
//  ViewController.swift
//  card_maximizer
//
//  Created by Marcello Rusciano on 11/4/22.
//

import UIKit
import GooglePlaces
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate, bob {
    
    private var placesClient: GMSPlacesClient!
    var variableCard : String = ""
    var responseFromGoogle: String = ""
    
    @IBOutlet weak var type: UIButton!
    @IBOutlet weak var creditCardNumber: UILabel!
    @IBOutlet weak var creditCard: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet private var storeName: UIButton!
    @IBOutlet weak var storeAddress: UIButton!
    @IBOutlet weak var youShouldUse: UILabel!
    @IBOutlet weak var applePay: UIButton!
    
    @IBAction func applePay(_ sender: UIButton) {
        if let url = URL(string: "shoebox://"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else if let itunesUrl = URL(string: "shoebox://"), UIApplication.shared.canOpenURL(itunesUrl) {
                    UIApplication.shared.open(itunesUrl, options: [:], completionHandler: nil)
                }
    }
    
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
        sender.tintColor = UIColor.black
        applePay.setImage(UIImage(named: "apple-pay"), for: .normal)
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
        case "dining": creditCard.text = "Discover it Cash Back"; creditCardNumber.text = "Ending with ...9424"; variableCard = "discover_it_cash_back"
        case "entertainment": creditCard.text = "Chase"; creditCardNumber.text = "Ending with ...9424"; variableCard = "Chase"
        case "travel": creditCard.text = "Amex"; creditCardNumber.text = "Ending with ...9424"; variableCard = "ame"
        case "gas": creditCard.text = "Bank of America"; creditCardNumber.text = "Ending with ...9424"; variableCard = "Bofa"
        case "grocery": creditCard.text = "Capitol One"; creditCardNumber.text = "Ending with ...9424"; variableCard = "Capitol"
        default: creditCard.text = "Wells Fargo"; creditCardNumber.text = "Ending with ...9424"; variableCard = "Well"
        }
        imageView.image = UIImage(named: variableCard)
        youShouldUse.text = "You should use:"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let cardStoreViewController = segue.destination as? CardStoreViewController{
            cardStoreViewController.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManager.shared.requestLocationAuthorization()
        placesClient = GMSPlacesClient.shared()
        // Do any additional setup after loading the view.
    }
}
