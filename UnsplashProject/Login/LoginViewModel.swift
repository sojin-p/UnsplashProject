//
//  LoginViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import Foundation

class LoginViewModel {
    
    var id = Observable("")
    var pw = Observable("")
    
    //4-1.
    var isValid = Observable(false) //되는지 아닌지 여부만
    
    //4.
    func checkValidation() {
        if id.value.count >= 6 {// && pw.value.count >= 4 { //왜 처음에 안됐나? 패스워드 값을 뷰모델에 전달하지 않았기 때문에!
            //4-3.
            isValid.value = true
        } else {
            //4-3.
            isValid.value = false
        }
    }
    
    func signIn(completion: @escaping () -> Void) {
        //서버, 닉네임, id
        UserDefaults.standard.set(id.value, forKey: "id")
        
        completion()
    }
    
    
}
