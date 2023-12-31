//
//  RandomPhotoViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/18.
//

import UIKit
import SnapKit

final class RandomPhotoViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout())
        view.backgroundColor = .brown
        return view
    }()
    
    var viewModel = RandomViewModel()
    
    var dataSource: UICollectionViewDiffableDataSource<Int, RandomPhoto>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        
        viewModel.fetchRandomPhoto()
        
        configureDataSource()
        
        viewModel.list.bind { _ in
            self.updateSnapshot()
        }

    }
    
    @objc private func randomButtonClicked() {
        viewModel.removeList()
        viewModel.fetchRandomPhoto()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, RandomPhoto>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.list.value)
        dataSource.apply(snapshot)
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, RandomPhoto> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.altDescription
            content.textProperties.alignment = .center
            content.textProperties.font = .systemFont(ofSize: 15, weight: .medium)
            
            self.viewModel.setCellRegistrationPhoto(randomImage: itemIdentifier) { data in
                content.image = UIImage(data: data)
                content.imageProperties.cornerRadius = 10
                cell.contentConfiguration = content
            }
            
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            
            return cell
        })
    }
    
    private func layout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .white
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configure() {
        title = "랜덤 이미지"
        view.addSubview(collectionView)
        
        view.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "랜덤", style: .plain, target: self, action: #selector(randomButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        setConstraints()
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
