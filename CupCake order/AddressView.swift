//
//  AddressView.swift
//  CupCake order
//
//  Created by Adam Herman on 06/02/2026.
//

import Foundation
import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("ZIP Code", text: $order.zip)
            }
            Section{
                NavigationLink("Checkout", destination: CheckoutView(order: order))
            }.disabled(!order.hasValidAddress)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
