//
//  PCCreditCard.h
//  CreditCardProject
//
//  Created by Anvar Azizov on 2014-04-25.
//  Copyright (c) 2014 Anvar Azizov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCCreditCard : NSObject
{
	NSString * number;
	NSString * owner;
	NSString * securityCode;
}
typedef struct
{
	NSUInteger month;
	NSUInteger year;
} PCCreditCardDate;

typedef enum
{
	PCCreditCardTypeVisa,
	PCCreditCardTypeMasterCard, 
} PCCreditCardType;

@property (nonatomic, retain) NSString * number;
@property (nonatomic, assign) PCCreditCardDate validTo;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSString * securityCode;
@property (nonatomic, assign, readonly) PCCreditCardType type;

+ (id)creditCardWithNumber:(NSString *)cardNumber validTo:(PCCreditCardDate)cardValidTo owner:(NSString *)cardOwner cardCVV:(NSString *)cardCVV;

- (id)initWithNumber:(NSString *)cardNumber validTo:(PCCreditCardDate)cardValidTo owner:(NSString *)cardOwner cardCVV:(NSString *)cardCVV;

@end
