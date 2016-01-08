//
//  BSCell.swift
//  Button Chaser
//
//  Created by Garrett Haufschild on 12/3/15.
//  Copyright © 2015 Swag Productions. All rights reserved.
//

import UIKit

class BSCell: UICollectionViewCell {
 
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    var textLabel: UILabel!
    var costLabel: UILabel!
    var buttonPreview: UILabel!
    var lockedView: UIView!
    var lock: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Covering UIView
        lockedView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth * 0.8, height: screenHeight * 0.15))
        lockedView.layer.backgroundColor = UIColor.grayColor().CGColor
        lockedView.layer.cornerRadius = screenWidth * 0.065
        lockedView.alpha = 0.5
        
        //Lock Image
        lock = UIImageView(frame: CGRect(x: screenWidth * 0.3, y: screenHeight * 0.025, width: screenWidth * 0.2, height: screenHeight * 0.1))
        lock.image = UIImage(named: "Padlock")
        lockedView.addSubview(lock)
        
        //What button will look like
        buttonPreview = UILabel(frame: CGRect(x: contentView.frame.height * 0.075, y: contentView.frame.height * 0.075, width: contentView.frame.height * 0.85, height: contentView.frame.height * 0.85))
        contentView.addSubview(buttonPreview)
        
        //Name of color
        textLabel = UILabel(frame: CGRect(x: buttonPreview.frame.width * 1.05, y: 0, width: contentView.frame.width - buttonPreview.frame.width * 1.1, height: contentView.frame.height * 0.5))
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.textAlignment = .Center
        contentView.addSubview(textLabel)
        
        //Cost of color
        costLabel = UILabel(frame: CGRect(x: buttonPreview.frame.width * 1.05, y: contentView.frame.height * 0.5, width: contentView.frame.width - buttonPreview.frame.width * 1.1, height: contentView.frame.height * 0.5))
        costLabel.adjustsFontSizeToFitWidth = true
        costLabel.textAlignment = .Center
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
