//
//  SimpleCollectionViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/14.
//

import UIKit
import SnapKit

class SimpleCollectionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case first = 200
        case second = 1
    }
    
    var list = [User(name: "Hue", age: 23),
                User(name: "Hue", age: 23),
                User(name: "Bran", age: 20),
                User(name: "Kokojong", age: 20)]
    
    var list2 = [User(name: "하아암", age: 23),
                 User(name: "졸리다", age: 23),
                 User(name: "정신차려", age: 20),
                 User(name: "ㅠㅠㅠ", age: 20)]
    
    //Array<엘리먼트>
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    //Diffable 디퍼블 1. 선언. 이제 익스텐션에 프로토콜 채택이 아닌, 인스턴스 생성! 얘가 num~ cell~ 을 갖고있다.
    var dataSource: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //Diffable 디퍼블 3. number~ 처리 ---------------------------------
        var snapshot = NSDiffableDataSourceSnapshot<String, User>() //스냅샷 찍을 수 있게 도와주는 구조체, dataSource와 타입 맞추기
        snapshot.appendSections(["SeSAC 섹션", "생각 섹션"])//섹션 1개, 배열 타입인데 개별 섹션이라 [0,1,2,3] 섹션 4개 쓸 때 근데 이게 인덱스가 아님. 그냥 섹션의 고유숫자! 100,120 이렇게 해도 가능
        //snapshot.appendItems(list) //list의 엘리먼트 수 만큼
        snapshot.appendItems(list, toSection: "SeSAC 섹션")
        snapshot.appendItems(list2, toSection: "생각 섹션") //1번 섹션에 넣을게 - 나중에 열거형으로
        //둘 다 list를 넣으면 오류발생. 어떻게할까? 배열을 하나 더 생성
        
        dataSource.apply(snapshot) //갱신
        
        //--------------------------------------------------------------
    }
    
    
    
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped) //side~ 보통 아이패드에서 사용
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGray4
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        //collectionView.register 등록했던 그거. UICollectionViewListCell<- 어떤 셀을 사용할지, User <- 어떤 타입을 사용할지 블럭 위치
        //var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
        
        //위에 클래스 내에 선언한 것을 이 함수에서만 쓰게되니까 옮겨주는 작업. 밑 코드에 let을 붙이고 <UICollectionViewListCell, User> 타입 명시
        
        //listCell
        //UICollectionView.CellRegistration : iOS 14.0~ 셀 등록 또 다른 방법, 아이덴티파이어 xib 메서드 대신 제네릭 사용, 셀이 생성될 때마다 클로저가 호출
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User>(handler: { cell, indexPath, itemIdentifier in
            //itemIdentifier 각 셀당 데이터?
            //셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .blue
            content.imageProperties.tintColor = .systemOrange
            content.prefersSideBySideTextAndSecondaryText = false //나이를 왼쪽으로 보냄
            content.textToSecondaryTextVerticalPadding = 10
            content.imageToTextPadding = 20
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            cell.contentConfiguration = content
            
            //셀 백그라운드 ViewConfiguration
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .systemYellow
            backgroundConfig.cornerRadius = 15
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
            
            //이곳은 메서드로 묶든 프라이빗으로 다른데서 못쓰게하든 고민고민해보자
        })
        
        //Diffable 디퍼블 2. 초기화. cellFor~ 처리 ----------------------------
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            //collectionView - 기존 데이터소스 가져와서 레지스터랑 연동해야함
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
}

//extension SimpleCollectionViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item]) //item: list같은 데이터 들어가는 영역, using: <>꺽새를 봐서 제네릭이다
//        //실행은 위로 viewDidLoad에 작성한 cellRegistration 클로저 구문을 실행하게된다.
//
//        return cell
//    }
//
//}


