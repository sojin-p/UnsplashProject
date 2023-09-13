//
//  CalculaterViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

class CalculaterViewModel {
    
    var firstNumber: CustomObservable<String?> = CustomObservable("10")
    var secondNumber: CustomObservable<String?> = CustomObservable("20")
    
    var resultText = CustomObservable("결과는 30입니다.")
    
    //3.
    var tempText = CustomObservable("테스트를 위한 텍스트!")
    
    //1. 오늘 과제 로또 당첨금(엄청 긴)에 대한 대처 (쉼표 찍기)
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    //4.
    func presentNumberFormat() {
        
        guard let first =  firstNumber.value, let firstConvertNumber = Int(first) else {
            tempText.value = "숫자로 변환할 수 없는 문자입니다."
            return
        }
        
        tempText.value = format(for: firstConvertNumber) //5번은 vc에
    }
    
    //==============================
    func calculate() {
        
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
