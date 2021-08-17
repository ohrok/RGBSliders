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
  
  func testColorIsWhiteWhenRedIs255AndGreenIs255AndBlueIs255() {
    let disposeBag = DisposeBag()
    let expectedColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    var result: UIColor!
    
    viewModel.color.asObservable()
      .skip(3)
      .subscribe(onNext: {
        result = $0
      })
      .disposed(by: disposeBag)
    
    viewModel.red.accept(255)
    viewModel.green.accept(255)
    viewModel.blue.accept(255)
    
    XCTAssertEqual(expectedColor, result)
  }
  
  func testHexStringIsFFFFFFWhenRedIs255AndGreenIs255AndBlueIs255() {
    let disposeBag = DisposeBag()
    let expectedHexString = "#ffffff"
    var result: String!
    
    viewModel.hexString.asObservable()
      .skip(3)
      .subscribe(onNext: {
        result = $0
      })
      .disposed(by: disposeBag)
    
    viewModel.red.accept(255)
    viewModel.green.accept(255)
    viewModel.blue.accept(255)
    
    XCTAssertEqual(expectedHexString, result)
  }
}
