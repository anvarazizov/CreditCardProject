//
//  PCWalletViewController.m
//  CreditCardProject
//
//  Created by Anvar Azizov on 2014-05-21.
//  Copyright (c) 2014 Anvar Azizov. All rights reserved.
//

#import "PCWalletViewController.h"
#import "NameGenerator.h"

#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))

@interface PCWalletViewController ()

@end

@implementation PCWalletViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
	{
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
    
	PCCreditCardDate validDate;
	validDate.mo = RAND_FROM_TO(1, 12);
	validDate.year = RAND_FROM_TO(10, 25);
	
	PCCreditCard * initialCard = [PCCreditCard creditCardWithNumber:[self generateCardNumber] validTo:validDate owner:@"me" cardCVV:[self generateCVV]];
	
	NSArray * initialCards = [[NSArray alloc] initWithObjects:initialCard, nil];
	self.cards = initialCards;

	[initialCards release];
}

- (void)viewDidAppear:(BOOL)animated
{
	[self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.cards count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
	
    cell.textLabel.text = [self.cards[indexPath.row] number];
    
    return cell;
}

- (IBAction)addCard:(id)sender
{
	NSMutableArray * tempArray = [[NSMutableArray alloc] initWithArray:self.cards];
	
	[tempArray addObject:[self generateRandomCard]];
	self.cards = tempArray;
	[tempArray release];
	
	[self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"showCreditCardDetails"]) {
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        PCCreditCardVC * destViewController = segue.destinationViewController;
		
		destViewController.creditCard = [self.cards objectAtIndex:indexPath.row];
    }
}

- (PCCreditCard *)generateRandomCard
{
	PCCreditCardDate validDate;
	validDate.mo = RAND_FROM_TO(1, 12);
	validDate.year = RAND_FROM_TO(10, 25);
	
	NameGenerator * nameGenerator = [[NameGenerator alloc] init];
	NSString * randomName = [nameGenerator getName:YES male:YES prefix:NO postfix:YES];
	
	PCCreditCard * myCard = [[PCCreditCard alloc] initWithNumber:[self generateCardNumber] validTo:validDate owner:randomName cardCVV:[self generateCVV]];
	
	[nameGenerator release];
	[myCard autorelease];
	
	return myCard;
}

- (NSString *)generateCardNumber
{
	
	NSInteger part1 = RAND_FROM_TO(4000, 5999);
	NSInteger part2 = RAND_FROM_TO(1000, 9999);
	NSInteger part3 = RAND_FROM_TO(1000, 9999);
	NSInteger part4 = RAND_FROM_TO(1000, 9999);
	
	NSString * cardNumberString = [NSString stringWithFormat:@"%d %d %d %d", part1, part2, part3, part4];
	
    return cardNumberString;
}

- (NSString *)generateCVV
{
	NSInteger randomCVV = RAND_FROM_TO(100, 999);
	NSString * stringCVV = [NSString stringWithFormat:@"%d", randomCVV];
	
	return stringCVV;
}


- (void)setCards:(NSArray *)cards
{
	if (_cards != cards)
	{
		[_cards release];
		_cards = [cards copy];
	}
	NSLog(@"%d", cards.retainCount);
}

- (void)dealloc
{
	[_cards release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}

@end
