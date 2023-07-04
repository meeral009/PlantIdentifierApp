//
//  OnBordingVC.swift
//  PlantIdentifire
//
//  Created by admin on 17/11/22.
//

import UIKit

class OnBordingVC: UIViewController {
    
//MARK: - IBOutlates
    @IBOutlet weak var slidesCollectionView: UICollectionView!
    @IBOutlet weak var btnGoOutlet: UIButton!
    @IBOutlet weak var btnSkipOutlet: UIButton!
   
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet weak var bottomConstant: NSLayoutConstraint!
    
    @IBOutlet weak var topConstant: NSLayoutConstraint!
    
    //MARK: - Variables
    var currentPage = 0
    var isScrolling: Bool = false

//MARK: - view lifecycle Methods
    
  override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        // Do any additional setup after loading the view.
    }
    
//MARK: - IBAction Method
    
    
    @IBAction func btnSkipAction(_ sender: Any) {
        UserDefaults.isCheckOnBording = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "CustomTabBarVC") as! CustomTabBarVC
            isFormOnBoarding = true
            self.navigationController?.viewControllers = [redViewController]
            self.navigationController?.pushViewController(redViewController, animated: true)
        }
        
       
    }
    
    @IBAction func btnGoAction(_ sender: Any) {
        isScrolling = false
        if currentPage == 2 {
            self.setScrollChanges()
            UserDefaults.isCheckOnBording = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "CustomTabBarVC") as! CustomTabBarVC
                isFormOnBoarding = true
                self.navigationController?.viewControllers = [redViewController]
                self.navigationController?.pushViewController(redViewController, animated: true)
            }
        } else {
            self.setScrollChanges()
        }
    }
    
    
    func setScrollChanges() {
        
        print("Current Index: \(self.currentPage)")
        
        if !isScrolling {
            if currentPage != 2 {
                currentPage += 1
                pageControl.currentPage = currentPage
            } else {
                self.currentPage = 2
            }
        }
        
        if currentPage == 2 {
            // set true for avoid inbording scren.
             self.currentPage = 2
             pageControl.currentPage = currentPage
             self.btnGoOutlet.setTitle("Get Started", for: .normal)
        } else {
            self.btnGoOutlet.setTitle("Next", for: .normal)
        }
        self.btnSkipOutlet.isHidden = false
        self.slidesCollectionView.reloadData()
        self.slidesCollectionView.scrollToItem(at: IndexPath.init(row: currentPage, section: 0), at: .centeredVertically, animated:true)
        self.view.layoutIfNeeded()
    }
    
}

//MARK: - UserDefined Function
extension OnBordingVC {
    
    func setUpUI() {
        if !UIDevice.current.hasNotch && !UIDevice.current.isPad{
            bottomConstant.constant = 16
            topConstant.constant = 50
        }
        self.slidesCollectionView.register(UINib(nibName: "OnbordingCell", bundle: .main), forCellWithReuseIdentifier: "OnbordingCell")
    }
}

//MARK: - UICollectionview delegates method

extension OnBordingVC : UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnbordingCell", for: indexPath) as! OnbordingCell
        cell.view1.isHidden = true
        cell.view2.isHidden = true
        cell.view3.isHidden = true
        if indexPath.row == 0 {
            cell.view1.isHidden = false
        } else if indexPath.row == 1 {
            cell.view2.isHidden = false
        } else {
            cell.view3.isHidden = false
        }
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.isScrolling = true
        let width = scrollView.frame.width
        if isScrolling {
            currentPage = Int(scrollView.contentOffset.x  / width)
            self.pageControl.currentPage = currentPage
        }
        self.setScrollChanges()
    }

}
