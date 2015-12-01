//
//  AllHabitsCollectionViewController.swift
//  
//
//  Created by Maggy Hillen on 11/25/15.
//
//

import UIKit

class AllHabitsCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var levelSelector: UISegmentedControl!
    var habitsToDisplay : [Habit] = []
    var colorsArray : [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCollectionViewUI()
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:loraFont.fontWithSize(18)]
        
        self.levelSelector.setTitleTextAttributes([NSFontAttributeName:loraFont.fontWithSize(12)], forState: .Normal)
        self.levelSelector.setTitleTextAttributes([NSFontAttributeName:loraFont.fontWithSize(12)], forState: .Selected)
        
        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "HabitCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HabitCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        if allHabits == [] {
            Habit.getAllHabits()
        }
        if userHabits == [] {
            Habit.getHabitsForCurrentUser()
        }
        self.checkSelectorAndReloadData()
    }
    
    func setCollectionViewUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        print(UIDevice.currentDevice().modelName)
        
        if UIDevice.currentDevice().modelName == "iPhone 6s Plus" ||
           UIDevice.currentDevice().modelName == "iPhone 6 Plus" {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
            layout.itemSize = CGSize(width: 110, height: 110)
        } else if UIDevice.currentDevice().modelName == "iPhone 6s" || UIDevice.currentDevice().modelName == "iPhone 6" || UIDevice.currentDevice().modelName == "Simulator" {
            layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
            layout.itemSize = CGSize(width: 125, height: 125)
        }

    
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
        
    }

    @IBAction func selectedLevelChanged(sender: AnyObject) {
        self.checkSelectorAndReloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.habitsToDisplay.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("HabitCell", forIndexPath: indexPath) as! HabitCollectionViewCell
        cell.setUI(self.habitsToDisplay[indexPath.row])
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let habit = self.habitsToDisplay[indexPath.row]
        let detailController = HabitDetailViewController()
        detailController.habit = habit
        detailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    func checkSelectorAndReloadData(){
        switch self.levelSelector.selectedSegmentIndex {
        case 0:
            self.habitsToDisplay = allHabits
            break
        case 1:
            self.habitsToDisplay = allHabits.filter({$0.level == "Simple"})
            break
        case 2:
            self.habitsToDisplay = allHabits.filter({$0.level == "Moderate"})
        case 3:
            self.habitsToDisplay = allHabits.filter({$0.level == "Challenging"})
        default:
            break
        }
        self.collectionView!.reloadData()
    }

    @IBAction func menuButtonTapped(sender: AnyObject) {
        showPopoverMenu(self)
    }
}
