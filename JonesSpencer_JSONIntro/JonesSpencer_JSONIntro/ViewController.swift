//  ViewController.swift
//  JonesSpencer_JSONIntro
//  Created by Spencer Jones on 4/8/24.


import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet var propertyTypeLabel: UILabel!
    @IBOutlet var formattedAddressLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var squareFtLabel: UILabel!
    @IBOutlet var numBedsLabel: UILabel!
    @IBOutlet var numBathsLabel: UILabel!
    @IBOutlet var pricePerSquareFtLabel: UILabel!
    @IBOutlet var yearBuiltLabel: UILabel!
    @IBOutlet var furnishedLabel: UILabel!
    @IBOutlet var amenitiesLabel: UILabel!
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    // Array to store the property listings
    var listings = [Listings]()
    
    // Current index of displayed listing
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get path to json data
        if let path = Bundle.main.path(forResource: "PropertyListings", ofType: ".json") {
            // Create URL with path
            let url = URL(fileURLWithPath: path)
            
            do {
                // Create data object
                let data = try Data.init(contentsOf: url)
                
                // Create json object and cast it as array of any type
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
                
                // Call parse method
                Parse(jsonObject: jsonObj)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        // Update UI lavels with inital listing
        updateUI(with: currentIndex)
    }
    
    
    // Method to convert [Any] into usable types
    func Parse(jsonObject: [Any]?) {
        // Bind optional jsonObject to non-optional json
        if let jsonObj = jsonObject {
            
            // Loop through each first level object in json array
            for firstLevelItem in jsonObj {
                // Check to see if items can be unwrapped
                guard let object = firstLevelItem as? [String: Any],
                      let streetAddress = object["street_address"] as? String,
                      let city = object["city"] as? String,
                      let state = object["state"] as? String,
                      let propertyType = object["property_type"] as? String,
                      let price = object["price"] as? Int,
                      let numBeds = object["num_beds"] as? Int,
                      let numBaths = object["num_baths"] as? Int,
                      let squareFt = object["square_ft"] as? Int,
                      let yearBuilt = object["year_built"] as? Int,
                      let furnished = object["furnished"] as? Bool,
                      let amenities = object["amenities"] as? [String]
                else { return }
                
                // Create new listing objects and append them to the array
                listings.append(Listings(streetAddress: streetAddress, city: city, state: state, propertyType: propertyType, price: price, numBeds: numBeds, numBaths: numBaths, squareFt: squareFt, yearBuilt: yearBuilt, furnished: furnished, amenities: amenities))
            }
        } else { return}
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Increment current index
        currentIndex += 1
        
        // Wrap index to beginning if index exceeds array bounds
        if currentIndex >= listings.count {
            currentIndex = 0
        }
        
        // Update UI with new listing
        updateUI(with: currentIndex)
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        // Decrement current index
        currentIndex -= 1
        
        // Wrap index to end if index is below zero
        if currentIndex < 0 {
            currentIndex = listings.count - 1
        }
        
        // Update UI with new listing
        updateUI(with: currentIndex)
    }
    
    
    // Method to update the UI with the listing data
    func updateUI(with index: Int) {
        
        // Get the current listing
        let listing = listings[index]
        
        // Update the labels with the listing data
        propertyTypeLabel.text = listing.propertyType
        formattedAddressLabel.text = listing.formattedAddress
        priceLabel.text = "$\(listing.formattedPrice)"
        squareFtLabel.text = "Square Feet: \(listing.formattedSquareFt)"
        numBedsLabel.text = "\(listing.numBeds) Beds"
        numBathsLabel.text = "\(listing.numBaths) Baths"
        pricePerSquareFtLabel.text = "Price per Square Feet: \(listing.formattedPricePerSquareFt)"
        yearBuiltLabel.text = "Year Built: \(listing.yearBuilt)"
        furnishedLabel.text = "Furnished: \(listing.isFurnished)"
        amenitiesLabel.text = listing.amenitiesLoop()
    }
}
