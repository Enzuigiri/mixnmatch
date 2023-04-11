//
//  CustomExtension.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI


extension Color {
    func toUIColor() -> UIColor {
        let uiColor = UIColor(self)
        return uiColor
    }
    
    func toHSB() -> (h: CGFloat, s: CGFloat, b: CGFloat) {
        let uiColor = self.toUIColor()
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (h: hue, s: saturation, b: brightness)
    }
    
    func toHSBArray() -> [CGFloat] {
        let uiColor = self.toUIColor()
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return [hue, saturation, brightness]
    }
    
    
}


extension Color {
    init(hueSaturationBrightness: [CGFloat]) {
        guard hueSaturationBrightness.count == 3 else {
            fatalError("Array must have 3 elements: hue, saturation, brightness")
        }
        
        let hue = hueSaturationBrightness[0]
        let saturation = hueSaturationBrightness[1]
        let brightness = hueSaturationBrightness[2]
        
        self.init(hue: hue, saturation: saturation, brightness: brightness)
    }
}


public struct ColorBlended: ViewModifier {
  fileprivate var color: Color
  
  public func body(content: Content) -> some View {
    VStack {
      ZStack {
        content
        color.blendMode(.sourceAtop)
      }
      .drawingGroup(opaque: false)
    }
  }
}

extension View {
  public func blending(color: Color) -> some View {
    modifier(ColorBlended(color: color))
  }
}

struct RoundedCorner: Shape {
    
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

//extension Color {
//    func toHexString() -> String {
//        guard let components = self.cgColor?.components, components.count >= 3 else {
//            return "000000"
//        }
//
//        let r = Float(components[0])
//        let g = Float(components[1])
//        let b = Float(components[2])
//
//        let hex = String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
//
//        return hex
//    }
//}

