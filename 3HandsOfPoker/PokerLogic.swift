//
//  PokerLogic.swift
//  3HandsOfPoker
//
//  Created by Clint Greive on 10/12/2014.
//  Copyright (c) 2014 Clint Greive. All rights reserved.
//

import Foundation
import UIKit

class PokerLogicFuction {
    
    class func unpackSlotsIntoSlotRows (slots: [[CardStruct]]) -> [[CardStruct]] {
        
        var slotRow1: [CardStruct] = []
        var slotRow2: [CardStruct] = []
        var slotRow3: [CardStruct] = []
        
        for slotArray in slots {
            
            for var index = 0; index < slotArray.count; index++ {
                
                let slot = slotArray[index]
                
                if index == 0 {
                    slotRow1.append(slot)
                    
                } else if index == 1 {
                    slotRow2.append(slot)
                    
                } else if index == 2 {
                    slotRow3.append(slot)
                    
                } else {
                    println("Error")
                }
            }
        }
        var slotInRows: [[CardStruct]] = [slotRow1, slotRow2, slotRow3]
        return slotInRows
    }
    
    //    MARK: Alternative to unpackSlotsIntoSlotRows
    
    //    class func unpackSlotsIntoSlotRows (slots: [[CardStruct]]) -> [[CardStruct]] {
    //
    //        var slotsInRows: [[CardStruct]] = []
    //
    //        for (columnIndex, slotsColumn) in enumerate(slots) {
    //            for (slotIndex, slot) in enumerate(slotsColumn) {
    //                if columnIndex == 0 {
    //                    let slotsRow = [slot]
    //                    slotsInRows.append(slotsRow)
    //                }
    //                else {
    //                    slotsInRows[slotIndex].append(slot)
    //                }
    //            }
    //        }
    //        return slotsInRows
    //    }
    
    class func computeWinnings (slotsArray: [[CardStruct]]) -> (winnings: Int, winLabelArray: [String]) {
        var slotsInRows = unpackSlotsIntoSlotRows(slotsArray)
        var winnings = 0
        
        var flushWinCount = 0
        var fourOfAKindWinCount = 0
        var threeOfAKindWinCount = 0
        var twoPairWinCount = 0
        var straightWinCount = 0
        var straightFlushWinCount = 0
        var fullHouseWinCount = 0
        
        var winLabelsArray:[String] = []
        
        for slotRow in slotsInRows {
            
            if checkFlush(slotRow) == true {
                println("flush")
                winnings += 25
                flushWinCount += 1
                winLabelsArray.append("Flush")
            }
            else if checkStraight(slotRow) == true {
                println("straight")
                winnings += 1000
                straightWinCount += 1
                winLabelsArray.append("Straight")
            }
            else if checkFourOfAKind(slotRow) == true {
                println("four of a kind")
                winnings += 5
                fourOfAKindWinCount += 1
                winLabelsArray.append("Four of a Kind")
            }
            else if checkThreeOfAKind(slotRow) == true {
                println("three of a kind")
                winnings += 3
                threeOfAKindWinCount += 1
                winLabelsArray.append("Three of a Kind")
            }
            else if checkTwoPair(slotRow) == true {
                println("two pair")
                winnings += 1
                twoPairWinCount += 1
                winLabelsArray.append("Two Pair")
            }
            else if checkFlush(slotRow) == true && checkStraight(slotRow) == true {
                print("Straing flush")
                winnings += 10000
                straightFlushWinCount += 1
                winLabelsArray.append("Royal Flush")
            }
            else if checkThreeOfAKind (slotRow) == true && checkOnePair (slotRow) == true {
                println("Full House")
                winnings += 500
                fullHouseWinCount += 1
                winLabelsArray.append("Full House")
            }
            else {
                winLabelsArray.append("")
            }
        }
        return (winnings, winLabelsArray)
    }
    
    class func checkFlush (slotRow: [CardStruct]) -> Bool {
        
        var clubsCount = 0, spadesCount = 0, heartsCount = 0, diamondsCount = 0
        
        for slot in slotRow {
            if slot.isClubs == true {
                clubsCount++
                
            } else if slot.isSpades == true {
                spadesCount++
                
            } else if slot.isHearts == true {
                heartsCount++
                
            } else if slot.isDiamonds == true {
                diamondsCount++
                
            } else {
                println("Error")
            }
        }
        
        if clubsCount == 5 || spadesCount == 5 || heartsCount == 5 || diamondsCount == 5 {
            return true
            
        } else {
            return false
        }
    }
    
    class func checkStraight (slotsRow: [CardStruct]) -> Bool {
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 && slot1.value == slot4.value - 3 && slot1.value == slot5.value - 4 {
            return true
        }
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 && slot1.value == slot4.value + 3 && slot1.value == slot5.value + 4 {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkFourOfAKind (slotsRow: [CardStruct]) -> Bool {
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
        if      slot1.value == slot2.value && slot1.value == slot3.value && slot1.value == slot4.value {
            return true
        }
        else if slot1.value == slot2.value && slot1.value == slot3.value && slot1.value == slot5.value {
            return true
        }
        else if slot1.value == slot2.value && slot1.value == slot4.value && slot1.value == slot5.value {
            return true
        }
        else if slot1.value == slot3.value && slot1.value == slot4.value && slot1.value == slot5.value {
            return true
        }
        else if slot2.value == slot3.value && slot2.value == slot4.value && slot2.value == slot5.value {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkThreeOfAKind (slotsRow: [CardStruct]) -> Bool {
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
        if      slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else if slot1.value == slot2.value && slot1.value == slot4.value {
            return true
        }
        else if slot1.value == slot2.value && slot1.value == slot5.value {
            return true
        }
        else if slot1.value == slot3.value && slot1.value == slot4.value {
            return true
        }
        else if slot1.value == slot3.value && slot1.value == slot5.value {
            return true
        }
        else if slot1.value == slot4.value && slot1.value == slot5.value {
            return true
        }
        else if slot2.value == slot3.value && slot2.value == slot4.value {
            return true
        }
        else if slot2.value == slot3.value && slot2.value == slot5.value {
            return true
        }
        else if slot2.value == slot4.value && slot2.value == slot5.value {
            return true
        }
        else if slot3.value == slot4.value && slot3.value == slot5.value {
            return true
        }
        else {
            return false
        }
    }
    
    class func checkTwoPair (slotsRow: [CardStruct]) -> Bool {
        
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
        if        slot1.value == slot2.value && slot3.value == slot4.value {
            return true
        } else if slot1.value == slot2.value && slot3.value == slot5.value {
            return true
        } else if slot1.value == slot2.value && slot4.value == slot5.value {
            return true
        } else if slot1.value == slot3.value && slot2.value == slot4.value {
            return true
        } else if slot1.value == slot3.value && slot2.value == slot5.value {
            return true
        } else if slot1.value == slot3.value && slot4.value == slot5.value {
            return true
        } else if slot1.value == slot4.value && slot2.value == slot3.value {
            return true
        } else if slot1.value == slot4.value && slot2.value == slot5.value {
            return true
        } else if slot1.value == slot4.value && slot3.value == slot5.value {
            return true
        } else if slot1.value == slot5.value && slot2.value == slot3.value {
            return true
        } else if slot1.value == slot5.value && slot2.value == slot4.value {
            return true
        } else if slot1.value == slot5.value && slot3.value == slot4.value {
            return true
        } else if slot2.value == slot3.value && slot4.value == slot5.value {
            return true
        } else if slot2.value == slot4.value && slot3.value == slot5.value {
            return true
        } else if slot2.value == slot5.value && slot3.value == slot4.value {
            return true
        } else {
            return false
        }
    }
    
    class func checkOnePair (slotsRow: [CardStruct]) -> Bool {
        
        let slot1 = slotsRow[0]
        let slot2 = slotsRow[1]
        let slot3 = slotsRow[2]
        let slot4 = slotsRow[3]
        let slot5 = slotsRow[4]
        
        if        slot1.value == slot2.value {
            return true
        } else if slot1.value == slot3.value {
            return true
        } else if slot1.value == slot4.value {
            return true
        } else if slot1.value == slot5.value {
            return true
        } else if slot2.value == slot3.value {
            return true
        } else if slot2.value == slot4.value {
            return true
        } else if slot2.value == slot5.value {
            return true
        } else if slot3.value == slot4.value {
            return true
        } else if slot3.value == slot5.value {
            return true
        } else if slot4.value == slot5.value {
            return true
        } else {
            return false
        }
    }
}
