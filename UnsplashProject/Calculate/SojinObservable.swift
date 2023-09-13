//
//  SojinObservable.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

class Person {
    
    var luckyNumber: Int? //2.
    var listener: (() -> Void)? //7.인트 확장해서 함수 담기
    
    var name: String {
        didSet {
            listener?() //9. 업데이트 된 것(함수)을 실행! 인트로듀스 안쓰면 Nil이라서
            print("사용자의 이름이 \(name)(으)로 변경되었습니다. 당신의 뽑은 행운의 숫자는 \(luckyNumber ?? 0)입니다.") //1. \(number)입니다.") // 넘버가 메서드 내에서만 사용이 가능함. 그럼 넘버를 어떻게 알지? - 펄슨 변수 만들어서 내용 업데이트하면 됨
        }
    }
    
    init(_ name: String) {
        self.name = name
    }
    
    func introduce(_ number: Int, sample: @escaping () -> Void) {
        print("저는 \(name)이고, 행운의 숫자는 \(number)입니다.")
        //luckyNumber = number //3. 변수에 업데이트하면 이제 네임에서 쓸 수 있다!
        //5-2. 함수를 밖에서 실행시켜야한다.
        sample()
        //6. 순서..왜바ㅣ뀌었지?
        luckyNumber = number
        
        listener = sample //8. 인트업뎃하는 것처럼 함수타입 변수 생성후 업데이트!
        //우리는 밖에서 함수를 실행해도, 여기 변수들에 업데이트를 시켜줘야하므로 escaping 필요
    }
    
}
