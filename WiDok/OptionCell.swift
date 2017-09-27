//
//  OptionCell.swift
//  WiDok
//
//  Created by Lynn on 8/8/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class OptionCell: UITableViewCell {

    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contentTF: UITextField!
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

extension OptionCell:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        animationHandler(contentTF.text!)
        return true
    }
}
