//
//  ViewController.swift
//  3HandsOfPoker
//
//  Created by Clint Greive on 10/12/2014.
//  Copyright (c) 2014 Clint Greive. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlets
    // create UIView properties
    var backgroundContainer: UIView!
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    // label properties
    var titleLabel: UILabel!
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    
    var creditsTitleLabel: UILabel!
    var betTitleLabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    // Slot Win labels
    var rowOneLabel = UILabel()
    var rowTwoLabel = UILabel()
    var rowThreeLabel = UILabel()
    var rowFourLabel = UILabel()
    var rowFiveLabel = UILabel()
    
    //IBActions
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var dealButton: UIButton!
    
    // Array property
    var slotsArrays: [[CardStruct]] = []
    
    // Stats
    var credits:Int = 0
    var currentBet:Int = 0
    var winnings:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupContainerViews()
        self.setupFirstContainer(self.firstContainer)
        self.setupThirdContainer(self.thirdContainer)
        self.setupForthContainer(self.fourthContainer)
        
        // this func calls setupSecondContainer
        self.hardReset()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBAction Buttons
    // Deal Button
    func dealButtonPressed(button: UIButton) {
        
        if self.currentBet == 0 {
            self.showAlertWithText(header: "NO DEAL", message: "Place a bet first!")
            
        } else {
            
            self.removeSlotImageViews()
            self.slotsArrays = Factory.createMultiSlotsFunction()
            self.setupSecondContainer(self.secondContainer)
            
            var winningsMultiplierAndLabel = PokerLogicFuction.computeWinnings(slotsArrays)
            self.winnings = winningsMultiplierAndLabel.winnings * self.currentBet
            self.credits += self.winnings
            self.currentBet = 0
            self.updateMainView()
            
            for var i = 0; i < winningsMultiplierAndLabel.winLabelArray.count; ++i {
                
                if winningsMultiplierAndLabel.winLabelArray[i] != "" {
                    if i == 0 {
                        rowOneLabel.hidden = false
                        rowOneLabel.text = winningsMultiplierAndLabel.winLabelArray[0]
                    }
                    else if i == 1 {
                        rowTwoLabel.hidden = false
                        rowTwoLabel.text = winningsMultiplierAndLabel.winLabelArray[1]
                    }
                    else if i == 2 {
                        rowThreeLabel.hidden = false
                        rowThreeLabel.text = winningsMultiplierAndLabel.winLabelArray[2]
                    }
                }
            }
        }
    }
    
    // Reset Button
    func resetButtonPressed(button: UIButton) {
        
        self.hardReset()
}

    // Bet One Button
    func betOneButtonPressed(button: UIButton) {
        
        if self.credits <= 0 && self.currentBet == 0 {
            self.showAlertWithText(header: "No More Credits", message: "Reset")
            
        } else if self.credits == 0 {
            self.showAlertWithText(header: "No More Credits", message: "You have reached your max bet amount")
            
        } else if self.currentBet < 10 {
            self.currentBet+=1
            self.credits-=1
            self.winnings = 0
            self.updateMainView()
            
        } else {
            showAlertWithText(message: "You can only bet 10 credits at a time")
        }
    }
    
    // Max Bet Button
    func betMaxButtonPressed(button: UIButton) {
        
        var creditsToBetMax:Int = 10 - self.currentBet
        
        if self.currentBet == 10 {
            self.showAlertWithText(message: "You can only bet 10 credits at a time!")
            
        } else if self.credits <= 0 && self.currentBet == 0 {
            self.showAlertWithText(header: "No More Credits", message: "Reset")
            
        } else if self.credits < creditsToBetMax {
            self.showAlertWithText(header: "Not enough credits", message: "Bet less")
            
        } else {
            self.credits -= creditsToBetMax
            self.currentBet += creditsToBetMax
            self.winnings = 0
            self.updateMainView()
        }
    }
    
    
    // CONTAINER VIEWS
    func setupContainerViews() {
        
        // background
        self.backgroundContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x,
            y: self.view.bounds.origin.y,
            width: self.view.bounds.width,
            height: self.view.bounds.height))
        self.backgroundContainer.backgroundColor = myLightRedColor
        self.view.addSubview(self.backgroundContainer)
        
        // first Container View
        self.firstContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: self.view.bounds.origin.y + (kMarginForView),
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * kTenth))
        self.firstContainer.backgroundColor = myDarkGrayRedColor
        self.view.addSubview(self.firstContainer)
        
        // second ContainerView
        self.secondContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: self.firstContainer.frame.height,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * (5 * kTenth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        // third ContainerView
        self.thirdContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: self.firstContainer.frame.height + self.secondContainer.frame.height,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * kTenth))
        self.thirdContainer.backgroundColor = myDarkGrayColor
        self.view.addSubview(self.thirdContainer)
        
        // fourth view
        self.fourthContainer = UIView(frame: CGRect(
            x: self.view.bounds.origin.x + kMarginForView,
            y: self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdContainer.frame.height,
            width: self.view.bounds.width - (kMarginForView * 2),
            height: self.view.bounds.height * (kTenth * 3) - (kMarginForView)))
        self.fourthContainer.backgroundColor = myDarkGrayRedColor
        self.view.addSubview(self.fourthContainer)
    }
    
    func setupFirstContainer (containerView: UIView) {
        self.titleLabel = UILabel()
        self.titleLabel.text = "3 Hands of Poker"
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.font = UIFont(name: "Baskerville-Bold", size: 30)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = CGPoint(
            x: containerView.frame.width * kHalf,
            y: containerView.frame.height * kHalf)
        containerView.addSubview(self.titleLabel)
    }
    
    //  SECOND CONTAINER
    func setupSecondContainer (containerView: UIView) {
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; containerNumber++ {
            
            for var slotNumber = 0; slotNumber < kNumberOfSlots; slotNumber++ {
                
                var slotInstance:CardStruct
                
                // create local instance only i.e. can't use self keyword
                var slotImageView = UIImageView()
                
                if slotsArrays.count != 0 {
                    let slotContainer = slotsArrays[containerNumber]
                    slotInstance = slotContainer[slotNumber]
                    slotImageView.image = slotInstance.image
                }
                else {
                    slotImageView.image = UIImage(named: "Joker")
                }
                
                slotImageView.backgroundColor = UIColor.whiteColor()
                slotImageView.frame = CGRect(
                    x: containerView.bounds.origin.x + kMarginForSlot + ((containerView.bounds.size.width - kMarginForSlot) * CGFloat(containerNumber) / CGFloat(kNumberOfContainers)),
                    y: containerView.bounds.origin.y + kMarginForSlot + ((containerView.bounds.size.height - kMarginForSlot) * CGFloat(slotNumber) / CGFloat(kNumberOfSlots)),
                    width: (containerView.bounds.width - kMarginForSlot) / CGFloat(kNumberOfContainers) - kMarginForSlot,
                    height: (containerView.bounds.height - kMarginForSlot) / CGFloat(kNumberOfSlots) - kMarginForSlot)
                containerView.addSubview(slotImageView)
            }
        }
        
        //  WIN LABEL
        func createWinLabel (label: UILabel, labelHeight: CGFloat) {
            
            label.frame = CGRect(
                x: 0,
                y: 0,
                width: containerView.bounds.width - (kMarginForSlot * 2),
                height: containerView.bounds.height * kThird - (kMarginForSlot * 2))
            label.center = CGPoint(
                x: containerView.bounds.width * kHalf,
                y: ((containerView.bounds.height * kThird) * labelHeight) - ((containerView.bounds.height * kThird) * kHalf))
            label.textColor = UIColor.blackColor()
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
            label.textAlignment = NSTextAlignment.Center
            label.backgroundColor = myWinLabelBackgroundColor
            label.layer.borderColor = myWinLabelBorderColor.CGColor
            label.layer.borderWidth = 2
            label.layer.masksToBounds = true
            //      label.layer.cornerRadius = 7
            label.text = "Hi"
            label.hidden = true
            containerView.addSubview(label)
        }
        
        createWinLabel(rowOneLabel, 1.0)
        createWinLabel(rowTwoLabel, 2.0)
        createWinLabel(rowThreeLabel, 3.0)
    }
    
    //  THIRD CONTAINER
    func setupThirdContainer(containerView: UIView) {
        
        // credits title label
        self.creditsTitleLabel = UILabel()
        self.creditsTitleLabel.text = "CREDITS"
        self.creditsTitleLabel.textColor = UIColor.whiteColor()
        self.creditsTitleLabel.font = UIFont(name: "ArialMT-Bold", size: 14)
        self.creditsTitleLabel.sizeToFit()
        self.creditsTitleLabel.center = CGPoint(
            x: containerView.frame.width * kSixth,
            y: containerView.frame.height * kThird)
        self.creditsTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.creditsTitleLabel)
        
        // credits label
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "ArialMT-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPoint(
            x: containerView.frame.width * kSixth,
            y: containerView.frame.height * kThird * 2)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        //      self.creditsLabel.backgroundColor = UIColor.blackColor()
        containerView.addSubview(self.creditsLabel)
        
        // bets title label
        self.betTitleLabel = UILabel()
        self.betTitleLabel.text = "BET"
        self.betTitleLabel.textColor = UIColor.whiteColor()
        self.betTitleLabel.font = UIFont(name: "ArialMT-Bold", size: 14)
        self.betTitleLabel.sizeToFit()
        self.betTitleLabel.center = CGPoint(
            x: containerView.frame.width * kSixth * 3,
            y: containerView.frame.height * kThird)
        self.betTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.betTitleLabel)
        
        // bets label
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "ArialMT-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPoint(
            x: containerView.frame.width * kSixth * 3,
            y: containerView.frame.height * kThird * 2)
        self.betLabel.textAlignment = NSTextAlignment.Center
        //      self.betLabel.backgroundColor = UIColor.blackColor()
        containerView.addSubview(self.betLabel)
        
        // winner paid title label
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "WINNINGS"
        self.winnerPaidTitleLabel.textColor = UIColor.whiteColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "ArialMT-Bold", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPoint(
            x: containerView.frame.width * kSixth * 5,
            y: containerView.frame.height * kThird)
        self.winnerPaidTitleLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.winnerPaidTitleLabel)
        
        // winner paid label
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "ArialMT-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPoint(
            x: containerView.frame.width * kSixth * 5,
            y: containerView.frame.height * kThird * 2)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        containerView.addSubview(self.winnerPaidLabel)
    }
    
    //  FORTH CONTAINER
    func setupForthContainer (containerView: UIView) {
        
        // DEAL BUTTON
        self.dealButton = UIButton(frame: CGRect(
            x: 20,
            y: 25,
            width: containerView.frame.width - 40,
            height: containerView.frame.height * kThird))
        self.dealButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.dealButton.layer.borderWidth = 2.0
        self.dealButton.setTitle("D E A L", forState: UIControlState.Normal)
        self.dealButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.dealButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Highlighted)
        self.dealButton.titleLabel?.font = UIFont(name: "AvenirNext-Heavy", size: 30)
        self.dealButton.addTarget(
            self,
            action: "dealButtonPressed:",
            forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.dealButton)
        
        // RESET BUTTON
        self.resetButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: buttonDiameter,
            height: buttonDiameter))
        self.resetButton.center = CGPoint(
            x: containerView.bounds.width * (kFifth * 1),
            y: containerView.bounds.height * (kFourth * 3))
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.layer.masksToBounds = true
        self.resetButton.layer.cornerRadius = 0.5 * resetButton.bounds.size.width
        self.resetButton.layer.borderWidth = 2
        self.resetButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.resetButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.resetButton.titleLabel?.font = UIFont(name: "ArialMT-Bold", size: 10)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(resetButton)
        
        // BET ONE BUTTON
        self.betOneButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: buttonDiameter,
            height: buttonDiameter))
        self.betOneButton.center = CGPoint(
            x: containerView.bounds.width * kHalf,
            y: containerView.bounds.height * (kFourth * 3))
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.betOneButton.titleLabel?.font = UIFont(name: "ArialMT-Bold", size: 5)
        self.betOneButton.layer.borderColor = UIColor.orangeColor().CGColor
        self.betOneButton.layer.masksToBounds = true
        self.betOneButton.layer.borderWidth = 2
        self.betOneButton.layer.cornerRadius = 0.5 * betOneButton.bounds.size.width
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betOneButton)
        
        // BET MAX BUTTON
        self.betMaxButton = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: buttonDiameter,
            height: buttonDiameter))
        self.betMaxButton.center = CGPoint(
            x: containerView.bounds.width * (kFifth * 4),
            y: containerView.bounds.height * (kFourth * 3))
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Highlighted)
        self.betMaxButton.titleLabel?.font = UIFont(name: "ArialMT-Bold", size: 5)
        self.betMaxButton.layer.borderColor = UIColor.redColor().CGColor
        self.betMaxButton.layer.masksToBounds = true
        self.betMaxButton.layer.borderWidth = 2
        self.betMaxButton.layer.cornerRadius = 0.5 * betMaxButton.bounds.size.width
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(betMaxButton)
    }
    
    //  HELPER FUNCTIONS
    
    // REMOVE IMAGES
    func removeSlotImageViews() {
        if self.secondContainer != nil {
            let container: UIView? = self.secondContainer
            let subViews: Array? = container!.subviews
            for view in subViews! {
                view.removeFromSuperview()
            }
        }
    }
    
    //  HARD RESET
    func hardReset() {
        self.removeSlotImageViews()
        self.slotsArrays.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        self.credits = 100
        self.currentBet = 0
        self.winnings = 0
        
        self.updateMainView()
    }
    
    //  UPDATE MAINVIEW
    func updateMainView() {
        self.creditsLabel.text = "\(credits)"
        self.betLabel.text = "\(currentBet)"
        self.winnerPaidLabel.text = "\(winnings)"
    }
    
    //  ALERTS
    func showAlertWithText(header: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
