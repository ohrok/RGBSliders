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
    
    [
      (viewModel.red,   redTextField,   redSlider),
      (viewModel.green, greenTextField, greenSlider),
      (viewModel.blue,  blueTextField,  blueSlider)
    ].forEach { relay, textField, slider in
      guard let textField = textField, let slider = slider else { return }
      
      textField.delegate = self
      
      let textFieldNum = textField.rx.text.orEmpty
        .map { text -> Int in
          guard let num = Int(text) else { return 0 }
          guard num <= Int(slider.maximumValue) else {
            return Int(slider.maximumValue)
          }
          return num
        }
        .share()
      
      textFieldNum
        .map { String($0) }
        .bind(to: textField.rx.text)
        .disposed(by: disposeBag)
      
      textFieldNum
        .bind(to: relay)
        .disposed(by: disposeBag)
      
      textFieldNum
        .map { Float($0) }
        .bind(to: slider.rx.value)
        .disposed(by: disposeBag)
      
      slider.rx.value
        .map { Int($0) }
        .bind(to: relay)
        .disposed(by: disposeBag)
      
      slider.rx.value
        .map { "\(Int($0))" }
        .bind(to: textField.rx.text)
        .disposed(by: disposeBag)
     }
    
    viewModel.color
      .drive(colorView.rx.backgroundColor)
      .disposed(by: disposeBag)
    
    viewModel.hexString
      .drive(hexLabel.rx.text)
      .disposed(by: disposeBag)
  }
}

extension ViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let maxLength = 3
    guard let oldText = textField.text, let stringRange = Range(range, in:oldText) else {
      return false
    }
    let newText = oldText.replacingCharacters(in: stringRange, with: string)
    
    if string == "\n" {
      return true
    }
    return newText.count < maxLength + 1
  }
}

