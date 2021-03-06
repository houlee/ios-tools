//
//  TermSelectViewController.m
//  caibo
//
//  Created by lxzhh on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TermSelectViewController.h"
#import "LiveScoreViewController.h"
#import "caiboAppDelegate.h"

#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7)

@implementation TermSelectViewController
@synthesize  selectIssue,issues,settingConroller,topView,myPicker,mybar,myPickerBGView;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
-(id)initWithSettingController:(LiveScoreViewController*)controller{
	self.settingConroller = controller;
	return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)LoadIphoneView {
    NSInteger pian = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        pian = 20;
    }
    self.view.frame = CGRectMake(0, [caiboAppDelegate getAppDelegate].window.bounds.size.height, 320, [caiboAppDelegate getAppDelegate].window.bounds.size.height);
	//self.view.center = self.view.window.center;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.view.frame = CGRectMake(0, 0, 320, [caiboAppDelegate getAppDelegate].window.bounds.size.height + pian);
	[UIView commitAnimations];
	
    if (IS_IOS7) {
        myPicker.frame = CGRectMake(0, self.view.frame.size.height - 250, 320, 250);
        myPickerBGView.frame = CGRectMake(0, self.view.frame.size.height - 250, 320, 250);
    }
	
	[self performSelector:@selector(colorChange) withObject:nil afterDelay:0.5];
}

- (void)LoadIpadView {
    self.view.frame = CGRectMake(0, [caiboAppDelegate getAppDelegate].window.bounds.size.height, 390, 700);
    NSArray *array = [mybar items];
    if ([array count]>=2) {
        UIBarButtonItem *baritem = [array objectAtIndex:1];
        if ([baritem isKindOfClass:[UIBarButtonItem class]]) {
            baritem.width = 276;
        }
    }
	//self.view.center = self.view.window.center;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.view.frame = CGRectMake(0, 0, 320, [caiboAppDelegate getAppDelegate].window.bounds.size.height);
	[UIView commitAnimations];
	
	
	[self performSelector:@selector(colorChange) withObject:nil afterDelay:0.5];
	self.view.backgroundColor = [UIColor clearColor];
	self.view.frame = CGRectMake(0, [caiboAppDelegate getAppDelegate].window.bounds.size.height, 390, 700);
	//self.view.center = self.view.window.center;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.view.frame = CGRectMake(0, 0, 390, 700);
	[UIView commitAnimations];
	[self performSelector:@selector(colorChange) withObject:nil afterDelay:0.5];
}

- (void)viewDidLoad {
     [super viewDidLoad];
	self.view.backgroundColor = [UIColor clearColor];
#ifdef isCaiPiaoForIPad
    [self LoadIpadView];
#else
    [self LoadIphoneView];
#endif
	NSInteger select = [issues indexOfObject:selectIssue];
	if (select >= [issues count]||select <0) {
		select = 0;
	}
	[myPicker selectRow:select inComponent:0 animated:NO];
}


//改变topView的背景颜色
- (void)colorChange{
	self.topView.alpha = 0.5;
	self.topView.backgroundColor = [UIColor blackColor];
    myPicker.backgroundColor = [UIColor  whiteColor];
}


//试图消失
- (void)dismiss{

	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];

	self.view.frame = CGRectMake(0, [caiboAppDelegate getAppDelegate].window.bounds.size.height, 320, [caiboAppDelegate getAppDelegate].window.bounds.size.height);
	[UIView commitAnimations];
	self.topView.alpha = 0.0;
    [self.view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
	//[self.view removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return NO;
}
#pragma mark PickerView
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [issues count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	return [issues objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	if ([issues count]>0) {
		self.selectIssue = [issues objectAtIndex:row];
	}
	
}

-(IBAction)cancel{
	[self dismiss];
}

-(IBAction)confirm{
	[self dismiss];
	if (!self.selectIssue && [issues count] > 0) 
    {
		self.selectIssue = [issues objectAtIndex:0];
	}
	self.settingConroller.currentIssue = self.selectIssue;
	[self.settingConroller reloadTableData];
	
}
#pragma mark memory
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [self setMyPickerBGView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[topView release];
    self.settingConroller = nil;
	//[settingConroller release];
	[selectIssue release];
	[issues release];
    [mybar release];
	[myPicker release];
    [myPickerBGView release];
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    