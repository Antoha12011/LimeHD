//
//  MenuBar.swift
//  LimeHD
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit

protocol MenuBarDelegate: AnyObject {
    func scrollToIndexItem(_ index: Int)
}

final class MenuBar: UIView {
    
    // MARK: - Public Properties
    
    let titles: [String]
    weak var delegate: MenuBarDelegate?
    lazy var collectionView: UICollectionView = {
        let cvLayout = UICollectionViewFlowLayout()
        cvLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: cvLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        self.titles = ["Все", "Избранное"]
        super.init(frame: frame)
        addSubview(collectionView)
        setupConstraints()
        setupCollection()
    }
    
    // MARK: - Private Methods
    
    private func setupCollection() {
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.cellId)
        let indexPath = IndexPath(row: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.scrollToIndexItem(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.cellId, for: indexPath) as! MenuCell
        cell.setupCell(whithTitle: titles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = NSString(string: titles[indexPath.row]).size(withAttributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)])
        return CGSize(width: (size.width + 16), height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
