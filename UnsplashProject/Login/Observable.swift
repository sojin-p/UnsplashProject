//
//  Observable.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import Foundation

class Observable<T> { //타입에 관계없이 하기 위해 제네릭구조로 변경
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet { //값이 바뀔때마다 단방향
//            print("didset", value)
            listener?(value) // 클로저를 실행하기 위한 역할..?
        }
    }
    
    init(_ value: T) { //선언만 할 경우 클래스라 인잇필요
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        print(#function)
        closure(value)
        listener = closure
        print("바인드 함수 끝부분")
    }
    
//    private var listener: ((String) -> Void)?
//
////    private var listener: (String) -> Void = { nickname in
////        print(nickname) //얼럿 레이블... 화면전환 서버통신 등
////    }
//
//    var value: String {
//        didSet {
//            print("didset", value)
//            listener?(value)
//        }
//    }
//
//    init(value: String) { //선언만 할 경우 클래스라 인잇필요
//        self.value = value
//    }
//
//    func bind(_ closure: @escaping (String) -> Void ) {
//        print(#function)
//        closure(value)
//        listener = closure
//        print("바인드 함수 끝부분")
//    }
}
