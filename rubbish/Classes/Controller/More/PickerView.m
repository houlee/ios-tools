    //
//  PickerView.m
//  caibo
//
//  Created by user on 11-7-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PickerView.h"
#import "TuisongtongzhiButtonController.h"
#import "datafile.h"

#import "YDDebugTool.h"
@implementation PickerView

@synthesize list, time1, time2,completeButton;
@synthesize delegate;


static PickerView *pView;

+ (PickerView *)getInstance
{
    @synchronized(pView)
    {
        if (!pView) 
        {
            pView = [[self alloc] init];
        }
        return pView;
    }
    return nil;
}



- (id)init
{
	self = [super init];
    if (self){
		
		
       
#ifdef isCaiPiaoForIPad
         [self setFrame:CGRectMake(0, 640, 540, 260)];
#else
        CGRect mainSF = [[UIScreen mainScreen] applicationFrame];
         CGFloat y0 = mainSF.size.height;
         [self setFrame:CGRectMake(0, y0, 320, 260)];
#endif
       
		
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [toolBar setBarStyle:UIBarStyleBlackTranslucent];
        [toolBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
		NSMutableArray *barItems = [[NSMutableArray alloc] init];
		UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
		[barItems addObject:spaceItem];
		[spaceItem release];
		UIBarButtonItem *finishButton = [[UIBarButtonItem alloc] initWithTitle:(@"完成") style:(UIBarButtonItemStyleDone) target:(self) action:(@selector(finishclick:))];
		[barItems addObject:finishButton];
        finishButton.enabled = YES;
        self.completeButton = finishButton;
		[finishButton release];
		[toolBar setItems:barItems];
		[barItems release];
		[self addSubview:toolBar];
		[toolBar release];
		
#ifdef isCaiPiaoForIPad
        UIView * timesPickerBGView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 44, 540, 216.0)]autorelease ];
                                                                                                     
#else
        UIView * timesPickerBGView = [[[UIView alloc] initWithFrame: CGRectMake(0.0, 44, self.frame.size.width, 216.0)] autorelease];
#endif
        timesPickerBGView.backgroundColor = [UIColor whiteColor];
		[self addSubview:timesPickerBGView];
        
        UIPickerView * timesPickerView = [[UIPickerView alloc] initWithFrame:timesPickerBGView.bounds];		timesPickerView.showsSelectionIndicator = YES;
		[timesPickerView setBackgroundColor: [UIColor clearColor]];
		[timesPickerView setDataSource: self];
		[timesPickerView setDelegate: self];
		[timesPickerBGView addSubview: timesPickerView];
		NSArray *array = [[NSArray alloc] initWithObjects: @"0:00", @"1:00", @"2:00", @"3:00", @"4:00", @"5:00", @"6:00", @"7:00", @"8:00", @"9:00",
						  @"10:00", @"11:00", @"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00", @"19:00", @"20:00", @"21:00", @"22:00", @"23:00", nil];
		self.list = array;
		[timesPickerView reloadAllComponents];
		[array release];
        [datafile setdata:@"0:00" forkey:KEY_BEGIN_TIME];
        [datafile setdata:@"23:00" forkey:KEY_END_TIME];
		NSString *component0_time = [datafile getDataByKey: KEY_BEGIN_TIME];
		NSString *sub = [component0_time substringToIndex: 2];
		NSInteger title_row1 = [sub intValue];
		[timesPickerView selectRow: title_row1 inComponent: 0 animated: YES];

		NSString *component1_time = [datafile getDataByKey: KEY_END_TIME];
		NSString *sub2 = [component1_time substringToIndex: 2];
		NSInteger title_row2 = [sub2 intValue];
		[timesPickerView selectRow: title_row2 inComponent: 1 animated: YES];
		[timesPickerView release];
		
	}
	return self;
}



- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
	
	return;
}


//选择器中的组件数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 2;
}


//每个组件中的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	
	return 24;
}


//为每行设置标题（字符串）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
//    self.completeButton.enabled = NO;
	return [self.list objectAtIndex: row];
	
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	if (component == 0) {
		time1 = nil;
		time1 = [self.list objectAtIndex: row];
	}
	
	else if(component == 1){
		time2 = nil;
		time2 = [self.list objectAtIndex: row];
	}
//    self.completeButton.enabled = YES;
}



- (void)show
{
    if (!self) 
    {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
#ifdef isCaiPiaoForIPad
    
    [self setFrame:CGRectMake(0, 620-283, 540, 260)];
#else
    
    CGRect mainSF = [[UIScreen mainScreen] applicationFrame];
    CGFloat y1 = mainSF.size.height - pView.frame.size.height - 44;
//     CGFloat y1 = mainSF.size.height - 200;
    [self setFrame:CGRectMake(0, y1, 320, 260)];
#endif
    [UIView commitAnimations];
}



- (void)disappear
{
	if (!self) 
    {
        return;
    }
	
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
#ifdef isCaiPiaoForIPad
    [self setFrame:CGRectMake(0, 640, 540, 260)];
#else
    CGRect mainSF = [[UIScreen mainScreen] applicationFrame];
    CGFloat y0 = mainSF.size.height + 44;
    [self setFrame:CGRectMake(0, y0, 320, 260)];
#endif
    
    [UIView commitAnimations];
}



- (void) finishclick: (id)sender
{
//    self.completeButton.enabled = NO;
	[self disappear];
	if (time1 == nil) {
		time1 = (NSMutableString *)[datafile getDataByKey: KEY_BEGIN_TIME];
	}
	if (time2 == nil) {
		time2 = (NSMutableString *)[datafile getDataByKey: KEY_END_TIME];
	}
	[datafile setdata: time1 forkey: KEY_BEGIN_TIME];
	[datafile setdata: time2 forkey: KEY_END_TIME];
	
	NSMutableString *time = [[NSMutableString alloc] init];
    if (time1 != nil && time2 != nil) {
       	[time appendString: time1];
        [time appendString: @"--"];
        [time appendString: time2];
        if ([delegate respondsToSelector:@selector(updata_time:)]) {
            [delegate performSelector:@selector(updata_time:)withObject:time];
        }

    }
    [time release];
//	[time appendString: time1];
//	[time appendString: @"--"];
//	[time appendString: time2];
//    if ([delegate respondsToSelector:@selector(updata_time:)]) {
//        [delegate performSelector:@selector(updata_time:)withObject:time];
//    }
//	[delegate updata_time: (NSString *)time];
	
//	[time release];
}



- (void)viewDidUnload {
    self.completeButton = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



- (void)dealloc
{
    [completeButton release];
	[pView release];
	[list release];
	[time1 release];
	[time2 release];
	[super dealloc];
}



@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    