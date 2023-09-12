//
//  SampleViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import UIKit

struct User {
    let name: String
    let age: Int
    
    var introduce: String {
        return "\(name), \(age)살"
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.textLabel?.text = data.introduce
        
        return cell
    }
    
}
