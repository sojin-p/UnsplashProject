//
//  PhotoViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {
    //1-1. 컬렉션 뷰로 교체(스토리보드도), 테이블뷰 관련코드 날리기
    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel = PhotoViewModel()
    
    //3-1. 섹션과 사용할 데이터 타입 정의
    var dataSource: UICollectionViewDiffableDataSource<Int, PhotoResult>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1-2. 스토리보드에서 네비 임베드 후 서치바 만들기
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        //2-2.
        collectionView.collectionViewLayout = createLayout()
        //5. 호출
        configureDataSource()
        
        //6-1. list가 달라지면 갱신(스냅샷)
        viewModel.list.bind { _ in
            self.updateSnapshot()
        }
        
    } //viewDidLoad
    
    //6-2.
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PhotoResult>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.list.value.results!) //data.results 매개변수 활용해도!
        dataSource.apply(snapshot)
    }
    
    //2-1.
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped) //side~ 보통 아이패드에서 사용
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGray4
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    //3-2. / Photo모델에 Hashable 모두 붙이기
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, PhotoResult> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = "\(itemIdentifier.likes)"
            
            //4. 이미지 처리
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.urls.thumb)!
                let data = try? Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content // 얘가 밖에 있으면 텍스트밖에 안 보임! 다른 알바생이 처리하고 바로 다음 줄이 실행되니까
                }
            }
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
} //UIViewController

extension PhotoViewController: UISearchBarDelegate {
    //1-3. 서치바 딜리게이트
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchData(text: searchBar.text!)
    }
    
}
