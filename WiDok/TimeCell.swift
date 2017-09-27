//
//  TimeCell.swift
//  WiDok
//
//  Created by Lynn on 8/9/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class TimeCell: UITableViewCell {

    @IBOutlet weak var endPicker: UIPickerView!
    @IBOutlet weak var startPicker: UIPickerView!
    @IBOutlet weak var seprator: UIView!
    @IBOutlet weak var endTime: UITextField!
    @IBOutlet weak var startTime: UITextField!
    var animationHandler:((String)->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TimeCell:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        animationHandler(startTime.text!)
        return true
    }
}
