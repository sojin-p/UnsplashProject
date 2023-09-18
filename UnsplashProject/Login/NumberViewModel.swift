//
//  NumberViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/18.
//

import Foundation

class NumberViewModel {
    
    //4. 고쳐야 할 것 변수 만들기
    var number: Observable<String?> = Observable("1000") //numberTextField에 들어가는 값
    var result = Observable("1,327,000") //resultLabel에 들어가는 값
    
    //3. 옮겨붙이기
    func convertNumber() {
        //7-1.
        print("디버깅 해보기",result.value, number.value) //잘 되고 있는지
        
        //빈 값
//        guard let text = numberTextField.text else {
        guard let text = number.value else {
//            resultLabel.text = "값을 입력해주세요"
            result.value = "값을 입력해주세요" //실질적인 값으로 변경
            return
        }
        
        //문자열
        guard let textToNumber = Int(text) else {
            result.value = "100만원 이하의 숫자를 입력해주세요"
            return
        }
        
        //백만원 내에서 가능
        guard textToNumber > 0, textToNumber <= 1000000 else {
            result.value = "환전 범주는 100만원 이하입니다"
            return
        }
        
        //쉼표 처리
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let decimalNumber = numberFormatter.string(for: textToNumber * 1327)!
        
        result.value = "환전 금액은 \(decimalNumber)원입니다."
    }
}
