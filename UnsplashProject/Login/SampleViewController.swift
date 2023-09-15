//
//  SampleViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import UIKit

class User: Hashable {
    
    //클래스일때만 구별하는 코드필요. lhs 왼쪽어쩌구, rhs 오른쪽 어쩌구
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id //다른건 같아도 되는데 id는 달라야함
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    } // ---------------------------------------
    
    let name: String
    let age: Int
    
    //Hashable 고유하게 하는 방법(name age가 같아도 런타임 오류 생기지 않게)
    let id = UUID().uuidString
    
    var introduce: String {
        return "\(name), \(age)살"
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class SampleViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. 양방향 데이터
        //우리가 아는 예시(단방향)
        var number1 = 10
        var number2 = 3
        
        print("단방향", number1 - number2) // 7
        
        number1 = 3 //이후 데이터는 감지 불가
        number2 = 1
        
        //옵저버블 형태
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        number3.bind { number in
            //변경이 될 때마다 프린트 실행
            print("Obsevable", number3.value - number4.value)
        }
        
        number3.value = 100
        number3.value = 500
        number3.value = 50
        
        
        //----------------------
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
//        let data = viewModel.cellForRowAt(at: indexPath)
//
//        cell.textLabel?.text = data.introduce
        
        //새롭게 등장한 셀 코드 - identifier를 사용하지 않아도 된다.
        //Configuration이라는 것이 붙어있으면 거진 구조체다. 점점 class -> struct 로 가고있는 흐름
        //SwiftUI는 구조체로 되어있음
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        
        content.text = "테스트" //사라진 textLabel의 종류
        content.secondaryText = "Hi \(indexPath.row)" //detailTextLabel
        cell.contentConfiguration = content //Protocol as Type
        
        return cell
    }
    
}
