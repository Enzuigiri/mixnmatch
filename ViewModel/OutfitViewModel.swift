//
//  OutfitViewModel.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 10/04/23.
//
import Foundation


class OutfitViewModel: ObservableObject{
    static let shared = OutfitViewModel()
      
      private let defaults = UserDefaults.standard
      
      private let key = "outfitLists"
      
      var outfits: [OutfitModel] {
          get {
              if let data = defaults.data(forKey: key),
                 let outfits = try? JSONDecoder().decode([OutfitModel].self, from: data) {
                  return outfits
              }
              return []
          }
          set {
              if let data = try? JSONEncoder().encode(newValue) {
                  defaults.set(data, forKey: key)
              }
          }
      }
      
      func addOutfit(_ outfit: OutfitModel) {
          outfits.append(outfit)
          self.outfits = outfits // update UserDefaults
          print("added", outfits)

      }
      
      func removeOutfit(at index: Int) {
          outfits.remove(at: index)
          self.outfits = outfits // update UserDefaults

      }
    
}
