//
//  Factory.swift
//  3HandsOfPoker
//
//  Created by Clint Greive on 10/12/2014.
//  Copyright (c) 2014 Clint Greive. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    
    class func createMultiSlotsFunction() -> [[CardStruct]] {
        
        
        var slotsMultiArray: [[CardStruct]] = []
        
        //slots = [[slot1, slot2, slot3], [slot4, slot5, slot6], [slot7, slot8, slot9], [slot10, slot11, slot12], etc]
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            var slotArray:[CardStruct] = []
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                var slotObject = Factory.createSingleSlotFunction(slotArray)
                slotArray.append(slotObject)
            }
            slotsMultiArray.append(slotArray)
        }
        return slotsMultiArray
    }
    
    class func createSingleSlotFunction (currentCards: [CardStruct]) -> CardStruct {
        var currentCardValues:[Int] = []
        
        for slotFastEnum in currentCards {
            currentCardValues.append(slotFastEnum.value)
        }
        
        var randomNumber = Int(arc4random_uniform(UInt32(52)))
        while contains(currentCardValues, randomNumber + 1) {
            randomNumber = Int(arc4random_uniform(UInt32(52)))
        }
        
        // creat slot instance of the CardStruct
        var slot:CardStruct
        
        switch randomNumber {
        case 0:
            slot = CardStruct(value: 1, image: UIImage(named: "AClubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 1:
            slot = CardStruct(value: 1, image: UIImage(named: "ADiamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 2:
            slot = CardStruct(value: 1, image: UIImage(named: "AHearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 3:
            slot = CardStruct(value: 1, image: UIImage(named: "ASpades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 4:
            slot = CardStruct(value: 2, image: UIImage(named: "2Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 5:
            slot = CardStruct(value: 2, image: UIImage(named: "2Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 6:
            slot = CardStruct(value: 2, image: UIImage(named: "2Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 7:
            slot = CardStruct(value: 2, image: UIImage(named: "2Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 8:
            slot = CardStruct(value: 3, image: UIImage(named: "3Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 9:
            slot = CardStruct(value: 3, image: UIImage(named: "3Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 10:
            slot = CardStruct(value: 3, image: UIImage(named: "3Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 11:
            slot = CardStruct(value: 3, image: UIImage(named: "3Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 12:
            slot = CardStruct(value: 4, image: UIImage(named: "4Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 13:
            slot = CardStruct(value: 4, image: UIImage(named: "4Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 14:
            slot = CardStruct(value: 4, image: UIImage(named: "4Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 15:
            slot = CardStruct(value: 4, image: UIImage(named: "4Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 16:
            slot = CardStruct(value: 5, image: UIImage(named: "5Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 17:
            slot = CardStruct(value: 5, image: UIImage(named: "5Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 18:
            slot = CardStruct(value: 5, image: UIImage(named: "5Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 19:
            slot = CardStruct(value: 5, image: UIImage(named: "5Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 20:
            slot = CardStruct(value: 6, image: UIImage(named: "6Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 21:
            slot = CardStruct(value: 6, image: UIImage(named: "6Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 22:
            slot = CardStruct(value: 6, image: UIImage(named: "6Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 23:
            slot = CardStruct(value: 6, image: UIImage(named: "6Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 24:
            slot = CardStruct(value: 7, image: UIImage(named: "7Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 25:
            slot = CardStruct(value: 7, image: UIImage(named: "7Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 26:
            slot = CardStruct(value: 7, image: UIImage(named: "7Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 27:
            slot = CardStruct(value: 7, image: UIImage(named: "7Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 28:
            slot = CardStruct(value: 8, image: UIImage(named: "8Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 29:
            slot = CardStruct(value: 8, image: UIImage(named: "8Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 30:
            slot = CardStruct(value: 8, image: UIImage(named: "8Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 31:
            slot = CardStruct(value: 8, image: UIImage(named: "8Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 32:
            slot = CardStruct(value: 9, image: UIImage(named: "9Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 33:
            slot = CardStruct(value: 9, image: UIImage(named: "9Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 34:
            slot = CardStruct(value: 9, image: UIImage(named: "9Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 35:
            slot = CardStruct(value: 9, image: UIImage(named: "9Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 36:
            slot = CardStruct(value: 10, image: UIImage(named: "10Clubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 37:
            slot = CardStruct(value: 10, image: UIImage(named: "10Diamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 38:
            slot = CardStruct(value: 10, image: UIImage(named: "10Hearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 39:
            slot = CardStruct(value: 10, image: UIImage(named: "10Spades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 40:
            slot = CardStruct(value: 11, image: UIImage(named: "JClubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 41:
            slot = CardStruct(value: 11, image: UIImage(named: "JDiamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 42:
            slot = CardStruct(value: 11, image: UIImage(named: "JHearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 43:
            slot = CardStruct(value: 11, image: UIImage(named: "JSpades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 44:
            slot = CardStruct(value: 12, image: UIImage(named: "QClubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 45:
            slot = CardStruct(value: 12, image: UIImage(named: "QDiamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 46:
            slot = CardStruct(value: 12, image: UIImage(named: "QHearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 47:
            slot = CardStruct(value: 12, image: UIImage(named: "QSpades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        case 48:
            slot = CardStruct(value: 13, image: UIImage(named: "KClubs"), isRed: false, isClubs: true, isDiamonds: false, isHearts: false, isSpades: false)
        case 49:
            slot = CardStruct(value: 13, image: UIImage(named: "KDiamonds"), isRed: true, isClubs: false, isDiamonds: true, isHearts: false, isSpades: false)
        case 50:
            slot = CardStruct(value: 13, image: UIImage(named: "KHearts"), isRed: true, isClubs: false, isDiamonds: false, isHearts: true, isSpades: false)
        case 51:
            slot = CardStruct(value: 13, image: UIImage(named: "KSpades"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: true)
        default:
            slot = CardStruct(value: 0, image: UIImage(named: "Joker"), isRed: false, isClubs: false, isDiamonds: false, isHearts: false, isSpades: false)
        }
        return slot
    }
}
