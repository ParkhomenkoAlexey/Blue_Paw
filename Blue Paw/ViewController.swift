//
//  ViewController.swift
//  Blue Paw
//
//  Created by Алексей Пархоменко on 16/12/2018.
//  Copyright © 2018 Алексей Пархоменко. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let topImageContainerView: UIView! = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImage: UIImageView! = {
        let imageView = UIImageView()
        //imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        imageView.image = UIImage(named: "Albert")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var descriptionTextView: UITextView! = {
        let textView = UITextView()
        let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!",
                                                attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: .heavy)])
        attributedText.append(NSAttributedString(string: "\n\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.",
                                                 attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
                                                              NSAttributedString.Key.foregroundColor : UIColor.gray]))
//        textView.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
//        textView.text = "Join us today in our fun and games!"
//        textView.textColor = UIColor.black
        textView.attributedText = attributedText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return textView
    }()
    
    private let previousButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .red
        return button
    }()
    
    private let nextButton: UIButton! = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .red
        return button
    }()
    
    private let pageControl: UIPageControl! = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(topImageContainerView)
        view.addSubview(descriptionTextView)
        setupLayout()
        setupButtomControls()
        
    }

    fileprivate func setupButtomControls() {
        
        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlStackView)
        
        // bottomControlStackView constraints
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    private func setupLayout() {
        
        // the leading and trailing anchors better to use then left and right anchors because certail languages such as
        // Arabic it's a language that goes from fight to left so leading and trailing anchors is going to be aware of if the
        // language is right to left ot left to right you don't have to worry about so much what the language orientation so
        // Apple recommends to use leading and trailing
        
        // topImageContainerView constraints
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.addSubview(profileImage)

        
        // profileImage constraints
        profileImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        profileImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
    
        // descriptionTextView constraints
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }

}

