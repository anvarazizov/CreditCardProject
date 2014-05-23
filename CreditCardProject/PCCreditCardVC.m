//
//  PCCreditCardVC.m
//  CreditCardProject
//
//  Created by Anvar Azizov on 2014-04-25.
//  Copyright (c) 2014 Anvar Azizov. All rights reserved.
//

#import "PCCreditCardVC.h"

@interface PCCreditCardVC ()

@property (retain, nonatomic) IBOutlet UILabel * cardNumberLabel;
@property (retain, nonatomic) IBOutlet UILabel * cardMonthLabel;
@property (retain, nonatomic) IBOutlet UILabel * cardYearLabel;
@property (retain, nonatomic) IBOutlet UILabel * cardOwnerLabel;
@property (retain, nonatomic) IBOutlet UILabel * cardCVVLabel;
@property (retain, nonatomic) IBOutlet UILabel * cardTypeLabel;

@end

@implementation PCCreditCardVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setCreditCard:(PCCreditCard *)creditCard
{
	if (_creditCard != creditCard)
	{
		[_creditCard release];
		_creditCard = [creditCard retain];
		[self updateUI];
	}
}

- (void)updateUI
{
	self.cardNumberLabel.text = _creditCard.number;
	self.cardMonthLabel.text = [NSString stringWithFormat:@"%d", self.creditCard.validTo.month];
	self.cardYearLabel.text = [NSString stringWithFormat:@"%d", self.creditCard.validTo.year];
	self.cardOwnerLabel.text = self.creditCard.owner;
	self.cardCVVLabel.text = self.creditCard.securityCode;
	
	if (self.creditCard.type == PCCreditCardTypeVisa)
		self.cardTypeLabel.text = @"Visa";
	
	if (self.creditCard.type == PCCreditCardTypeMasterCard)
		self.cardTypeLabel.text = @"MasterCard";
}

- (void)dealloc
{
	[_cardNumberLabel release];
	[_cardMonthLabel release];
	[_cardYearLabel release];
	[_cardOwnerLabel release];
	[_cardCVVLabel release];
	[_cardTypeLabel release];
	[super dealloc];
}
@end
