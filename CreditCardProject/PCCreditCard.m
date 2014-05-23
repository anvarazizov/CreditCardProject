//
//  PCCreditCard.m
//  CreditCardProject
//
//  Created by Anvar Azizov on 2014-04-25.
//  Copyright (c) 2014 Anvar Azizov. All rights reserved.
//

#import "PCCreditCard.h"

@implementation PCCreditCard

@synthesize number = _number;
@synthesize validTo = _validTo;
@synthesize owner = _owner;
@synthesize securityCode = _securityCode;
@synthesize type = _type;

+ (PCCreditCard *)creditCardWithNumber:(NSString *)cardNumber validTo:(PCCreditCardDate)cardValidTo owner:(NSString *)cardOwner cardCVV:(NSString *)cardCVV
{
	PCCreditCard * creditCard = [[PCCreditCard alloc] initWithNumber:cardNumber validTo:cardValidTo owner:cardOwner cardCVV:cardCVV];
	
	[creditCard autorelease];
	
	return creditCard;
}

- (id)initWithNumber:(NSString *)cardNumber validTo:(PCCreditCardDate)cardValidTo owner:(NSString *)cardOwner cardCVV:(NSString *)cardCVV
{
	self = [super init];
	if (self != nil)
	{
		self.number = cardNumber;
		self.validTo = cardValidTo;
		self.owner = cardOwner;
		self.securityCode = cardCVV;
	}
	
	return self;
}

- (void)cardType
{
	NSString * firstNum;
	NSRange range = NSMakeRange(0,1);
	firstNum = [_number substringWithRange:range];
	
	if ([firstNum isEqualToString:@"4"])
	{
		_type = PCCreditCardTypeVisa;
	}
	if ([firstNum isEqualToString:@"5"])
	{
		_type = PCCreditCardTypeMasterCard;
	}
}

- (void)setNumber:(NSString *)cardNumber
{
	if (_number != cardNumber)
	{
		[_number release];
		_number = [cardNumber retain];
		
		[self cardType];
	}
}

@end
