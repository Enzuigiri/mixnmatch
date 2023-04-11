//
//  TestOutfitView.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 10/04/23.
//

import SwiftUI

struct TestOutfitView: View {
    @ObservedObject var outfitViewModel = OutfitViewModel.shared
    @State var outfits: [OutfitModel] = OutfitViewModel().outfits

    var body: some View {
        VStack{
            Button(action: {
                outfitViewModel.addOutfit(OutfitModel( id: nil))
                outfits = outfitViewModel.outfits
            }) {
                Text("Add")
            }
            List {
                ForEach(
                    0..<outfits.count, id: \.self
                ) { i in
                    var _ = print(outfits[i].pants)
                    HStack {
                        Text("Shirt: \(outfits[i].shirt)")
                        Text("Pants: \(outfits[i].pants)")
                        Spacer()
                        Button(action: {
                            outfitViewModel.removeOutfit(at: i)
                            outfits = outfitViewModel.outfits
                        }) {
                            Text("Remove")
                        }
                    }
                }
            }
        }
    }
}

struct TestOutfitView_Previews: PreviewProvider {
    static var previews: some View {
        TestOutfitView()
    }
}
