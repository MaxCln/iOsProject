//
//  RulesClass.swift
//  iOsProject
//
//  Created by admin on 28/02/2022.
//
import Foundation
import UIKit

class RulesClass {
    
    static var loseTrigger: Bool = false
    static var moves = [[[Int]]]()
    
    class func addCell(cells: [[cellClass?]]) -> [Int]! {
        var nullCells = [[Int]]()
        
        for i in 0...3 {
            for j in 0...3 {
                if cells[i][j]!.valeur < 2 {
                    nullCells.insert([i, j], at: 0)
                }
            }
        }
        //print(nullCells)
        if nullCells != [[Int]]() {
            return nullCells.randomElement()
        }
        return nil
    }
    
    class func mergeCells(direction: String, cells: [[cellClass?]]) {
        var checkCells = [[cellClass?]]()
        
        checkCells = cells
        
        switch direction {
        case "d":
            for i in 0...3 {
                if checkCells[i][3]!.valeur >= 2 && checkCells[i][3]!.valeur == checkCells[i][2]!.valeur {
                    checkCells[i][3]!.valeur += checkCells[i][3]!.valeur
                    checkCells[i][2]!.valeur = 0
                    loseTrigger = true
                }
                if checkCells[i][2]!.valeur >= 2 && checkCells[i][2]!.valeur == checkCells[i][1]!.valeur {
                    checkCells[i][2]!.valeur += checkCells[i][2]!.valeur
                    checkCells[i][1]!.valeur = 0
                    loseTrigger = true
                }
                if checkCells[i][1]!.valeur >= 2 && checkCells[i][1]!.valeur == checkCells[i][0]!.valeur {
                    checkCells[i][1]!.valeur += checkCells[i][1]!.valeur
                    checkCells[i][0]!.valeur = 0
                    loseTrigger = true
                }
            }
            
        case "g":
            for i in 0...3 {
                if checkCells[i][0]!.valeur >= 2 && checkCells[i][0]!.valeur == checkCells[i][1]!.valeur {
                    checkCells[i][0]!.valeur += checkCells[i][0]!.valeur
                    checkCells[i][1]!.valeur = 0
                    loseTrigger = false
                }
                if checkCells[i][1]!.valeur >= 2 && checkCells[i][1]!.valeur == checkCells[i][2]!.valeur {
                    checkCells[i][1]!.valeur += checkCells[i][1]!.valeur
                    checkCells[i][2]!.valeur = 0
                    loseTrigger = false
                }
                if checkCells[i][2]!.valeur >= 2 && checkCells[i][2]!.valeur == checkCells[i][3]!.valeur {
                    checkCells[i][2]!.valeur += checkCells[i][2]!.valeur
                    checkCells[i][3]!.valeur = 0
                    loseTrigger = false
                }
            }
            
        case "h":
            for j in 0...3 {
                if checkCells[0][j]!.valeur >= 2 && checkCells[0][j]!.valeur == checkCells[1][j]!.valeur {
                    checkCells[0][j]!.valeur += checkCells[0][j]!.valeur
                    checkCells[1][j]!.valeur = 0
                    loseTrigger = false
                }
                if checkCells[1][j]!.valeur >= 2 && checkCells[1][j]!.valeur == checkCells[2][j]!.valeur {
                    checkCells[1][j]!.valeur += checkCells[1][j]!.valeur
                    checkCells[2][j]!.valeur = 0
                    loseTrigger = false
                }
                if checkCells[2][j]!.valeur >= 2 && checkCells[2][j]!.valeur == checkCells[3][j]!.valeur {
                    checkCells[2][j]!.valeur += checkCells[2][j]!.valeur
                    checkCells[3][j]!.valeur = 0
                    loseTrigger = false
                }
            }
            
        case "b":
            for j in 0...3 {
                if checkCells[3][j]!.valeur >= 2 && checkCells[3][j]!.valeur == checkCells[2][j]!.valeur {
                    checkCells[3][j]!.valeur += checkCells[3][j]!.valeur
                    checkCells[2][j]!.valeur = 0
                    loseTrigger = false
                }
                if checkCells[2][j]!.valeur >= 2 && checkCells[2][j]!.valeur == checkCells[1][j]!.valeur {
                    checkCells[2][j]!.valeur += checkCells[2][j]!.valeur
                    checkCells[1][j]!.valeur = 0
                    loseTrigger = false
                }
                if checkCells[1][j]!.valeur >= 2 && checkCells[1][j]!.valeur == checkCells[0][j]!.valeur {
                    checkCells[1][j]!.valeur += checkCells[1][j]!.valeur
                    checkCells[0][j]!.valeur = 0
                    loseTrigger = false
                }
            }
                        
        default:
            print()
        }
    }
    
    class func didLose(cells: [[cellClass?]]) -> Bool {
        var checkCells = [[cellClass?]]()
        checkCells = cells
        
        for i in 0...3 {
                if checkCells[i][3]!.valeur >= 2 && checkCells[i][3]!.valeur == checkCells[i][2]!.valeur {
                    return false
                }
                if checkCells[i][2]!.valeur >= 2 && checkCells[i][2]!.valeur == checkCells[i][1]!.valeur {
                    return false
                }
                if checkCells[i][1]!.valeur >= 2 && checkCells[i][1]!.valeur == checkCells[i][0]!.valeur {
                    return false
                }
            }
            
        for i in 0...3 {
                if checkCells[i][0]!.valeur >= 2 && checkCells[i][0]!.valeur == checkCells[i][1]!.valeur {
                    return false
                }
                if checkCells[i][1]!.valeur >= 2 && checkCells[i][1]!.valeur == checkCells[i][2]!.valeur {
                    return false
                }
                if checkCells[i][2]!.valeur >= 2 && checkCells[i][2]!.valeur == checkCells[i][3]!.valeur {
                    return false
                }
            }
            
        for j in 0...3 {
                if checkCells[0][j]!.valeur >= 2 && checkCells[0][j]!.valeur == checkCells[1][j]!.valeur {
                    return false
                }
                if checkCells[1][j]!.valeur >= 2 && checkCells[1][j]!.valeur == checkCells[2][j]!.valeur {
                    return false
                }
                if checkCells[2][j]!.valeur >= 2 && checkCells[2][j]!.valeur == checkCells[3][j]!.valeur {
                    return false
                }
            }
            
        for j in 0...3 {
                if checkCells[3][j]!.valeur >= 2 && checkCells[3][j]!.valeur == checkCells[2][j]!.valeur {
                    return false
                }
                if checkCells[2][j]!.valeur >= 2 && checkCells[2][j]!.valeur == checkCells[1][j]!.valeur {
                    return false
                }
                if checkCells[1][j]!.valeur >= 2 && checkCells[1][j]!.valeur == checkCells[0][j]!.valeur {
                    return false
                }
            }
        
        return true
    }
    
    class func moveCells(direction: String, cells: [[cellClass?]])  {
        var checkCells = [[cellClass?]]()
        var moved: Int = 0
        
        checkCells = cells
        
        /*for i in 0...3 {
            for j in 0...3 {
                print(checkCells[i][j]!.valeur, terminator: " ")
            }
            print()
        }*/
        
        switch direction {
        case "d":
            for i in 0...3 {
                for j in (0...3).reversed() {
                    moved = 0
                    if checkCells[i][j]!.valeur == 0 {
                        for k in 0...j {
                            if checkCells[i][k]!.valeur >= 2 {
                                moved = k
                            }
                        }
                        checkCells[i][j]!.valeur = checkCells[i][moved]!.valeur
                        checkCells[i][moved]!.valeur = 0
                    }
                }
            }
            break;
            
            case "g":
            for i in 0...3 {
                for j in 0...3 {
                    moved = 3
                    if checkCells[i][j]!.valeur == 0 {
                        for k in (j...3).reversed() {
                            if checkCells[i][k]!.valeur >= 2 {
                                moved = k
                            }
                        }
                        checkCells[i][j]!.valeur = checkCells[i][moved]!.valeur
                        checkCells[i][moved]!.valeur = 0
                    }
                }
            }
            break;
            
            case "h":
            for j in 0...3 {
                for i in 0...3 {
                    moved = 3
                    if checkCells[i][j]!.valeur == 0 {
                        for k in (i...3).reversed() {
                            if checkCells[k][j]!.valeur >= 2 {
                                moved = k
                            }
                        }
                        checkCells[i][j]!.valeur = checkCells[moved][j]!.valeur
                        checkCells[moved][j]!.valeur = 0
                    }
                }
            }
            break;
            
            case "b":
            for j in 0...3 {
                for i in (0...3).reversed() {
                    moved = 0
                    if checkCells[i][j]!.valeur == 0 {
                        for k in 0...i {
                            if checkCells[k][j]!.valeur >= 2 {
                                moved = k
                            }
                        }
                        checkCells[i][j]!.valeur = checkCells[moved][j]!.valeur
                        checkCells[moved][j]!.valeur = 0
                    }
                }
            }
            break;
                
        default:
            print()
            break;
        }
        
        print()
        
        /*for i in 0...3 {
            for j in 0...3 {
                print(checkCells[i][j]!.valeur, terminator: " ")
            }
            print()
        }*/
    }
    
    class func saveMove(cells: [[cellClass?]]) {
        var cellsValues = Array(repeating: Array(repeating: 0, count: 4), count: 4)
        
        for i in 0...3 {
            for j in 0...3 {
                cellsValues[i][j] = cells[i][j]!.valeur
            }
        }
        
        moves.append(cellsValues)
    }
    
    class func cancelMove(cells: [[cellClass?]]) {
        for i in 0...3 {
            for j in 0...3 {
                cells[i][j]!.valeur = moves.last![i][j]
            }
        }
        
        moves.removeLast()
    }

}
