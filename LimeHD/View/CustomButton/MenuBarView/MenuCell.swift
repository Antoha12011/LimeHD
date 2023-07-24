//
//  MenuCell.swift
//  LimeHD
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit

final class MenuCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    
    static let cellId = "MenuCell"
    
    // MARK: - Private Properties
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lineHeightConstraint: NSLayoutConstraint = NSLayoutConstraint.init(item: line, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
    
    lazy private var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0.47, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Ovveride
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .white : .gray
            switch isSelected {
            case true:
                lineHeightConstraint.constant = 3
            case false:
                lineHeightConstraint.constant = 0
            }
            UIView.animate(withDuration: 0.15, delay: 0, options: .curveEaseInOut, animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setupCell(whithTitle title: String) {
        self.titleLabel.text = title
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8),
            NSLayoutConstraint.init(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 8),
            
            NSLayoutConstraint.init(item: line, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: line, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.frame.width),
            lineHeightConstraint,
            NSLayoutConstraint.init(item: line, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
        ])
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(line)
    }
}
