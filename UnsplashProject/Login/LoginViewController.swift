//
//  LoginViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //데이터가 양방향으로 흐르게 만든 것
//        let sample = Observable(value: "1234 옵셔널이라 초기화") //옵셔널이니까 초기화해주기
//        sample.bind { text in
//            print(text,"이거되는것임?")
//        }
//
//        sample.value = "3456"
//        sample.value = "9999"
        
        //옵저버 클래스의 밸류를 꺼내보기 - didset 확인
//        let sample = Observable(value: "도리")
//        sample.value = "gdsfdfdag"
//        sample.value = "고래밥"
        
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        //2. 텍스트 필드에 값이 바뀔 때마다 id프로퍼티에 업데이트 시켜주기 위해 액션 연결
        idTextField.addTarget(self, action: #selector(idTextFieldChanged), for: .editingChanged) //editingChanged: 글자가 바뀔 때마다 실행
        pwTextField.addTarget(self, action: #selector(pwTextFieldChanged), for: .editingChanged)
        
        //뷰 모델 인스턴스 생성 후 코드 작성
        //1. 텍스트 필드에 기본 값 보여주기
        viewModel.id.bind { text in
            print("ID Bind \(text)")
            self.idTextField.text = text
        }
        
        viewModel.pw.bind { text in
            print("PW Bind \(text)")
            self.pwTextField.text = text
        }
        
        //5.
        viewModel.isValid.bind { bool in
            self.loginButton.isEnabled = bool
            self.loginButton.backgroundColor = bool ? .green : .lightGray
        }
        
        
    }
    
    @objc func pwTextFieldChanged() {
        viewModel.pw.value = idTextField.text!
        viewModel.checkValidation()
    }
    
    //3. id프로퍼티에 업데이트(뷰모델에 전달)
    @objc func idTextFieldChanged() {
        print("텍스트필드")
        viewModel.id.value = idTextField.text!
        //6. 값이 바뀌면 밸리데이션 체크
        viewModel.checkValidation()
    }
    
    @objc func loginButtonClicked() {
        
        //아이디 저장 등도 뷰모델에서 가능
        
        viewModel.signIn {
            print("로그인 성공했기 때문에 얼럿 띄우기") //성공이 아니면 버튼 자체가 안 눌림
        }
        
        //밑에는 뷰모델로 옮겼기때문에 필요없어졌다!
//        guard let id = idTextField.text else { return }
//        guard let pw = pwTextField.text else { return }
//
//        //데이터를 가공하는..
//        if id.count >= 6 && pw == "1234" {
//            print("로그인 했어요")
//        } else {
//            print("로그인 실패")
//        }
        
    }

}
