//
//  AuthenticationVC.swift
//  EdLink
//
//  Created by Muhammad Faruuq Qayyum on 08/01/21.
//

import UIKit

class AuthenticationVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControll: UIPageControl!
    
    var slides: [Slide] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slides = createSlides()
        setupScrollView(slides: slides)
        scrollView.delegate = self
        setupPageControll()
    }

}

extension AuthenticationVC {
    
    fileprivate func createSlides() -> [Slide] {
        
        let slide1: Slide = nibBundle?.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.mainImg.image = #imageLiteral(resourceName: "scroll1")
        slide1.mainTitle.text = "attendance using qr code".uppercased()
        slide1.subtitle.text = "Attendance is made easier by using the QR Code"
        
        let slide2: Slide = nibBundle?.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.mainImg.image = #imageLiteral(resourceName: "scroll5")
        slide2.mainTitle.text = "online discussion".uppercased()
        slide2.subtitle.text = "Discussing with friends and lecturers is easier"
        
        let slide3: Slide = nibBundle?.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.mainImg.image = #imageLiteral(resourceName: "scroll3")
        slide3.mainTitle.text = "check the learning report".uppercased()
        slide3.subtitle.text = "Check the academic data easier"
        
        let slide4: Slide = nibBundle?.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.mainImg.image = #imageLiteral(resourceName: "scroll4")
        slide4.mainTitle.text = "notification of schedule".uppercased()
        slide4.subtitle.text = "Notification of upcoming lecture schedules"
        
        return [slide1, slide2, slide3, slide4]
        
    }
    
    fileprivate func setupScrollView(slides: [Slide]) {
        
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: scrollView.frame.height)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slides[i])
        }
        
    }
    
    fileprivate func setupPageControll() {
        pageControll.pageIndicatorTintColor = .systemGray5
        pageControll.currentPageIndicatorTintColor = .darkGray
        pageControll.addTarget(self, action: #selector(pageControlDidChange(_:)), for: .valueChanged)
    }
    
    @objc
    func pageControlDidChange(_ sender: UIPageControl) {
        let current = sender.currentPage
        scrollView.setContentOffset(CGPoint(x: CGFloat(current) * view.frame.width, y: 0), animated: true)
    }
}

extension AuthenticationVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControll.currentPage = Int(pageIndex)
        
    }
}
