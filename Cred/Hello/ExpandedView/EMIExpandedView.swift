//
//  EMIExpandedView.swift
//  Hello
//
//  Created by Siddhartha Khanna on 17/09/23.
//

import UIKit


final class EMIExpandedView: UIView {
    
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 25
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How to pay "
        label.textColor = .white
       return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.text = "choose plans"
        label.textColor = .white
       return label
    }()
    
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.spacing = 15
        view.distribution = .fillProportionally
        return view
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Create plan", for: .normal)
        button.contentEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = CustomColor.emiBackground.uiColor
        self.layer.cornerRadius = 24
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension EMIExpandedView {
    
    func commonInit() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        stackView.setCustomSpacing(10, after: titleLabel)
        stackView.addArrangedSubview(containerView)
        containerView.addArrangedSubview(customChildView)
        containerView.addArrangedSubview(customChildView)
        containerView.addArrangedSubview(customChildView)
        stackView.addArrangedSubview(button)
    }
    
    var customChildView: UIView {
        let customView = UIView()
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        customView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        customView.backgroundColor = .green.withAlphaComponent(0.3)
        return customView
    }
    
    func setupConstraints() {
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -50).isActive = true
    }
}

