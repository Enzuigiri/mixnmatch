//
//  CustomExtension.swift
//  mixnmatch
//
//  Created by Muhammad Rezky on 08/04/23.
//

import SwiftUI


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

