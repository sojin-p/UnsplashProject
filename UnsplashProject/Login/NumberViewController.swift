//
//  NumberViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/18.
//

import UIKit

class NumberViewController: UIViewController {
    
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    let viewModel =  NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //6.
        bindData()
        
        //1.
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
        
    }
    
    //7. 함수로 빼기
    func bindData() {
        //6. 뷰모델과 객체 짝꿍 연결
        viewModel.number.bind { value in
            self.numberTextField.text = value
            //하나의 데이터를 여러 뷰 객체에 연결도 가능
        }
        
        viewModel.result.bind { value in
            self.resultLabel.text = value
        }
    }
    
    //2.
    @objc func numberTextFieldChanged() {
        
        //7-2. 디버깅 후
        viewModel.number.value = numberTextField.text
        //5. 옮긴 것 호출
        viewModel.convertNumber()
        
    }
}
