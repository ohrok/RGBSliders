//
//  ViewController.swift
//  RGBSliders
//
//  Created by 大井裕貴 on 2021/08/14.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
  
  @IBOutlet weak var colorView: UIView!
  @IBOutlet weak var hexLabel: UILabel!
  @IBOutlet weak var redTextField: UITextField!
  @IBOutlet weak var greenTextField: UITextField!
  @IBOutlet weak var blueTextField: UITextField!
  @IBOutlet weak var redSlider: UISlider!
  @IBOutlet weak var greenSlider: UISlider!
  @IBOutlet weak var blueSlider: UISlider!
  
  private let disposeBag = DisposeBag()
  private let viewModel = ViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let redNum = redTextField.rx.text.orEmpty
      .compactMap { Int($0) }
      .filter { 0 ..< 256 ~= $0 }
      .share()
    
    let greenNum = greenTextField.rx.text.orEmpty
      .compactMap { Int($0) }
      .filter { 0 ..< 256 ~= $0 }
      .share()
    
    let blueNum = blueTextField.rx.text.orEmpty
      .compactMap { Int($0) }
      .filter { 0 ..< 256 ~= $0 }
      .share()
  
    redNum
      .bind(to: viewModel.red)
      .disposed(by: disposeBag)
    
    greenNum
      .bind(to: viewModel.green)
      .disposed(by: disposeBag)
    
    blueNum
      .bind(to: viewModel.red)
      .disposed(by: disposeBag)
    
    redNum
      .map { Float($0) }
      .bind(to: redSlider.rx.value)
      .disposed(by: disposeBag)
    
    greenNum
      .map { Float($0) }
      .bind(to: greenSlider.rx.value)
      .disposed(by: disposeBag)
    
    blueNum
      .map { Float($0) }
      .bind(to: blueSlider.rx.value)
      .disposed(by: disposeBag)
    
    viewModel.color.asObservable()
      .subscribe(onNext: {
        print($0)
      })
      .disposed(by: disposeBag)
    
    viewModel.hexString.asObservable()
      .subscribe(onNext: {
        print($0)
      })
      .disposed(by: disposeBag)
  }
}

