//
//  SampleViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import Foundation

//뷰에 표현할 데이터들을 최대한 가공하는 역할
//비즈니스 로직 담당
class SampleViewModel {
    
    var list = [User(name: "Hue", age: 31), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]
    
    var numberOfRowsInSection: Int {
        return list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return list[indexPath.row]
    }
    
}
