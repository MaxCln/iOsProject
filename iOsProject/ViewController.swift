//
//  ViewController.swift
//  iOsProject
//
//  Created by admin on 25/02/2022.
//
import UIKit

class ViewController: UIViewController, UpdateVC {
    @IBOutlet weak var labelText: UILabel!
    
    @IBOutlet weak var goldenLabel: UILabel!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var bronzeLabel: UILabel!
    
    var goldenScore: Int = 0
    var silverScore: Int = 0
    var bronzeScore: Int = 0
    
    let maConfig = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if maConfig.object(forKey: "goldenScore") != nil {
            goldenScore = maConfig.integer(forKey: "goldenScore")
        }
        
        if maConfig.object(forKey: "silverScore") != nil {
            silverScore = maConfig.integer(forKey: "silverScore")
        }
        
        if maConfig.object(forKey: "bronzeScore") != nil {
            bronzeScore = maConfig.integer(forKey: "bronzeScore")
        }
        
        goldenLabel.text = "\(goldenScore)"
        silverLabel.text = "\(silverScore)"
        bronzeLabel.text = "\(bronzeScore)"
    }
    
    func updateScore() {
        if maConfig.object(forKey: "goldenScore") != nil {
            goldenScore = maConfig.integer(forKey: "goldenScore")
        }
        
        if maConfig.object(forKey: "silverScore") != nil {
            silverScore = maConfig.integer(forKey: "silverScore")
        }
        
        if maConfig.object(forKey: "bronzeScore") != nil {
            bronzeScore = maConfig.integer(forKey: "bronzeScore")
        }
        
        goldenLabel.text = "\(goldenScore)"
        silverLabel.text = "\(silverScore)"
        bronzeLabel.text = "\(bronzeScore)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameController {
            destination.delegate = self
        }
    }
}

protocol UpdateVC {
    func updateScore()
}
