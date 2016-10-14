//
//  ViewController.swift
//  shrinkCollection
//
//  Created by lutery on 16/9/7.
//  Copyright © 2016年 lutery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            collectionView.delegate = self;
            collectionView.dataSource = self;
        }
    }
    
    var sectionState = [Bool]();
    var dataArray = [AnyObject]();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.initCollectionData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initCollectionData(){
        let first = ["1", "2", "3", "4", "5", "6", "1", "2", "3", "4"];
        let second = ["1", "2", "3", "4", "5", "6", "7", "8"];
        let third = ["1", "2", "3", "4", "5", "6"];
        dataArray = [first as AnyObject, second as AnyObject, third as AnyObject];
        
        dataArray.forEach({
            _ in
            sectionState.append(false);
        })
    }
    
    func buttonClick(sender: UIButton){
        sectionState[sender.tag] = sectionState[sender.tag] == true ? false : true;
        collectionView.reloadSections(NSIndexSet(index: sender.tag) as IndexSet);
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sectionState[section] == true ? dataArray[section].count : 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionCell", for: indexPath);
        cell.backgroundColor = UIColor.gray;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "GroupSection", for: indexPath) as! GroupSection;
        header.sectionTitle.text = sectionState[indexPath.section] ? "关闭" : "打开";
        header.sectionBtn.addTarget(self, action: #selector(ViewController.buttonClick(sender:)), for: .touchUpInside);
        header.sectionBtn.tag = indexPath.section;
        return header;
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let SCREEN_WIDTH = UIScreen.main.bounds.width;
        return CGSize(width: SCREEN_WIDTH / 4 - 10, height: SCREEN_WIDTH / 4 - 10);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 40);
    }
}

