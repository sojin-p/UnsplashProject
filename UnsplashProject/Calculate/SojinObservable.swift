//
//  SojinObservable.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

class Person {
    
    var listener: ((String) -> Void)? //(2) 여기도 name의 타입 넣기
    
    var name: String {
        didSet {
            listener?(name) //(4) name 추가
            print("사용자의 이름이 \(name)(으)로 변경되었습니다.")
        }
    }
    
    init(_ name: String) {
        self.name = name
    }
    
    func introduce(_ sample: @escaping (String) -> Void) { //(1) 사용자가 알 수 있게 name의 타입인 String 전달하자
        print("저는 \(name)입니다.")
        sample(name) //(3) 이름을 보여주고 싶어서 name추가 +만약 이게 없다면 바나나 부터 실행이 되는 것! 왜? VC의 인트로듀스 안의 클로저가 실행되는게 아니므로.
        listener = sample
    }
    
    /*
     sample(name)
     listener = sample

     name didSet에 있는 listener?(name)을 하나씩 지워보고 실행해보기
     */
}
