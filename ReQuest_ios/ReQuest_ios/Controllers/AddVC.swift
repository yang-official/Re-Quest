//
//  AddVC.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit
import TextFieldEffects
import ChameleonFramework

class AddVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var detailField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    var category = QuestCategory.Uncategorized.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.flatWhite
        categoryPicker.dataSource = self
        categoryPicker.delegate = self
    }
    let pickerData = QuestCategory.labels()
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category = pickerData[row]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        titleField.resignFirstResponder()
        detailField.resignFirstResponder()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func publishBtnPressed(_ sender: Any) {
        let user = Faker.instance.getUsers()[0]
        let quest = Quest(title: titleField.text!,
                          detail: detailField.text!, description: "",
                          category: QuestCategory.labelToCategory(category),
                          creator: user, fulfiller: user, lat: 37.7735305, lng: -122.4180948)
        Satori.instance.publish(quest: quest)
    }

}
