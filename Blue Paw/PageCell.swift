//
//  PageCell.swift
//  Blue Paw
//
//  Created by Алексей Пархоменко on 16/12/2018.
//  Copyright © 2018 Алексей Пархоменко. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var pageSetup: Page! {
        didSet {
            guard let imageName = pageSetup.imageName,
                  let headerText = pageSetup.headerText else {
                    return }
            
            profileImage.image = UIImage(named: "\(imageName)")
            
            let attributedText = NSMutableAttributedString(string: headerText,
                                                           attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18, weight: .heavy)])
            attributedText.append(NSAttributedString(string: "\n\n\(pageSetup.bodyText ?? "Nothing(")",
                                                     attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13),
                                                                  NSAttributedString.Key.foregroundColor : UIColor.gray]))
            
            descriptionTextView.attributedText = attributedText
            descriptionTextView.textAlignment = .center
        }
    }
    
    private let topImageContainerView: UIView! = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     private let profileImage: UIImageView! = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
        imageView.image = UIImage(named: "Albert")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private var descriptionTextView: UITextView! = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .purple
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        
        addSubview(topImageContainerView)
        addSubview(descriptionTextView)
        
//         the leading and trailing anchors better to use then left and right anchors because certail languages such as
//         Arabic it's a language that goes from fight to left so leading and trailing anchors is going to be aware of if the
//         language is right to left ot left to right you don't have to worry about so much what the language orientation so
//         Apple recommends to use leading and trailing
        
        // topImageContainerView constraints
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topImageContainerView.addSubview(profileImage)
        
        
        // profileImage constraints
        profileImage.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        profileImage.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        
        // descriptionTextView constraints
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor).isActive = true
        descriptionTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        descriptionTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
}

