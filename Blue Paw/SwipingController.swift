//
//  SwipingController.swift
//  Blue Paw
//
//  Created by Алексей Пархоменко on 16/12/2018.
//  Copyright © 2018 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let pages = [
        Page(imageName: "Albert", headerText: "HeHelloHelloHellHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHeHeHelloHelloHelloHellollolloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellolloHeHelloHelloHelloHellollooHellollo", bodyText: "111111"),
        Page(imageName: "Steve", headerText: "STTTTT", bodyText: nil),
        Page(imageName: "Mark", headerText: "fdsfdf", bodyText: "33333"),
        Page(imageName: "Albert", headerText: "Hello", bodyText: "111111"),
        Page(imageName: "Steve", headerText: "STTTTT", bodyText: nil),
        Page(imageName: "Mark", headerText: "fdsfdf", bodyText: "33333")
    ]
    
    private let previousButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)
        return button
    }()
    
     private let nextButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
     lazy var pageControl: UIPageControl! = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
     var bottomControlStackView: UIStackView! = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.isPagingEnabled = true
        setupButtomControls()
    }
    
    fileprivate func setupButtomControls() {
        
        bottomControlStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        view.addSubview(bottomControlStackView)
        
        // bottomControlStackView constraints
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
    
    @objc private func handlePrev() {
//        let prevIndex = max(pageControl.currentPage - 1, 0)
//        let indexPath = IndexPath(item: prevIndex, section: 0)
//        pageControl.currentPage = prevIndex
//        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
