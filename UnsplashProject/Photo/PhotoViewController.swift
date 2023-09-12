//
//  PhotoViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function, "PhotoVC")
        
        viewModel.fetchPhoto()
        
        //리스트 데이터가 바뀌면 뭘 해줄래?
        viewModel.list.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    } //viewDidLoad
    
} //UIViewController

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell")!
        
        let data = viewModel.cellForRowAt(at: indexPath)
        
        cell.backgroundColor = .lightGray
        
        return cell
    }
}
