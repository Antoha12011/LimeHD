//
//  ChannelCell.swift
//  LimeHD
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit

final class ChannelCell: UICollectionViewCell {
    
    // MARK: - Static Properties
    
    static let cellId = "ChannelCell"
    
    // MARK: - Public Properties
    
    var networkService: NetworkService?
    var id: Int?
    
    lazy var starButton: Button = {
        let button = Button()
        let imageDefault = UIImage(named: "starImageDefault")
        let imageSelected = UIImage(named: "starImageSelected")
        button.setImage(imageDefault, for: .normal)
        button.setImage(imageSelected, for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Private Properties
    
    private lazy var channelImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var activiyIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView()
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.startAnimating()
        return ai
    }()
    
    private lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var channelTitle: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var broadcastTitle: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Override
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1)
        layer.cornerRadius = 10
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func setupCell(whithChannel channel: Channel) {
        id = channel.id
        channelTitle.text = channel.nameRu
        broadcastTitle.text = channel.current.title
        
        guard let url = URL(string: channel.image), let networkService else { return }
        networkService.fetchImage(url: url) { image in
            DispatchQueue.main.async {
                guard let image else { return }
                self.channelImage.image = image.withRenderingMode(.alwaysOriginal)
                self.channelImage.backgroundColor = nil
                self.activiyIndicator.stopAnimating()
                self.activiyIndicator.isHidden = true
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        addSubview(channelImage)
        addSubview(activiyIndicator)
        vStack.addArrangedSubview(channelTitle)
        vStack.addArrangedSubview(broadcastTitle)
        addSubview(vStack)
        addSubview(starButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint.init(item: channelImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: channelImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60),
            NSLayoutConstraint.init(item: channelImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60),
            NSLayoutConstraint.init(item: channelImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 8),
            
            NSLayoutConstraint(item: activiyIndicator, attribute: .centerX, relatedBy: .equal, toItem: channelImage, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: activiyIndicator, attribute: .centerY, relatedBy: .equal, toItem: channelImage, attribute: .centerY, multiplier: 1, constant: 0),
            
            NSLayoutConstraint.init(item: starButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: starButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32),
            NSLayoutConstraint.init(item: starButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 32),
            NSLayoutConstraint.init(item: starButton, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -8),
            
            NSLayoutConstraint.init(item: vStack, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: vStack, attribute: .left, relatedBy: .equal, toItem: channelImage, attribute: .right, multiplier: 1, constant: 8),
            NSLayoutConstraint.init(item: vStack, attribute: .right, relatedBy: .lessThanOrEqual, toItem: starButton, attribute: .left, multiplier: 1, constant: -8),
        ])
    }
}
