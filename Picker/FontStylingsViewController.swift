//
//  FontStylingsViewController.swift
//  Picker
//
//  Created by Haroon on 13/11/2014.
//  Copyright (c) 2014 Haroon. All rights reserved.
//

import UIKit

class FontStylingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var data: [String]!
    var currentSelection:Int!
    var pickerBackground2:UIColor!
    var labelBackgroundColor: UIColor!
    var backgroundColor2: UIColor!
    
    @IBOutlet weak var myPickerView2: UIPickerView!
    @IBOutlet weak var myHeadingLabel: UILabel!
    @IBOutlet weak var mySecondLabel: UILabel!
    @IBOutlet weak var myThirdLabel: UILabel!
    
    
    var backupRgbValues2: [Int] = [255,255,255] //For Background RGB values when the switch state is changes
    var backupRgbValuesLabel2: [Int] = [255,255,255] // For Label RGB values when the switch state is changed
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView,
        attributedTitleForRow row: Int,
        forComponent component: Int) -> NSAttributedString? {
            var para = NSMutableParagraphStyle()
            para.alignment = NSTextAlignment.Left
            var attributedString = NSAttributedString(string: data[row], attributes: [NSParagraphStyleAttributeName: para])
            return attributedString
    }
    
    func pickerView(pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int) {
            
            myHeadingLabel.font = UIFont(name: data[row], size: 45.0 )
            currentSelection = row
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateFonts()
        prepareInterface()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "mainView"){
            var navigatingBack: ViewController = segue.destinationViewController as ViewController
            navigatingBack.fontFamily = UIFont(name: data[currentSelection], size: 45.0)
            navigatingBack.textColor = labelBackgroundColor
            navigatingBack.pickerColor = pickerBackground2
            navigatingBack.backgroundColor = backgroundColor2
            navigatingBack.backupRgbValues = backupRgbValues2
            navigatingBack.backupRgbValuesLabel = backupRgbValuesLabel2
            navigatingBack.switchTrigger = false
            navigatingBack.currentSelection2 = currentSelection
            
        }
        else {
            var navigationToDoneView = segue.destinationViewController as DoneViewController
            navigationToDoneView.finalBackgroundColor = backgroundColor2
            navigationToDoneView.finalLabelColor = labelBackgroundColor
            navigationToDoneView.finalLabelFont = UIFont(name: data[currentSelection], size: 45.0)
        }
    }
    
    func populateFonts() {
        var fontFamilies = UIFont.familyNames()
        var fontNames: [String] = []
        
        for i in fontFamilies{
            var fontNamesForFamilies = UIFont.fontNamesForFamilyName(i as String)
            for j in fontNamesForFamilies{
                fontNames.append(j as String)
            }
        }
        
        data = sorted (fontNames, {(s1: String, s2:String) -> Bool in return s1 < s2 })
        
        if currentSelection == nil{
            for i in 0...(data.count) - 1 {
                if data[i] == "AppleSDGothicNeo-Light"{
                    currentSelection = i
                    break
                }
            }
        }
    }
    
    func prepareInterface() {
        myPickerView2.backgroundColor = pickerBackground2
        myHeadingLabel.textColor = labelBackgroundColor
        self.view.backgroundColor = backgroundColor2
        myHeadingLabel.font = UIFont(name: data[currentSelection], size: 45.0 )
        myPickerView2.selectRow(currentSelection, inComponent: 0, animated: true)
    }
}
