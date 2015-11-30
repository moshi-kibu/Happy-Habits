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
    
    var allHabits : [Habit] = []
    var habitsToDisplay : [Habit] = []
    var userHabits : [Habit] = []
    var colorsArray : [UIColor] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setCollectionViewUI()
        
        // Register cell classes
        self.collectionView!.registerNib(UINib(nibName: "HabitCollectionCell", bundle: nil), forCellWithReuseIdentifier: "HabitCell")
    }
    
    override func viewDidAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            self.allHabits = Habit.getAllHabits()
            self.userHabits = Habit.getHabitsForCurrentUser()
            self.checkSelectorAndReloadData()
        }
    }
    
    func setCollectionViewUI() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        
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
        detailController.userHabits = self.userHabits as! [Habit]
        detailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailController, animated: true)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    func checkSelectorAndReloadData(){
        switch self.levelSelector.selectedSegmentIndex {
        case 0:
            self.habitsToDisplay = self.allHabits
            break
        case 1:
            self.habitsToDisplay = self.allHabits.filter({$0.level == "Simple"})
            break
        case 2:
            self.habitsToDisplay = self.allHabits.filter({$0.level == "Moderate"})
        case 3:
            self.habitsToDisplay = self.allHabits.filter({$0.level == "Challenging"})
        default:
            break
        }
        self.collectionView!.reloadData()
    }
}
