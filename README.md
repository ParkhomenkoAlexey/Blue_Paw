# Blue_Paw
Use auto layout in iOS application from scratch all programmatically without using the Storyboard. Go over exactly how to layout every object by using NSLayoutAnchor. Handle landscape orientation using a few auto layout tricks.

## What I have done
 
![Blue_Paw](https://github.com/ParkhomenkoAlexey/Images/blob/master/bluePaw.gif)

## What you will learn

- [Theory about leading and trailing anchors](#Theory-about-leading-and-trailing-anchors)
- [Theory about private and lazy](#Theory-about-private-and-lazy)
- [How to change image size when device orientation changes](#How-to-change-image-size-when-device-orientation-changes)
- [How to create CollectionViewController like PageViewController](#How-to-create-CollectionViewController-like-PageViewController)
- [How to create StackView programmatically](#How-to-create-StackView-programmatically)
- [How to create attributed text](#How-to-create-attributed-text)
- [How to setup UIPageControl for use with scrolling and buttons](#How-to-setup-UIPageControl-for-use-with-scrolling-and-buttons)

## Theory about leading and trailing anchors

 The leading and trailing anchors better to use then left and right anchors because certail languages such as
 Arabic it's a language that goes from right to left so leading and trailing anchors is going to be aware of if the
 language is right to left ot left to right you don't have to worry about so much what the language orientation so
 Apple recommends to use leading and trailing
 
## Theory about private and lazy 

Private because we don't want anyone outside of this class being to access this property and the reason for that is later on we are going to only allow anyone who uses this cell to be access these properties via the model.

Lazy in Swift means that it is lazily loaded what means that if we just have like private var or just for profileImageView or let profileImageView right variable and we just attack it will be created immediately at the time of the objects are the instance initialization. If we have the lazy keyword here these properties would not be created at the time of the initializer. It would be created first time that property will be called.

Documentation: 

Private - (https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)

Lazy - (https://docs.swift.org/swift-book/LanguageGuide/Properties.html)


## How this application will be improved
- Fix image size horizontally
- Make sure that the TextView does not go to the buttons below, but comes into contact with them.

## How to change image size when device orientation changes

### ViewController file

1. Create own view in which we place the image.
```swift
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
```
2. Add our view in viewDidLoad() and create func setupLayout() 

```swift
override func viewDidLoad() {
        super.viewDidLoad()
     
        view.addSubview(topImageContainerView)
        setupLayout()  
        
    }
```
3. Set constraints to our elements, pay attention in line:

`topImageContainerView.heightAnchor.constraint(equalTo:view.heightAnchor,multiplier: 0.5).isActive = true`

```swift
private func setupLayout() {
        
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
        
    }
```

## How to create CollectionViewController like PageViewController

These methods will allow you to completely fill the screen with your UICollectionViewCell and then you may create some cells and scroll them like in PageViewController.

1. Set the size of the collectionView as the size of the view.
#### SwipingController + UICollectionViewDelegateFlowLayout file
```swift
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
```


2. Add method that allow to swap device orientation and safe the full screen size of UIImageViewCell.
#### SwipingController + extension file
```swift
extension SwipingController {
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionViewLayout.invalidateLayout()
         
            }   
        }) { (bear_) in
        }   
    }
}
```
## How to create StackView programmatically

Add this method to ViewDidLoad()

#### SwipingController file
```swift
    fileprivate func setupButtomControls() {

        let bottomControlStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        view.addSubview(bottomControlStackView)
        bottomControlStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlStackView.distribution = .fillEqually
        
        
        // bottomControlStackView constraints
        NSLayoutConstraint.activate([
            bottomControlStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomControlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomControlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomControlStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
```

## How to create attributed text

Add variable in our UICollectionViewCell that fill our cell with image and some text. `descriptionTextView.attributedText` is a default property that take `attributedText` format text.

#### PageCell file
```swift
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
```

We use pageSetup in code below:

#### SwipingController + UICollectionViewDelegateFlowLayout file
```swift
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        let page = pages[indexPath.item]
        cell.pageSetup = page
        return cell
    }
```

Our page сontains:

#### Page file
```swift
struct Page {
    let imageName: String?
    let headerText: String?
    let bodyText: String?
}
```

## How to setup UIPageControl for use with scrolling and buttons

1. Declare our variable.

#### SwipingController file
```swift
lazy var pageControl: UIPageControl! = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = UIColor(red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
```

2. This method allows us to change the current page of the pageIndicator when scrolling pages.

#### SwipingController file
```swift
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
    }
```

Where `x` takes the following values while we scrolling pages:

![Blue_Paw](https://github.com/ParkhomenkoAlexey/Images/blob/master/bluePaw1.png)

3. This functions let us to change the current page of the pageIndicator when we press NEXT and PREV buttons.

#### SwipingController file
```swift
    @objc private func handlePrev() {
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
```

Pay attention that line: `collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)` scrolls the collection view contents until the specified item is visible.

`.centeredHorizontally` - Scroll so that the item is centered horizontally in the collection view. This option is mutually exclusive with the left and right options.

4. Add method that allow to swap device orientation and safe the full screen size of UIImageViewCell and safe .centeredHorizontally.

#### SwipingController + extension file
```swift
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
```

## Author
| [<img src="https://avatars1.githubusercontent.com/u/8983647?s=460&amp;v=4" width="120px;"/>](https://github.com/ParkhomenkoAlexey)   | [Parkhomenko Alexey](https://github.com/ParkhomenkoAlexey)<br/><br/><sub>iOS Software Engineer</sub><br/> [![Facebook][1.1]][1] [![Github][2.1]][2] [![VKontakte][3.1]][3]|
| - | :- |

[1.1]: https://www.kingsfund.org.uk/themes/custom/kingsfund/dist/img/svg/sprite-icon-facebook.svg (facebook icon)
[2.1]: http://i.imgur.com/9I6NRUm.png (github icon without padding)
[3.1]: https://github.com/ParkhomenkoAlexey/Images/blob/master/Orion_vk.svg (vk icon)


[1]: https://www.facebook.com/profile.php?id=100030997816322
[2]: https://github.com/ParkhomenkoAlexey
[3]: https://vk.com/id189198242
