//
//  RandomViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/18.
//

import Foundation

class RandomViewModel {
    
    var list: Observable<[RandomPhoto]> = Observable([])
    
    func removeList() {
        list.value = []
    }
    
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
    } //fetchRandomPhoto()
    
    func setCellRegistrationPhoto(randomImage: RandomPhoto, completion: @escaping (Data) -> Void) {
        
        DispatchQueue.global().async {
            if let url = URL(string: randomImage.urls.thumb), let data = try? Data(contentsOf: url ) {
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
    }
    
}//RandomViewModel
