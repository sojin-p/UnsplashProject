//
//  SojinObservable.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

class CustomObservable<T> { //1. 제네릭으로 T
    
    private var listener: ((T) -> Void)?
    
    var value: T { //2. name에서 value로 바꾸기
        didSet {
            listener?(value) //3. 데이터를 바인딩 하는 역할. 데이터가 바뀔때마다 함수가 실행 되니까!
            print("사용자의 이름이 \(value)(으)로 변경되었습니다.")
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func introduce(_ sample: @escaping (T) -> Void) {
        print("저는 \(value)입니다.")
        sample(value)
        listener = sample
    }
    
    /*
     sample(name)
     listener = sample

     name didSet에 있는 listener?(name)을 하나씩 지워보고 실행해보기
     */
}
