//
//  GameController.swift
//  iOsProject
//
//  Created by admin on 25/02/2022.
//
import UIKit

class GameController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let maConfig = UserDefaults.standard
    var delegate: UpdateVC?
    
    @IBOutlet weak var view2048: UICollectionView!
    var rows = 4
    var columns = 4
    var cellules: [[cellClass?]]
    var spaceBetween = 10
    var texte: UILabel!
    
    var score: Int = 2
    var bestScore: Int = 2
    
    var goldenScore: Int = 0
    var silverScore: Int = 0
    var bronzeScore: Int = 0
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    
    
    @IBAction func newAction() {
        RulesClass.moves.removeAll()
        rempli()
        score = 2
        setScore()
    }
    
    @IBAction func backAction() {
        loseAlert(isLost: false)
    }
    
    @IBAction func cancelAction() {
        if !RulesClass.moves.isEmpty {
            RulesClass.cancelMove(cells: cellules)
            score = 2
            setScore()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.rows = 4
        self.columns = 4
        
        cellules = [[]]
        cellules = ([[cellClass?]](repeating: [], count: 4))
    
        for j in 1...4 {
            let ligne = [cellClass?](repeating: nil, count: 4)
            cellules[j-1] = ligne
        }
        super.init(coder: aDecoder)
    }
    
    init?(coder aDecoder: NSCoder, nombreLignes: Int, nombreColonnes:Int) {
        
        self.rows = nombreLignes
        self.columns = nombreColonnes
        
        cellules = [[]]
        cellules = ([[cellClass?]](repeating: [], count: nombreLignes))
    
        for j in 1...nombreLignes {
            let ligne = [cellClass?](repeating: nil, count: nombreColonnes)
            cellules[j-1] = ligne
        }
        super.init(coder: aDecoder)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return columns
    }
    
    /*func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cellules[indexPath.section][indexPath.row]!.dessineCellule()
        return cellules[indexPath.section][indexPath.row]!
    }*/
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if cellules[indexPath.section][indexPath.row] == nil {
            cellules[indexPath.section][indexPath.row] = self.view2048.dequeueReusableCell(withReuseIdentifier: "cell2048", for: NSIndexPath(row: indexPath.row, section: indexPath.section) as IndexPath) as? cellClass
        }
        
        cellules[indexPath.section][indexPath.row]!.dessineCellule()
        return cellules[indexPath.section][indexPath.row]!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:0, height:CGFloat(spaceBetween))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view2048.frame.width - CGFloat(spaceBetween * (columns+2))) / CGFloat(rows), height: (view2048.frame.height - CGFloat(spaceBetween * (rows+2))) / CGFloat(columns))
    }
    
    @IBAction func rempli() {
        let free = Int.random(in: 0...3)
        
        for i in 0...3 {
            for j in 0...3 {
                // cellules[i][j]!.valeur = Int(pow(2, Double(j+i*j)))
                cellules[i][j]!.valeur = Int.random(in: 1...2)*2
                if free == 0 {
                    cellules[i][0]!.valeur = 0
                }
                if free == 1 {
                    cellules[0][j]!.valeur = 0
                }
                if free == 2 {
                    cellules[i][3]!.valeur = 0
                }
                if free == 3 {
                    cellules[3][j]!.valeur = 0
                }
            }
        }
    }
    
    @objc func mouvement(sender:UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizer.Direction.right:
            //print("Droite")
            RulesClass.saveMove(cells: cellules)
            RulesClass.moveCells(direction: "d", cells: cellules)
            RulesClass.mergeCells(direction: "d", cells: cellules)
            RulesClass.moveCells(direction: "d", cells: cellules)
            addCells()
        case UISwipeGestureRecognizer.Direction.left:
            //print("Gauche")
            RulesClass.saveMove(cells: cellules)
            RulesClass.moveCells(direction: "g", cells: cellules)
            RulesClass.mergeCells(direction: "g", cells: cellules)
            RulesClass.moveCells(direction: "g", cells: cellules)
            addCells()
        case UISwipeGestureRecognizer.Direction.up:
            //print("Haut")
            RulesClass.saveMove(cells: cellules)
            RulesClass.moveCells(direction: "h", cells: cellules)
            RulesClass.mergeCells(direction: "h", cells: cellules)
            RulesClass.moveCells(direction: "h", cells: cellules)
            addCells()
        case UISwipeGestureRecognizer.Direction.down:
            //print("Bas")
            RulesClass.saveMove(cells: cellules)
            RulesClass.moveCells(direction: "b", cells: cellules)
            RulesClass.mergeCells(direction: "b", cells: cellules)
            RulesClass.moveCells(direction: "b", cells: cellules)
            addCells()
        default:
            break
        }
    }
    
    func setScore() {
        scoreLabel.numberOfLines = 2
        scoreLabel.textAlignment = .center
        scoreLabel.textColor = UIColor.white.withAlphaComponent(0.90)
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        bestScore = goldenScore
        bestScoreLabel.numberOfLines = 2
        bestScoreLabel.textAlignment = .center
        bestScoreLabel.textColor = UIColor.white.withAlphaComponent(0.90)
        bestScoreLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        for i in 0...3 {
            for j in 0...3 {
                if cellules[i][j]!.valeur > score {
                    score = cellules[i][j]!.valeur
                    
                }
            }
        }
        
        if(score >= bestScore) {
            bestScore = score
        }
        
        scoreLabel.text = "Score\n\(score)"
        bestScoreLabel.text = "Meilleur\n\(bestScore)"
        
    }
    
    func addCells() {
        
        let newCells: [Int]! = RulesClass.addCell(cells: cellules)
        if  newCells != nil {
            cellules[newCells[0]][newCells[1]]!.valeur = Int.random(in: 1...2)*2
            setScore()
        }
        else {
            if RulesClass.didLose(cells: cellules) {
                loseAlert(isLost: true)
            }
            else {
                RulesClass.moves.removeLast()
                print("Mouvement possible")
            }
        }
    }
    
    func loseAlert(isLost: Bool) {
        let controller = UIAlertController(title: "Fin de partie", message: "Votre score : \(score)", preferredStyle : .alert )
        let action1 = UIAlertAction(title: "Sauvegarder", style: .default) {
            (action : UIAlertAction) in
            RulesClass.moves.removeAll()
            var k = 0
            for i in 0...3  {
                for j in 0...3 {
                    self.maConfig.setValue(self.cellules[i][j]?.valeur, forKey: "cell\(k)")
                    k += 1
                }
            }
            self.maConfig.setValue(self.score, forKey: "savedScore")
            self.dismiss(animated: true, completion: nil)
        }
        let action2 = UIAlertAction(title: "Retour", style: .cancel) {
            (action: UIAlertAction) in
            RulesClass.moves.removeAll()
            
            if self.score > self.goldenScore {
                self.maConfig.set(self.score, forKey: "goldenScore")
                self.maConfig.set(self.goldenScore, forKey: "silverScore")
                self.maConfig.set(self.silverScore, forKey: "bronzeScore")
            }
            else if self.score > self.silverScore {
                self.maConfig.set(self.score, forKey: "silverScore")
                self.maConfig.set(self.silverScore, forKey: "bronzeScore")
            }
            else if self.score > self.bronzeScore {
                self.maConfig.set(self.score, forKey: "bronzeScore")
            }
            self.maConfig.setValue(0, forKey: "savedScore")
            
            self.delegate?.updateScore()
            self.dismiss(animated: true, completion: nil)
        }
        
        if !isLost {controller.addAction(action1)}
        controller.addAction(action2)
        self.present(controller, animated: true , completion: nil)
        
    }
    
    func retrieveGame() {
        let controller = UIAlertController(title: "Récupérer la sauvegarde ?", message: "Score : \(self.maConfig.integer(forKey: "savedScore"))", preferredStyle : .alert)
        let action1 = UIAlertAction(title: "Oui", style: .default) {
            (action : UIAlertAction) in
            var k = 0
            for i in 0...3  {
                for j in 0...3 {
                    self.cellules[i][j]?.valeur = self.maConfig.integer(forKey: "cell\(k)")
                    k += 1
                }
            }
            self.setScore()
        }
        let action2 = UIAlertAction(title: "Non", style: .cancel) {
            (action: UIAlertAction) in
            self.maConfig.setValue(0, forKey: "savedScore")
        }
        
        controller.addAction(action1)
        controller.addAction(action2)
        self.present(controller, animated: true , completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {        
        if maConfig.object(forKey: "savedScore") != nil && maConfig.integer(forKey: "savedScore") != 0 {
            retrieveGame()
        }
        setScore()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view2048.delegate = self
        view2048.dataSource = self
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: CGFloat(spaceBetween), bottom: 0, right: CGFloat(spaceBetween))
        layout.minimumLineSpacing = CGFloat(spaceBetween)
        
        view2048.setCollectionViewLayout(layout, animated: false)
        
        for i in 0...3 {
            for j in 0...3 {
                cellules[i][j] = view2048.dequeueReusableCell(withReuseIdentifier: "cell2048", for: NSIndexPath(row: i, section: j) as IndexPath) as? cellClass
            }
        }
        view2048.backgroundColor = UIColor.gray
        
        let detectionMouvementR:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementR.direction = .right
        view.addGestureRecognizer(detectionMouvementR)
        let detectionMouvementL:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementL.direction = .left
        view.addGestureRecognizer(detectionMouvementL)
        let detectionMouvementH:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementH.direction = .up
        view.addGestureRecognizer(detectionMouvementH)
        let detectionMouvementB:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.mouvement))
        detectionMouvementB.direction = .down
        view.addGestureRecognizer(detectionMouvementB)
        
        if (maConfig.object(forKey: "goldenScore") != nil) {
            goldenScore = maConfig.integer(forKey: "goldenScore")
        }
        
        if (maConfig.object(forKey: "silverScore") != nil) {
            silverScore = maConfig.integer(forKey: "silverScore")
        }
        
        if (maConfig.object(forKey: "bronzeScore") != nil) {
            bronzeScore = maConfig.integer(forKey: "bronzeScore")
        }
        
        rempli()
    }
    

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
