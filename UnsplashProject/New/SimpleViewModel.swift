//
//  SimpleViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/18.
//

import Foundation

class SimpleViewModel {
    
    //1-1. 옮기기
    let list: Observable<[User]> = Observable( [] ) //빈 배열로 초기화
    
    var list2 = [User(name: "하아암", age: 23),
                 User(name: "졸리다", age: 23),
                 User(name: "정신차려", age: 20),
                 User(name: "ㅠㅠㅠ", age: 20)]
    
    //1-2. 1번 list에 값 넣어주기
    func append() {
        list.value = [User(name: "Hue", age: 23),
                      User(name: "Hue", age: 23),
                      User(name: "Bran", age: 20),
                      User(name: "Kokojong", age: 20)]
    }
    
    //1-3. 한 번에 지우는 것 만들기
    func remove() {
        list.value = []
    }
    
    //4-2.
    func removeUser(idx: Int) {
        list.value.remove(at: idx)
    }
    
    //5-3.
    func insertUser(name: String) {
        //입력한 값을 받아서 넣기 나이는 랜덤
        let user = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(user, at: Int.random(in: 0...2))
    }
}
