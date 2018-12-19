//
//  SwipingController + extension.swift
//  Blue Paw
//
//  Created by Алексей Пархоменко on 19/12/2018.
//  Copyright © 2018 Алексей Пархоменко. All rights reserved.
//

import Foundation
import UIKit

extension SwipingController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
            
            // fix first screen bug
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }) { (bear_) in
            
        }
        
    }
    
}
