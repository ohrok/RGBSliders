//
//  UIColor+hex.swift
//  RGBSliders
//
//  Created by 大井裕貴 on 2021/08/17.
//

import UIKit

extension UIColor {
  public func hex(withHash hash: Bool = false, uppercase up: Bool = false) -> String {
    if let components = self.cgColor.components {
      let r = ("0" + String(Int(components[0] * 255.0), radix: 16, uppercase: up)).suffix(2)
      let g = ("0" + String(Int(components[1] * 255.0), radix: 16, uppercase: up)).suffix(2)
      let b = ("0" + String(Int(components[2] * 255.0), radix: 16, uppercase: up)).suffix(2)
      return (hash ? "#" : "") + String(r + g + b)
    }
    return "000000"
  }
}
