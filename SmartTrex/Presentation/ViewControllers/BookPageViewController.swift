//
//  BookPageViewController.swift
//  SmartTrex
//
//  Created by Yegor Gorskikh on 31.08.2022.
//

import UIKit

class BookPageViewController: UIPageViewController {
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        let firstVc = UIViewController()
        firstVc.view.backgroundColor = .yellow
        let secondVc = UIViewController()
        secondVc.view.backgroundColor = .blue
        let thirdVc = UIViewController()
        thirdVc.view.backgroundColor = .systemPink
        return [firstVc, secondVc, thirdVc]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        //        transitionStyle = .scroll
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
    }
}

extension BookPageViewController: UIPageViewControllerDataSource {
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard
            let firstViewController = viewControllers?.first,
            let firstViewControllerIndex = orderedViewControllers.firstIndex(of: firstViewController)
        else {
            return 0
        }
        
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard
            let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController)
        else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard
            previousIndex >= 0,
            orderedViewControllers.count > previousIndex
        else {
            return orderedViewControllers.last
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard
            let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController)
        else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard
            orderedViewControllersCount != nextIndex,
            orderedViewControllersCount > nextIndex
        else {
            return orderedViewControllers.first
        }
        
        return orderedViewControllers[nextIndex]
    }
}
