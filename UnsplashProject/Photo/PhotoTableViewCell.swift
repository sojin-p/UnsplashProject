//
//  PhotoTableViewCell.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/12.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
    
    func configureCell(viewModel: PhotoViewModel, indexPath: IndexPath) {
        viewModel.fetchPhoto(at: indexPath, completion: { data in
            self.photoImageView.image = UIImage(data: data)
        })
    }

}
