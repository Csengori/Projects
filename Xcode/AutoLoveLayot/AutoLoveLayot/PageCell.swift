//
//  PageCell.swift
//  AutoLoveLayot
//
//  Created by Tamas Sagi on 06/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet{
            guard let unwrappedPage = page  else {
                return
            }
            forestImage.image = UIImage(named: unwrappedPage.imageName)
            
            let attributedString = NSMutableAttributedString(string: unwrappedPage.headerText , attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)])
            
            attributedString.append(NSMutableAttributedString(string: "\n \n \n \(unwrappedPage.descriptionText)", attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 15),                                                                                                                NSAttributedStringKey.foregroundColor : UIColor.gray]))
            
            descriptionTextView.attributedText = attributedString
            descriptionTextView.textAlignment = .center
        }
    }
    
    private  let forestImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "forest"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    
    private func layoutConstraints(){
        addSubview(containerView)
        containerView.addSubview(forestImage)
        addSubview(descriptionTextView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            forestImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            forestImage.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            forestImage.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5),
            forestImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            
            descriptionTextView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)])
    }
    
   
  
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layoutConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
