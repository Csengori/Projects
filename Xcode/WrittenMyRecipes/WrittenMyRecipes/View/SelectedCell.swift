//
//  SelectedCell.swift
//  WrittenMyRecipes
//
//  Created by Tamas Sagi on 23/04/2018.
//  Copyright © 2018 Tamas Sagi. All rights reserved.
//

import UIKit

class SelectedCell: UIViewController {
    
    var passedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        recipeImage.image = passedImage
        view.backgroundColor = .grayColor
    }
    
    @objc private func handleBottomArrow(){
        let destination = IngredientsStepsViewController()
        destination.navigationItem.title = self.navigationItem.title
        navigationController?.pushViewController(destination, animated: true)
        
    }
    
    private func setupViews(){
        view.addSubview(placeHolder)
        placeHolder.addSubview(mainsStack)
        placeHolder.addSubview(bottomArrowButton)
        mainsStack.addArrangedSubview(recipeImage)
        mainsStack.addArrangedSubview(bottomStack)
        setupBottomStacks()
    }
    
    private func setupConstraints(){
        setupViews()
        NSLayoutConstraint.activate([
            placeHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            placeHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            placeHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            placeHolder.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            mainsStack.topAnchor.constraint(equalTo: placeHolder.topAnchor, constant: 0),
            mainsStack.trailingAnchor.constraint(equalTo: placeHolder.trailingAnchor, constant: 0),
            mainsStack.leadingAnchor.constraint(equalTo: placeHolder.leadingAnchor, constant: 0),
            mainsStack.bottomAnchor.constraint(equalTo: bottomArrowButton.topAnchor, constant: -8),
            
            bottomArrowButton.heightAnchor.constraint(equalTo: placeHolder.heightAnchor, multiplier: 0.1),
            bottomArrowButton.centerXAnchor.constraint(equalTo: placeHolder.centerXAnchor),
            bottomArrowButton.bottomAnchor.constraint(equalTo: placeHolder.bottomAnchor, constant: -8)
            ])
    }
    
    private func setupBottomStacks(){
        bottomStack.addArrangedSubview(timeStack)
        bottomStack.addArrangedSubview(ingredientsStack)
        bottomStack.addArrangedSubview(servingsStack)
        
        setupIngredientStack()
        setupDurationStack()
        setupServingStack()
    }
    
    private let tempView: UIView = {
        let leftTemp = UIView()
        return leftTemp
    }()
    
    private func setupDurationStack(){
        timeStack.addArrangedSubview(potImage)
        timeStack.addArrangedSubview(minuteLabel)
        timeStack.addArrangedSubview(bottomMinuteLabel)
    }
    
    private  func setupIngredientStack(){
        ingredientsStack.addArrangedSubview(cartImage)
        ingredientsStack.addArrangedSubview(ingredientLabel)
        ingredientsStack.addArrangedSubview(bottomIngredientLabel)
    }
    
    private func setupServingStack(){
        servingsStack.addArrangedSubview(peopleImage)
        servingsStack.addArrangedSubview(servingsLabel)
        servingsStack.addArrangedSubview(bottomServingsLabel)
    }
    
    private let placeHolder: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 0
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let recipeImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let potImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "pot"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let cartImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "cart"))
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let bottomArrowButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(#imageLiteral(resourceName: "downArrow"), for: .normal)
        btn.addTarget(self, action: #selector(handleBottomArrow), for: .touchUpInside)
        btn.contentMode = .scaleAspectFit
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let peopleImage: UIImageView = {
        let image = UIImageView(image: #imageLiteral(resourceName: "person"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let bottomMinuteLabel: UILabel = {
        let label = UILabel()
        label.text = "Minutes"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .selectedCellLabelColors
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomServingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Servings"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .selectedCellLabelColors
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bottomIngredientLabel: UILabel = {
        let label = UILabel()
        label.text = "Ingredients"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .selectedCellLabelColors
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let minuteLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .selectedCellNumberColors
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ingredientLabel: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .selectedCellNumberColors
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let servingsLabel: UILabel = {
        let label = UILabel()
        label.text = "20"
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .selectedCellNumberColors
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let timeStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 8
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let ingredientsStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 8
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let servingsStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 8
        sv.distribution = .equalSpacing
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let bottomStack: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .center
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let mainsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
}
