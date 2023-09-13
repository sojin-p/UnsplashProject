//
//  CalculaterViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

class CalculaterViewModel {
    
    var firstNumber: CustomObservable<String?> = CustomObservable("10") //4. 타입을 옵셔널스트링으로!
    var secondNumber: CustomObservable<String?> = CustomObservable("20")
    
    var resultText = CustomObservable("결과는 30입니다.")
    
    func calculate() { //5-0. 연산 로직 오류인지 아니라면 결과 값 뭔지
        
        //옵셔널이니까 바인딩하고 이어서 nil이 아니면 Int로 형변환 했을 때 제대로 들어오는지
        guard let first =  firstNumber.value, let firstConvertNumber = Int(first) else {
            resultText.value = "첫번째 값에서 오류가 발생했습니다." // or 얼럿
            return
        }
        
        guard let second = secondNumber.value, let secondConverNumver = Int(second) else {
            resultText.value = "두번째 값에서 오류가 발생했습니다."
            return
        }
        
        resultText.value = "결과는 \(firstConvertNumber + secondConverNumver)입니다." //업데이트!
    }
    
}
