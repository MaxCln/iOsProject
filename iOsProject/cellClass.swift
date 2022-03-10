//
//  cellClass.swift
//  iOsProject
//
//  Created by admin on 25/02/2022.
//
import Foundation
import UIKit

class cellClass: UICollectionViewCell, NSCopying  {
    var cell = 0
    var texte: UILabel! = nil
    var valeur: Int = 0 {
        didSet{
            dessineCellule()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Self.init()
        return copy
    }
    
    func dessineCellule() {
        if texte == nil {
            texte = UILabel(frame: CGRect(x:0, y:0, width:self.bounds.size.width, height:self.bounds.size.height))
            texte.numberOfLines = 1
            texte.textAlignment = .center
            texte.textColor = UIColor.black.withAlphaComponent(0.50)
            texte.font = UIFont.boldSystemFont(ofSize: 50.0)
        }
        
        switch valeur {
            case let x where x >= 2 && x <= 16:
                texte.text = "\(x)"
                self.backgroundColor = UIColor.lightGray
            case let x where x >= 32 && x <= 256:
                texte.text = "\(x)"
                self.backgroundColor = UIColor.yellow
            case let x where x >= 512 && x <= 2048:
                texte.text = "\(x)"
                self.backgroundColor = UIColor.brown
            case let x where x > 2048:
                texte.text = "\(x)"
                self.backgroundColor = UIColor.red
            default:
                texte.text = ""
                self.backgroundColor = UIColor.darkGray
            }
        self.contentView.addSubview(texte)
    }
}
