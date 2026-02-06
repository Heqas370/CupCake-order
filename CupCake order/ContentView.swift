//
//  ContentView.swift
//  CupCake order
//
//  Created by Adam Herman on 06/02/2026.
//

import SwiftUI

struct ContentView: View {
    
    @State private var order = Order()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Pick your cupcapke type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Select amount of cupcakes: \(order.quantity)", value: $order.quantity, in: 0...10)
                    
                    Spacer()
                    Section{
                        Toggle("Any special request?", isOn: $order.specialRequestEnabled)
                        if order.specialRequestEnabled {
                            Toggle("Add sprinkles", isOn: $order.addSprinklesEnabled)
                            Toggle("Extra frosting", isOn: $order.extraFrostingEnabled)
                        }
                    }
                }
            }
            
            NavigationLink("Delivery details", destination: AddressView(order: order))
            
            .navigationTitle("Cupcake order")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
