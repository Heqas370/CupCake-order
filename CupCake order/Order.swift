//
//  Order.swift
//  CupCake order
//
//  Created by Adam Herman on 06/02/2026.
//

import Foundation
import Observation

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrostingEnabled = "extraFrostingEnabled"
        case _addSprinklesEnabled = "addSprinklesEnabled"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }

    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrostingEnabled = false
                addSprinklesEnabled = false
            }
        }
    }

    var extraFrostingEnabled = false
    var addSprinklesEnabled = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }

        return true
    }

    var cost: Decimal {
        var cost = Decimal(quantity) * 2

        cost += Decimal(type) / 2

        if extraFrostingEnabled {
            cost += Decimal(quantity)
        }

        if addSprinklesEnabled {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
}
