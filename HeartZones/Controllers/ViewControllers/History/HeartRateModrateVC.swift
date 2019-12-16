//
//  HeartRateModrateVC.swift
//  HeartZones
//
//  Created by Hitendra Lariya on 14/10/19.
//  Copyright © 2019 Apple. All rights reserved.
//  HeartRateModrateVC

import UIKit
import FSCalendar

class HeartRateModrateVC: BaseViewController,  FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate  {
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    var strCheck:String?
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    private var imgArr = [String]()
    
    //  var timer = Timer()
    var counter = 0
    var CheckBool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         imgArr = ["A_Photographer.jpg","A_Song_of_Ice_and_Fire.jpg","Another_Rockaway_Sunset.jpg"]
        self.navigationController?.navigationBar.topItem?.title = "History"
        self.calendar.select(Date())
        
        // self.view.addGestureRecognizer(self.scopeGesture)
        self.calendar.scope = .week
        
        // For UITest
        self.calendar.accessibilityIdentifier = "calendar"
        
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = counter
        
        if(strCheck == "Save"){
            self.navigationController!.navigationBar.isHidden = false
           self.tabBarController?.tabBar.isHidden = false
        }
    }
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional before appear the view.
        counter = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after appear the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Do any additional setup after appear the view.
        
    }
    
    
    @IBAction func BackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- UIGestureRecognizerDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.dateFormatter.string(from: calendar.currentPage))")
    }
}

extension HeartRateModrateVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCVC", for: indexPath) as!  HistoryCVC
            return cell
        }else  if(indexPath.row == 1) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCVC2", for: indexPath) as!  HistoryCVC
            return cell
        }
        else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeDetailsBandsCVC", for: indexPath) as!  HomeDetailsBandsCVC
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if(indexPath.row == 0){
        //             counter = 0
        //        }
        //        let index = IndexPath.init(item: counter, section: 0)
        //        self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        //        pageView.currentPage = counter
        //        counter += 1
    }
    
   
}


extension HeartRateModrateVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension HeartRateModrateVC:UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // Calculate where the collection view should be at the right-hand end item
        
        if(CheckBool == true){
            counter += 1
            let indexPath : NSIndexPath = NSIndexPath(row: counter, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            pageView.currentPage = counter
            if(imgArr.count-1 == counter){
                CheckBool = false
            }
            
        }else if(CheckBool == false){
            counter -= 1
            let indexPath : NSIndexPath = NSIndexPath(row: counter, section: 0)
            sliderCollectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            pageView.currentPage = counter
            if(counter == 0){
                CheckBool = true
            }
        }
        
    }
}


