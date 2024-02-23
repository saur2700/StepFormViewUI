//
//  EMICollapsedView.swift
//  Hello
//
//  Created by Siddhartha Khanna on 17/09/23.
//

import UIKit

final class EMICollapsedView: UIView {
    private let stackView: UIStackView = {
        let stackView: UIStackView = .init()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let emiTitleValueLabel: TitleValueLabelView = .init(frame: .zero)
    
    private let durationTitleValueLabel: TitleValueLabelView = .init(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(emiViewModel: TitleValueLabelView.TitleValueViewModel,
                   durationViewModel: TitleValueLabelView.TitleValueViewModel) {
        self.emiTitleValueLabel.configure(viewModel: emiViewModel)
        self.durationTitleValueLabel.configure(viewModel: durationViewModel)
    }
}

private extension EMICollapsedView {
    
    func commonInit() {
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        self.addSubview(stackView)
        stackView.addArrangedSubview(emiTitleValueLabel)
        stackView.addArrangedSubview(durationTitleValueLabel)
    }
    
    func setupConstraints() {
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor).isActive = true
    }
}
