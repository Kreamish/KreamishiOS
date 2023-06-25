//
//  FilterPopupContentViewController.swift
//  Kreamish
//
//  Created by Miyo Lee on 2023/06/25.
//

import UIKit

import Pageboy
import Tabman

class FilterPopupContentViewController: TabmanViewController, PageboyViewControllerDataSource, TMBarDataSource {
    private var selectedIndex: Int
    private var viewControllers: [UIViewController] = []
    
    private lazy var tempView: UIView = {   // 상단 탭바 들어갈 자리
        return UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
    }()
    private lazy var contentViewController1: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        return viewController
    }()
    private lazy var contentViewController2: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .orange
        return viewController
    }()
    private lazy var contentViewController3: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .yellow
        return viewController
    }()
    private lazy var contentViewController4: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .green
        return viewController
    }()
    private lazy var contentViewController5: UIViewController = {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .blue
        return viewController
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    init(index: Int) {
        selectedIndex = index
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    func configureUI() {
        view.addSubview(tempView)   // 상단탭 들어갈 영역
        
        viewControllers.append(contentViewController1)
        viewControllers.append(contentViewController2)
        viewControllers.append(contentViewController3)
        viewControllers.append(contentViewController4)
        viewControllers.append(contentViewController5)
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        setTabBar(bar: bar)
        addBar(bar, dataSource: self, at: .custom(view: tempView, layout: nil)) // .custom을 통해 원하는 뷰에 삽입함.
    }
    
    func setTabBar(bar: TMBar.ButtonBar) {
        bar.backgroundView.style = .flat(color: UIColor.white)
        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        bar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .black // 선택 되어 있을 때
            button.font = .systemFont(ofSize: 16, weight: .light)
            button.selectedFont = .boldSystemFont(ofSize: 16)
        }
        // 인디케이터 조정
        bar.indicator.weight = .light
        bar.indicator.tintColor = .black
        bar.indicator.overscrollBehavior = .compress
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.layout.interButtonSpacing = 0 // 버튼 사이 간격
        
        bar.layout.transitionStyle = .snap // Customize
    }
    
    // MARK: Pageboy DataSource, Tabman DataSource
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return .at(index: 0)
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "카테고리")
        case 1:
            return TMBarItem(title: "성별")
        case 2:
            return TMBarItem(title: "브랜드")
        case 3:
            return TMBarItem(title: "컬렉션")
        case 4:
            return TMBarItem(title: "사이즈")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
}
