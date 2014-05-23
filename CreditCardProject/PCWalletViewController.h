//
//  PCWalletViewController.h
//  CreditCardProject
//
//  Created by Anvar Azizov on 2014-05-21.
//  Copyright (c) 2014 Anvar Azizov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCCreditCard.h"
#import "PCCreditCardVC.h"

@interface PCWalletViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray * cards;

@end
