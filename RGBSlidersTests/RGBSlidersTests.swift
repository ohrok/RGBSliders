//
//  RGBSlidersTests.swift
//  RGBSlidersTests
//
//  Created by 大井裕貴 on 2021/08/17.
//

import XCTest
import RxSwift
import RxTest
@testable import RGBSliders

class RGBSlidersTests: XCTestCase {
  
  var viewModel: ViewModel!
  
  override func setUp() {
    super.setUp()
    viewModel = ViewModel()
  }
  
  func testColorIsRedWhenRedIs255GreenIs0BlueIs0() {
    let disposeBag = DisposeBag()
    let expectedColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
    var result: UIColor!
    
    viewModel.color.asObservable()
      .skip(1)
      .subscribe(onNext: {
        result = $0
      })
      .disposed(by: disposeBag)
    
    viewModel.red.onNext(255)
    
    XCTAssertEqual(expectedColor, result)
  }
}
