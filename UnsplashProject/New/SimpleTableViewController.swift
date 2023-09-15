//
//  SimpleTableViewController.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/14.
//

import UIKit

class SimpleTableViewController: UITableViewController {
    
    var list = [User(name: "Hue", age: 31), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = list[indexPath.row].name
        content.secondaryText = "\(list[indexPath.row].age)"
        cell.contentConfiguration = content
        //더이상 시스템셀이 4가지가 아니다 더 있당
        return cell
    }
}
