//
//  MainCell.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 23/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    private let placeHolder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "randomImage"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.text = "Category Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.text = "Title Label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 0
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private func setupViews(){
        addSubview(placeHolder)
        placeHolder.addSubview(image)
        placeHolder.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(categoryLabel)
    }
    
    private func setupViewConstraints(){
        setupViews()
        
        NSLayoutConstraint.activate([
            
            placeHolder.topAnchor.constraint(equalTo: topAnchor),
            placeHolder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            placeHolder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            placeHolder.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            image.topAnchor.constraint(equalTo: placeHolder.topAnchor, constant: 0),
            image.heightAnchor.constraint(equalTo: placeHolder.heightAnchor, multiplier: 0.7),
            image.trailingAnchor.constraint(equalTo: placeHolder.trailingAnchor),
            image.leadingAnchor.constraint(equalTo: placeHolder.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: image.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: placeHolder.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: placeHolder.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: placeHolder.bottomAnchor, constant: -16),
            
            ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
