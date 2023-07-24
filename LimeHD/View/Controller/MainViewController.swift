//
//  ViewController.swift
//  parse
//
//  Created by Антон Павлов on 28.04.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var networkService = NetworkService()
    
    private var subViews: [ChannelsView]? {
        didSet {
            guard let subViews else { return }
            setupScrollView(subViews: subViews)
        }
    }
    
    private lazy var statusBarBack: UIView = {
        let sbb = UIView()
        sbb.translatesAutoresizingMaskIntoConstraints = false
        sbb.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1)
        return sbb
    }()
    
    private lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.delegate = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    private lazy var seachBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = UISearchBar.Style.default
        sb.placeholder = "Напишите название телеканала"
        sb.sizeToFit()
        sb.isTranslucent = false
        sb.backgroundImage = UIImage()
        sb.delegate = self
        return sb
    }()
    
    private lazy var scrollView: UIScrollView = {
        let cv = UIScrollView()
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.bounces = false
        return cv
    }()
    
    // MARK: - Override
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = .black
        navigationItem.titleView = seachBar
        fetchChannels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationAppearence()
        AppUtility.lockOrientation(.portrait)
    }
    
    // MARK: - Public Methods
    
    func fetchChannels() {
        guard let url = URL(string: "http://limehd.online/playlist/channels.json") else { return }
        networkService.fetchChannels(url: url) { [weak self] result in
            switch result {
            case .success(let channels):
                DispatchQueue.main.async {
                    self?.subViews = [ChannelsView(channels: channels, isFavotire: false),
                                      ChannelsView(channels: channels, isFavotire: true)]
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.addSubview(statusBarBack)
        view.addSubview(scrollView)
        view.addSubview(menuBar)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: menuBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60),
            NSLayoutConstraint(item: menuBar, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: menuBar, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: statusBarBack, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: statusBarBack, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44 + 60),
            
            NSLayoutConstraint(item: statusBarBack, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: statusBarBack, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: menuBar, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: scrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0),
        ])
    }
    
    private func setupScrollView(subViews: [ChannelsView]) {
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(subViews.count), height: scrollView.frame.height)
        for i in 0..<subViews.count {
            subViews[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                       y: 0,
                                       width: scrollView.frame.width,
                                       height: scrollView.frame.height)
            subViews[i].delegate = self
            scrollView.addSubview(subViews[i])
        }
    }
}

// MARK: - Extensions

extension MainViewController: UISearchBarDelegate {
    
}

extension MainViewController {
    private func setNavigationAppearence() {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.22, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
    }
}

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let row = Int(targetContentOffset.pointee.x / scrollView.frame.width)
        let indexPath = IndexPath(row: row, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .init())
        if row == 1 {
            subViews?[row].collectionView.reloadData()
        }
    }
}

extension MainViewController: MenuBarDelegate {
    func scrollToIndexItem(_ index: Int) {
        scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(index), y: 0), animated: true)
    }
}

extension MainViewController: ChannelsViewDelegate {
    func pushVideoPlayer(_ url: URL) {
        let vc = PlayerViewController(url: url)
        self.present(vc, animated: true)
    }
    
    func reloadView(_ favorites: [Channel], fromFavorites: Bool) {
        switch fromFavorites {
        case true:
            subViews?[0].collectionView.reloadData()
        case false:
            subViews?[1].favoriteChanels = favorites
            subViews?[1].collectionView.reloadData()
        }
    }
}
