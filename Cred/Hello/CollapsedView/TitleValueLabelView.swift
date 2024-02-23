//
//  TitleValueLabelView.swift
//  Hello
//
//  Created by Siddhartha Khanna on 17/09/23.
//

import UIKit

final class TitleValueLabelView: UIView {
    
    struct TitleValueViewModel {
        let title: NSAttributedString
        let value: NSAttributedString
    }
    
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let titleLabel: UILabel = .init()
    
    private let valueLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TitleValueLabelView {
    
    func commonInit() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
    }
    
    func setupConstraints() {
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
    }
}


extension TitleValueLabelView {
    
    func configure(viewModel: TitleValueViewModel) {
        self.titleLabel.attributedText = viewModel.title
        self.valueLabel.attributedText = viewModel.value
    }
    
}
