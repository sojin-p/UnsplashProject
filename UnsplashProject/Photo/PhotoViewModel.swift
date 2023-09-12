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
    func fetchPhoto() {
        APIService.shared.searchPhoto(query: "sky") { photo in
            guard let photo else {
                return
            }
            self.list.value = photo //list.value 리스트의 실질적 데이터는 밸류에 있음
        }
    }
    
}

