//
//  ViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        nicknameTextField.placeholder = NSLocalizedString("nickname_placeholder", comment: "")//"닉네임을 입력해주세요"
//        let value = NSLocalizedString("nickname_result", comment: "")
//        resultLabel.text = String(format: value, "고래밥", "다마고치", "그루트")
        
        //익스텐션 이후
        nicknameTextField.placeholder = "nickname_placeholder".localized
        resultLabel.text = "age_result".localized(number: 30)
        
        //커맨드+컨트롤+E 특정 스포크 내 이름 한번에 수정, 주석은 불가
        let bar = UISearchBar()
        bar.text = "텍스트~~"
        bar.placeholder = "플레이스홀더"
        
        //옵션+드래그 = 수직으로 드래그
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function) // Ctrl + Shift + 클릭 : 멀티 커서 기능, 반복 작업에 좋당 or 컨+쉬+위아래화살표
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function) // Ctrl + Shift + 클릭 : 멀티 커서 기능, 반복 작업에 좋당
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function) // Ctrl + Shift + 클릭 : 멀티 커서 기능, 반복 작업에 좋당
    }
}

