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

    private struct PersistedAddress: Codable {
        var name: String
        var streetAddress: String
        var city: String
        var zip: String
    }

    private func persistAddress() {
        let payload = PersistedAddress(name: name, streetAddress: streetAddress, city: city, zip: zip)
        if let data = try? JSONEncoder().encode(payload) {
            UserDefaults.standard.set(data, forKey: "order")
        }
    }

    convenience init(loadFromDefaults: Bool) {
        self.init()
        guard loadFromDefaults,
              let data = UserDefaults.standard.data(forKey: "order"),
              let saved = try? JSONDecoder().decode(PersistedAddress.self, from: data) else { return }

        self.name = saved.name
        self.streetAddress = saved.streetAddress
        self.city = saved.city
        self.zip = saved.zip
    }

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

    var name = "" {
        didSet { persistAddress() }
    }
    var streetAddress = "" {
        didSet { persistAddress() }
    }
    var city = "" {
        didSet { persistAddress() }
    }
    var zip = "" {
        didSet { persistAddress() }
    }

    var hasValidAddress: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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

