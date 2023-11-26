//
//  DIYCalendarCell.swift
//  Hamsters
//
//  Created by Chaeeun Shin on 11/26/23.
//

import UIKit
import FSCalendar

enum SelectionType : Int {
    case none
    case single
    case leftBorder
    case middle
    case rightBorder
}

class DIYCalendarCell: FSCalendarCell {
    
    weak var selectionLayer: CAShapeLayer!
    
    var selectionType: SelectionType = .none {
        didSet {
            setNeedsLayout()
        }
    }
    
    required init!(coder aDecoder: NSCoder!) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupObjects()
    }
    
    private func setupObjects() {
        
        let selectionLayer = CAShapeLayer()
        selectionLayer.fillColor = UIColor.thoNavy.cgColor
        selectionLayer.actions = ["hidden": NSNull()]
        
        self.contentView.layer.insertSublayer(selectionLayer, below: self.titleLabel!.layer)
        self.selectionLayer = selectionLayer
        
        self.shapeLayer.isHidden = true
        self.eventIndicator.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.selectionLayer.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: self.contentView.bounds.height - 4)
        
        if selectionType == .middle {
            self.selectionLayer.path = UIBezierPath(rect: self.selectionLayer.bounds).cgPath
                        
            if self.frame.minX == self.superview?.subviews.first?.frame.minX {
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
                self.layer.mask = maskLayer
            } else if self.frame.maxX == self.superview?.subviews.last?.frame.maxX {
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
                self.layer.mask = maskLayer
            } else {
                self.layer.mask = nil
            }
        }
        else if selectionType == .leftBorder {
            self.selectionLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
        }
        else if selectionType == .rightBorder {
            self.selectionLayer.path = UIBezierPath(roundedRect: self.selectionLayer.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: self.selectionLayer.frame.width / 2, height: self.selectionLayer.frame.width / 2)).cgPath
        }
        else if selectionType == .single {
            let diameter: CGFloat = min(self.selectionLayer.frame.height, self.selectionLayer.frame.width)
            self.selectionLayer.path = UIBezierPath(ovalIn: CGRect(x: self.selectionLayer.frame.width / 2 - diameter / 2, y: self.selectionLayer.frame.height / 2 - diameter / 2, width: diameter, height: diameter)).cgPath
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        if self.isPlaceholder {
            self.eventIndicator.isHidden = true
            self.titleLabel.textColor = UIColor.lightGray
            self.titleLabel.backgroundColor = .clear
        }
    }
    
}
