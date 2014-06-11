//
//  PCEditCardViewController.m
//  CreditCardProject
//
//  Created by Anvar Azizov on 2014-06-04.
//  Copyright (c) 2014 Anvar Azizov. All rights reserved.
//

#import "PCEditCardViewController.h"

@interface PCEditCardViewController () <UITextFieldDelegate, UIPickerViewDelegate>

@property (retain, nonatomic) IBOutlet UITextField * numberLabel;
@property (retain, nonatomic) IBOutlet UITextField * ownerLabel;
@property (retain, nonatomic) IBOutlet UITextField * monthLabel;
@property (retain, nonatomic) IBOutlet UITextField * yearLabel;
@property (retain, nonatomic) IBOutlet UITextField * cvvLabel;
@property (retain, nonatomic) IBOutlet UIPickerView * monthPicker;

@end

@implementation PCEditCardViewController

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
	
	[self.numberLabel addTarget:self
				  action:@selector(textFieldDidEndEditing:)
		forControlEvents:UIControlEventEditingDidEnd];
	[self.ownerLabel addTarget:self
						 action:@selector(textFieldDidEndEditing:)
			   forControlEvents:UIControlEventEditingDidEnd];
	[self.ownerLabel addTarget:self
						action:@selector(textFieldDidBeginEditing:)
			  forControlEvents:UIControlEventEditingDidBegin];
	[self.monthLabel addTarget:self
						action:@selector(textFieldDidEndEditing:)
			  forControlEvents:UIControlEventEditingDidEnd];
	[self.monthLabel addTarget:self
						action:@selector(pickerView:didSelectRow:inComponent:)
			  forControlEvents:UIControlEventValueChanged];
	[self.yearLabel addTarget:self
					   action:@selector(textFieldDidEndEditing:)
			 forControlEvents:UIControlEventEditingDidEnd];
	[self.yearLabel addTarget:self
						action:@selector(pickerView:didSelectRow:inComponent:)
			  forControlEvents:UIControlEventValueChanged];
	[self.cvvLabel addTarget:self
					  action:@selector(textFieldDidEndEditing:)
			forControlEvents:UIControlEventEditingDidEnd];
		
	[self updateUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	self.creditCard.number = self.numberLabel.text;
	self.creditCard.owner = self.ownerLabel.text;
	[self.monthLabel.text integerValue];
	PCCreditCardDate validTo;
	validTo.mo = [self.monthLabel.text integerValue];
	validTo.year = [self.yearLabel.text integerValue];
	self.creditCard.validTo = validTo;
	self.creditCard.securityCode = self.cvvLabel.text;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"begin editing");
	self.ownerLabel.textColor = [UIColor redColor];
	self.ownerLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark Picker View

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
	PCCreditCardDate validDate;
	
	if (component == 0)
	{
		validDate.mo = row + 1;
		validDate.year = self.creditCard.validTo.year;
	}
	else
	{
		validDate.mo = self.creditCard.validTo.mo;
		validDate.year = row + 14;
	}
		self.creditCard.validTo = validDate;
	[self updateUI];
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSUInteger numRows = 12;
	
    return numRows;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}

// tell the picker the title for a given component
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title;
	if (component == 0)
		title = [@"" stringByAppendingFormat:@"%d",row + 1];
	else
		title = [@"" stringByAppendingFormat:@"%d", row + 14];
	
    return title;
}

// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	int sectionWidth = 80;
	
	return sectionWidth;
}

- (void)updateUI
{
	self.numberLabel.text = self.creditCard.number;
	self.ownerLabel.text = self.creditCard.owner;
	self.monthLabel.text = [NSString stringWithFormat:@"%d", self.creditCard.validTo.mo];
	self.yearLabel.text = [NSString stringWithFormat:@"%d", self.creditCard.validTo.year];
	self.cvvLabel.text = self.creditCard.securityCode;
}

- (void)dealloc
{
	[_numberLabel release];
	[_ownerLabel release];
	[_monthLabel release];
	[_yearLabel release];
	[_cvvLabel release];
	[_monthPicker release];
	[super dealloc];
}



@end
