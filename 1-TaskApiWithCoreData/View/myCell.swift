//
//  TableViewCell.swift
//  1-TaskApiWithCoreData
//
//  Created by Mobile Team on 15/03/2022.
//

import UIKit
import CoreData

class myCell: UITableViewCell {

    let image = UIImageView()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupImage()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImage() {
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 70).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15).isActive = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 35
    }
    
    func setupLabel(){
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: image.trailingAnchor,constant: 15 ).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.textColor = .black
        label.font = .systemFont(ofSize: 15 , weight : .heavy)
    }
    
    
    func setup (u : User){
        DispatchQueue.main.async { [weak self] in
            self?.label.text = u.login
        }

        guard let url = u.avatar_url else {
            return
        }
        
        if let data = try? Data(contentsOf: url){
            if let loadImage = UIImage(data: data){
                DispatchQueue.main.async { [weak self ] in
                    self?.image.image = loadImage
                }
                
            }
        }
    }
    
    
    
}
