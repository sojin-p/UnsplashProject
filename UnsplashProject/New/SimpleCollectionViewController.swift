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
    
    //2.
    var viewModel = SimpleViewModel()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    //Diffable 디퍼블 1. 선언. 이제 익스텐션에 프로토콜 채택이 아닌, 인스턴스 생성! 얘가 num~ cell~ 을 갖고있다.
    var dataSource: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //5-1. (5-2는 익스텐션)
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        configureDataSource() //호출
        
        //3. list 바뀔 때마다 뭐 할지
//        updateSnapshot()
        viewModel.list.bind { user in // user: 달라지는 value를 항상 매개변수로 받고있다.
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            self.viewModel.append()
        }
        
        //바뀐 UI 빨리 보고싶을 때
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
////            self.list.insert(User(name: "물고기", age: 1), at: 2)
//            self.list.remove(at: 1)
//            self.updateSnapshot() //reloedData 대신!
//        }
        
    }
    
    func updateSnapshot() {
        //Diffable 디퍼블 3. number~ 처리 ---------------------------------
        var snapshot = NSDiffableDataSourceSnapshot<String, User>() //스냅샷 찍을 수 있게 도와주는 구조체, dataSource와 타입 맞추기
        snapshot.appendSections(["SeSAC 섹션", "생각 섹션"])//섹션 1개, 배열 타입인데 개별 섹션이라 [0,1,2,3] 섹션 4개 쓸 때 근데 이게 인덱스가 아님. 그냥 섹션의 고유숫자! 100,120 이렇게 해도 가능

        //4. 오류난 지점
        //snapshot.appendItems(list) //list의 엘리먼트 수 만큼
        snapshot.appendItems(viewModel.list.value, toSection: "SeSAC 섹션")
        snapshot.appendItems(viewModel.list2, toSection: "생각 섹션") //1번 섹션에 넣을게 - 나중에 열거형으로
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
            content.secondaryText = "\(itemIdentifier.age)살"
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

extension SimpleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //4-1. 셀을 선택했을 때! (4-2는 뷰 모델에!)
//        viewModel.removeUser(idx: indexPath.item)
        
        //6-1. 만약 셀 정보를 다음 화면ㅇㅔ 넘긴다면?
        let user = viewModel.list.value[indexPath.item] //이건 인덱스 기반
        //6-2. 디퍼블이니까 인덱스XXX 모델 자체를 빼오기
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            //해당 데이터가 없다면? 얼럿이나 토스트. 문제가있으니 다시시도 해달라
            return
        }
//        print(user)
        dump(user)
    }
    
}

//5-2.
extension SimpleCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //5-4.
        viewModel.insertUser(name: searchBar.text!) //나중에 옵셔널 처리도 뷰 모델
    
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


