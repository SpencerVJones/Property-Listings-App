//  Listings.swift
//  JonesSpencer_JSONIntro
//  Created by Spencer Jones on 4/8/24.

import Foundation

class Listings {
    
    // MARK: Stored Properties
    let streetAddress: String
    let city: String
    let state: String
    let propertyType: String // Apartment, House, etc
    let price: Int
    let numBeds: Int
    let numBaths: Int
    let squareFt: Int
    let yearBuilt: Int
    let furnished: Bool
    let amenities: [String]
    
    
    // MARK: Computed Properties
    
    // Using the street address, city, and state to make a formatted address
    var formattedAddress: String {
        get {
            let formattedAddress = "\(streetAddress) \n\(city), \(state)"
            return formattedAddress
        }
    }
    
    // Calculating the price per square foot
    var pricePerSquareFt: Double {
        get{
            // Calculate the price per square foot
            let value = Double(price) / Double(squareFt)
            // Round the result to two decimal places
            return (value * 100).rounded() / 100
        }
    }
    
    // String indicating whether furnished or not
    var isFurnished: String {
        return furnished ? "Yes" : "No"  // True = yes, False = no
    }
    
    // Formatted string representing formatted price
    var formattedPrice: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: price)) ?? ""
        }
    }
    
    // Formatted string representing formatted square feet
    var formattedSquareFt: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: NSNumber(value: squareFt)) ?? ""
        }
    }
    
    // Formatted string representing formatted price per square feet
    var formattedPricePerSquareFt: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.minimumFractionDigits = 2
            formatter.maximumFractionDigits = 2
            return formatter.string(from: NSNumber(value: pricePerSquareFt)) ?? ""
        }
    }
    
    // MARK: Initalizer
    init(streetAddress: String, city: String, state: String, propertyType: String, price: Int, numBeds: Int, numBaths: Int, squareFt: Int, yearBuilt: Int, furnished: Bool, amenities: [String]) {
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.propertyType = propertyType
        self.price = price
        self.numBeds = numBeds
        self.numBaths = numBaths
        self.squareFt = squareFt
        self.yearBuilt = yearBuilt
        self.furnished = furnished
        self.amenities = amenities
    }
    
    // MARK: Methods
    
    // Method that loops through the amenities array and returns a string
    func amenitiesLoop() -> String {
        var amenitiesString = "Amenities: "
        
        // Loop through amenities array
        for (index, amenity) in amenities.enumerated() {
            if index == amenities.count - 1 {
                // If it's the last amenity, don't add a comma
                amenitiesString += amenity
            } else {
                // Otherwise, add a comma after the amenity
                amenitiesString += "\(amenity), "
            }
        }
        
        // Return the String
        return amenitiesString
    }
}
