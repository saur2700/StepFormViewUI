//
//  CollapsedView.swift
//  Hello
//
//  Created by Siddhartha Khanna on 16/09/23.
//

import UIKit

protocol CollapsedViewDelegate: AnyObject {
    func expandButtonTapped()
}

final class CollapsedView<T: UIView>: UIView {
    
    private let contentView: T
    private let expandButton: UIButton = .init()
    weak var delegate: CollapsedViewDelegate?
    
    init(contentView: T) {
        self.contentView = contentView
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        self.delegate?.expandButtonTapped()
    }
}

private extension CollapsedView {
    
    func commonInit() {
        setupUI()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupUI() {
        expandButton.setImage(.init(systemName: "chevron.down"), for: .normal)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        expandButton.translatesAutoresizingMaskIntoConstraints = false
        expandButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        self.addSubview(contentView)
        self.addSubview(expandButton)
    }
    
    func setupConstraints() {
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.expandButton.leadingAnchor).isActive = true
        expandButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        expandButton.trailingAnchor
            .constraint(equalTo: self.trailingAnchor, constant: -20)
            .isActive = true
        expandButton.heightAnchor.constraint(equalTo: expandButton.widthAnchor, multiplier: 1).isActive = true
        contentView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
