//
//  RandomViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/18.
//

import Foundation

class RandomViewModel {
    
    var list: Observable<[RandomPhoto]> = Observable([])
    
    func fetchRandomPhoto() {
        APIService.shared.fetchRandomPhoto { photo in
            DispatchQueue.main.async {
                guard let photo else {
                    return
                }
                self.list.value.append(photo)
                print(photo)
                print("---------",self.list.value)
            }
        }
    }
}
