//
//  ViewController.swift
//  Hello
//
//  Created by Siddhartha Khanna on 30/08/23.
//

import UIKit
import StepFormView

final class ViewController: UIViewController {
    
    private enum Step: Int, CaseIterable {
        case creditAmount
        case emiSelection
        case bankAccount
        
        var buttonTitle: String {
            switch self {
            case .emiSelection:
                return "Select your Bank Account"
            case .creditAmount:
                return "Proceed to EMI Selection"
            case .bankAccount:
                return "Tap for 1-click KYC"
            }
        }
        
    }
    
    public let stepFormView: StepFormView = {
        let stepFormView: StepFormView = .init()
        stepFormView.translatesAutoresizingMaskIntoConstraints = false
        return stepFormView
    }()
    
    private let bottomButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setTitleColor(CustomColor.buttonTitle.uiColor, for: .normal)
        button.backgroundColor = CustomColor.buttonBackground.uiColor
        button.layer.cornerRadius = 24
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    private let crossButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(.init(systemName: "xmark"), for: .normal)
        button.tintColor = CustomColor.buttonTitle.uiColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = CustomColor.bankBackground.uiColor
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private let helpButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.setImage(.init(systemName: "questionmark"), for: .normal)
        button.tintColor = CustomColor.buttonTitle.uiColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        button.backgroundColor = CustomColor.bankBackground.uiColor
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }()
    
    private let topContainerView: UIView = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
    }
}

private extension ViewController {
    func commonInit() {
        setupUI()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupUI() {
        self.view.backgroundColor = CustomColor.background.uiColor
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        stepFormView.delegate = self
        stepFormView.dataSource = self
    }
    
    func setupHierarchy() {
        self.view.addSubview(stepFormView)
        self.view.addSubview(bottomButton)
        self.topContainerView.addSubview(crossButton)
        self.topContainerView.addSubview(helpButton)
        self.view.addSubview(topContainerView)
        topContainerView.backgroundColor = CustomColor.background.uiColor
        
    }
    
    func setupConstraints() {
        crossButton.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        crossButton.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor, constant: 25).isActive = true
        helpButton.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor).isActive = true
        helpButton.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: -25).isActive = true
        topContainerView.translatesAutoresizingMaskIntoConstraints = false
        stepFormView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        stepFormView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topContainerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        topContainerView.leadingAnchor
            .constraint(equalTo: self.view.leadingAnchor).isActive = true
        topContainerView.trailingAnchor
            .constraint(equalTo: self.view.trailingAnchor).isActive = true
        topContainerView.heightAnchor
            .constraint(equalToConstant: 100).isActive = true
        stepFormView.topAnchor.constraint(equalTo: topContainerView.bottomAnchor).isActive = true
        stepFormView.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor).isActive = true
        bottomButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomButton.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
    
    @objc func bottomButtonTapped() {
        if !stepFormView.next() {
            print("proceed to next flow")
        }
    }
    
}

extension ViewController: StepFormViewDelegate {
    
    func stepFormView(willMoveTo index: Int) {
        self.bottomButton.isEnabled = false
        let step = Step.init(rawValue: index)
        self.bottomButton.setTitle(step?.buttonTitle, for: .normal)
        switch step {
        case .none:
            break
        case .creditAmount:
            self.stepFormView.stackView.backgroundColor = CustomColor.background.uiColor
            self.stepFormView.backgroundColor = CustomColor.creditBackground.uiColor
        case .emiSelection:
            self.stepFormView.stackView.backgroundColor = CustomColor.creditBackground.uiColor
            self.stepFormView.backgroundColor = CustomColor.emiBackground.uiColor
        case .bankAccount:
            self.stepFormView.stackView.backgroundColor = CustomColor.emiBackground.uiColor
            self.stepFormView.backgroundColor = CustomColor.bankBackground.uiColor
        }
    }
    
    func stepFormView(didMoveTo index: Int) {
        self.bottomButton.isEnabled = true
    }
}


extension ViewController: StepFormViewDataSource {
    func numberOfSteps() -> Int {
        Step.allCases.count
    }
    
    private func collapsedContentView(_ step: ViewController.Step?)
    -> (collapsedView: UIView?,
        backgroundColor: UIColor?) {
        let collapsedContentView: UIView?
        let backgroundColor: UIColor?
        switch step {
        case .none:
            collapsedContentView = nil
            backgroundColor = nil
        case .emiSelection:
            let emiCollapsedView = EMICollapsedView(frame: .zero)
            let emiTitleText = NSAttributedString.withAttributes("EMI", color: .white.withAlphaComponent(0.5), fontSize: 14, weight: .medium)
            let emiValueText = NSAttributedString.withAttributes("Value", color: .white.withAlphaComponent(0.5), fontSize: 20, weight: .bold)
            
            let emiViewModel = TitleValueLabelView.TitleValueViewModel.init(title: emiTitleText,
                                                                            value: emiValueText)
            let durationTitleText = NSAttributedString.withAttributes("Duration", color: .white.withAlphaComponent(0.5), fontSize: 14, weight: .medium)
            let durationValueText = NSAttributedString.withAttributes("Value", color: .white.withAlphaComponent(0.5), fontSize: 20, weight: .bold)
            
            let durationViewModel = TitleValueLabelView.TitleValueViewModel.init(title: durationTitleText,
                                                                                 value: durationValueText)
            emiCollapsedView.configure(emiViewModel: emiViewModel, durationViewModel: durationViewModel)
            collapsedContentView = emiCollapsedView
            backgroundColor = CustomColor.emiBackground.uiColor
        case .creditAmount:
            let titleValueLabel = TitleValueLabelView.init(frame: .zero)
            let titleText = NSAttributedString.withAttributes("Credir", color: .white.withAlphaComponent(0.5), fontSize: 14, weight: .medium)
            let valueText = NSAttributedString.withAttributes("Value", color: .white.withAlphaComponent(0.5), fontSize: 20, weight: .bold)
            let viewModel = TitleValueLabelView.TitleValueViewModel.init(title: titleText,
                                                                         value: valueText)
            titleValueLabel.configure(viewModel: viewModel)
            collapsedContentView = titleValueLabel
            backgroundColor = CustomColor.creditBackground.uiColor
        case .bankAccount:
            collapsedContentView = nil
            backgroundColor = nil
        }
        return (collapsedContentView, backgroundColor)
    }
    
    func stepFormView(collapsedViewFor index: Int) -> UIView? {
        let step = Step.init(rawValue: index)
        let collapsedContentViewAndBackground = self.collapsedContentView(step)
        guard let collapsedContentView = collapsedContentViewAndBackground.collapsedView else {
            return nil
        }
        let collapsedView: CollapsedView = .init(contentView: collapsedContentView)
        collapsedView.delegate = self
        collapsedView.backgroundColor = collapsedContentViewAndBackground.backgroundColor
        return collapsedView
    }
    
    func stepFormView(expandedViewFor index: Int) -> UIView? {
        let expandedView: UIView?
        let step = Step.init(rawValue: index)
        switch step {
        case .none:
            expandedView = nil
        case .emiSelection:
            expandedView = EMIExpandedView.init(frame: .zero)
        case .creditAmount:
            expandedView = CreditAmountExpandedView.init(frame: .zero)
        case .bankAccount:
            expandedView = BankAccountExpandedView.init(frame: .zero)
        }
        return expandedView
    }
    
}

extension ViewController: CollapsedViewDelegate {
    func expandButtonTapped() {
        self.stepFormView.previous()
    }
    
}
