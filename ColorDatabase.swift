//
//  ColorDatabase.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 09/04/23.
//

import SwiftUI

class ColorManager {
    private let accessKey = "swatchessaaaaa"
    private let userDefault = UserDefaults.standard
    private var savedColors: [[CGFloat]] = []
    
    init() {
        if let savedColors = userDefault.array(forKey: accessKey) as? [[CGFloat]] {
            self.savedColors = savedColors
        } else {
            savedColors = [convertToHSBArray(color: Color.green), convertToHSBArray(color: Color.blue)]
            userDefault.set(savedColors, forKey: accessKey)
        }
    }

    func allColors() -> [Color] {
        if let savedColors = userDefault.array(forKey: accessKey) as? [[CGFloat]] {
            self.savedColors = savedColors
        }
        return convertToColor(floatColors: savedColors).reversed()
    }
    
    func saveColor(color: Color){
        savedColors.append(convertToHSBArray(color: color))
        userDefault.set(savedColors, forKey: accessKey)
    }
    
    func saveColors(colors: [Color]){
        for color in colors {
            savedColors.append(convertToHSBArray(color: color))
        }
        userDefault.set(savedColors, forKey: accessKey)
    }
    
    private func convertToHSBArray(color: Color) ->  [CGFloat] {
        return [color.toHSB().h, color.toHSB().s, color.toHSB().b]
      
    }
    
    private func convertToColor(floatColors: [[CGFloat]]) -> [Color]{
        var data : [Color] = []
        for color in floatColors {
            data.append(Color(hue: color[0], saturation: color[1], brightness: color[2]))
        }
        return data
    }
    

}
