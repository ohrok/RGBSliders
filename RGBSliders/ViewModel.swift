//
//  ViewModel.swift
//  RGBSliders
//
//  Created by 大井裕貴 on 2021/08/17.
//

import RxSwift
import RxCocoa

class ViewModel {
  
  let red = BehaviorSubject(value: 0)
  let green = BehaviorSubject(value: 0)
  let blue = BehaviorSubject(value: 0)
  let color: Driver<UIColor>
  let hexString: Driver<String>
  
  init() {
    let rgb = Observable.combineLatest(red, green, blue)
    
    color = rgb
      .map { red, green, blue in
        UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
      }
      .asDriver(onErrorJustReturn: .clear)
    
    hexString = color
      .map { color in
        color.hex(withHash: true)
      }
      .asDriver(onErrorJustReturn: "#000000")
  }
}
