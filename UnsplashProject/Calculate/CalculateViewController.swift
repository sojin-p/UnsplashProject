//
//  CalculateViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/13.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    let viewModel = CalculaterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. 사용자가 입력을 바꾸면 실시간 업데이트 하고 싶다.
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
        
        //어떤 기능을 넣어줄지(어떻게 바인딩을 할지) 바인드 함수 내부 실제 실행은 딱 한 번만 됨!
        viewModel.firstNumber.bind { number in
            self.firstTextField.text = number
        }
        
        viewModel.secondNumber.bind { number in
            self.secondTextField.text = number
        }
        
        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }
        
    }
    
    //2. 밸류에 넣어야 didSet이 실행되니까!
    @objc func firstTextFieldChanged() {
        //3. 에러나는 이유? 닐을 받을 수 있어야 해서 CalculaterViewModel에 가서 타입어노테이션 CustomObservable<String?>
        viewModel.firstNumber.value = firstTextField.text
        
        //5. 텍스트가 바뀔 때마다 뷰 모델에 연산해달라고 요청!
        viewModel.calculate()
    }
    
    @objc func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calculate()
    }
    

}

/*
 let person = Person("새싹이") //이건 최초 값 들어가는 거라 프린트가 찍히지 않음(초기화 한거라)
 
 //바뀔 때마다 didSet 호출
 person.name = "커스타드"
 person.name = "칙촉"
 
 //마지막 이름 기준으로 인트로듀스가 붙여짐
 //person.introduce(Int.random(in: 1...10))
 
 //(5) 이게 계속 실행이 여러번 되고 있는 것이 아니다!
 //intro함수 안에(sample(name)) 변수name 업데이트하는 걸(listener = sample) 넣었기 때문에, 이름이 바뀌게 되고, name이 바뀌니까 name didSet에 listener?(name) 호출되는 것!
 person.introduce { name in
     self.resultLabel.text = name
     self.view.backgroundColor = [UIColor.blue, UIColor.orange, UIColor.cyan].randomElement()!
 }
 
 //5-1. 인트로듀스가 들어오면 백그라운드를 바꾸고싶다...(5-2로!)
//        person.introduce(Int.random(in: 1...10)) {
//            self.view.backgroundColor = [UIColor.blue, UIColor.orange, UIColor.cyan].randomElement()!
//        }
 
 //10. 배경색이 바뀌는건지 체크가 안되니까 딜레이 주기
 //언제쓰나? - 검색기능, 당겨서 새로고침, 로딩바 띄우고 싶을 때(통신이 빠르면 안 보임) 최소 0.5초는 보여주자
 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
     person.name = "바나나"
     print("----1초뒤에 찍히나?---")
 }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
     person.name = "키위"
     print("----3초뒤에 찍히나?---")
 }
 
 //4. 럭키넘버 변수 생성 후, 인트로듀스 생성 이후라서 숫자가 들어가기 시작!
 //person.name = "바나나"
 
 //VC는 내용을 모른다. 그저 가져와서 보여주는 것뿐
 firstTextField.text = viewModel.firstNumber.value
 secondTextField.text = viewModel.secondNumber.value
 */
