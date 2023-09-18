//
//  PhotoViewModel.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import Foundation

class PhotoViewModel {
    
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    var numberOfRowsInSection: Int {
        return list.value.results?.count ?? 0
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results![indexPath.row]
    }
    
    //네트워크 통신 (<b>이런거 지우거나 넘버포매터를 써야하거나 할 때. 대신 엄청 여러화면이면 익스텐션으로 빼는 것이..)
    func fetchData(text: String) { //7-1. text 매개변수
        APIService.shared.searchPhoto(query: text) { photo in
            DispatchQueue.main.async { //7-2. 통신반 글로벌, 나머지는 메인에서 처리
                guard let photo else {
                    return
                }
                self.list.value = photo //list.value 리스트의 실질적 데이터는 밸류에 있음
            }
        }
    }
    
    func fetchPhoto(at indexPath: IndexPath, completion: @escaping (Data) -> Void) {
        
        DispatchQueue.global().async {
            if let url = URL(string: self.list.value.results?[indexPath.row].urls.thumb ?? ""), let data = try? Data(contentsOf: url ) {
                
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
    }
    
}



