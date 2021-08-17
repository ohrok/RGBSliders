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
  
  @IBOutlet weak var redTextField: UITextField!
  
  private let disposeBag = DisposeBag()
  private let viewModel = ViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    redTextField.rx.text.orEmpty
      .compactMap { text in
        Int(text)
      }
      .bind(to: viewModel.red)
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

