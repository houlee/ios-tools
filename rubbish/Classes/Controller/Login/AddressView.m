//
//  AddressView.m
//  caibo
//
//  Created by Kiefer on 11-6-9.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "AddressView.h"
#import "Info.h"

@implementation AddressView

@synthesize delegate;

static AddressView *mAddressView;
static NSInteger startId;

// 单例
+ (AddressView*)getInstance
{
    @synchronized(mAddressView)
    {
        if (!mAddressView) 
        {
            mAddressView = [[self alloc] init];
        }
        return mAddressView;
    }
    return nil;
}

// 视图初始化
- (id)init
{
    self = [super init];
    if (self) 
    {
        [self parameterInit];
        
        CGRect mainSF = [[UIScreen mainScreen] applicationFrame];
        CGFloat y0 = mainSF.size.height;
        [self setFrame:CGRectMake(0, y0, 320, 260)];

        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
        [toolBar setBarStyle:UIBarStyleBlackTranslucent];
        [toolBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth)];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        
        UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle:(@"取消") style:(UIBarButtonItemStyleDone) target:(self) action:(@selector(dimiss))];
        [barItems addObject:btnCancel];
        [btnCancel release];
        
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
        [barItems addObject:spaceItem];
        [spaceItem release];
        
        UIBarButtonItem *btnFinish = [[UIBarButtonItem alloc] initWithTitle:(@"完成") style:(UIBarButtonItemStyleDone) target:(self) action:(@selector(doFinish))];
        [barItems addObject:btnFinish];
        [btnFinish release];
        
        [toolBar setItems:barItems];
        [barItems release];
        
        [self addSubview:toolBar];
        [toolBar release];
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.frame.size.width, 216)];
        [pickerView setBackgroundColor:[UIColor clearColor]];
        [pickerView setShowsSelectionIndicator:YES];
        [pickerView setDataSource:self];
        [pickerView setDelegate:self];
        [self addSubview:pickerView];
        [pickerView release];
    }
    return self;
}

- (void)dealloc
{
    [mAddressView release];
    [dict release];
    [provinces release];
    [citystart release];
    [provinceName release];
    [cityName release];
    [super dealloc];
}

//参数初始化
- (void)parameterInit
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"plist"];    
    dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    provinces = [[NSArray alloc] initWithObjects:
                 @"北京市",
                 @"天津市",
                 @"上海市",
                 @"重庆市",
                 @"河北省",
                 @"山西省",
                 @"台湾省",
                 @"辽宁省",
                 @"吉林省",
                 @"黑龙江省",
                 @"江苏省",
                 @"浙江省",
                 @"安徽省",
                 @"福建省",
                 @"江西省",
                 @"山东省",
                 @"河南省",
                 @"湖北省",
                 @"湖南省",
                 @"广东省",
                 @"甘肃省",
                 @"四川省",
                 @"贵州省",
                 @"海南省",
                 @"云南省",
                 @"青海省",
                 @"陕西省",
                 @"广西壮族自治区",
                 @"西藏自治区",
                 @"宁夏回族自治区",
                 @"新疆维吾尔自治区",
                 @"内蒙古自治区",
                 @"澳门特别行政区",
                 @"香港特别行政区",
                 nil];
    citys = [dict objectForKey:(@"北京市")];
    citystart = [[NSArray alloc] initWithObjects:
                 [NSNumber numberWithInteger:(1)],
                 [NSNumber numberWithInteger:(2)],
                 [NSNumber numberWithInteger:(3)],
                 [NSNumber numberWithInteger:(4)],
                 [NSNumber numberWithInteger:(5)],
                 [NSNumber numberWithInteger:(16)],
                 [NSNumber numberWithInteger:(27)],
                 [NSNumber numberWithInteger:(50)],
                 [NSNumber numberWithInteger:(64)],
                 [NSNumber numberWithInteger:(73)],
                 [NSNumber numberWithInteger:(86)],
                 [NSNumber numberWithInteger:(99)],
                 [NSNumber numberWithInteger:(110)],
                 [NSNumber numberWithInteger:(127)],
                 [NSNumber numberWithInteger:(136)],
                 [NSNumber numberWithInteger:(147)],
                 [NSNumber numberWithInteger:(164)],
                 [NSNumber numberWithInteger:(182)],
                 [NSNumber numberWithInteger:(199)],
                 [NSNumber numberWithInteger:(213)],
                 [NSNumber numberWithInteger:(234)],
                 [NSNumber numberWithInteger:(248)],
                 [NSNumber numberWithInteger:(269)],
                 [NSNumber numberWithInteger:(278)],
                 [NSNumber numberWithInteger:(296)],
                 [NSNumber numberWithInteger:(312)],
                 [NSNumber numberWithInteger:(320)],
                 [NSNumber numberWithInteger:(330)],
                 [NSNumber numberWithInteger:(344)],
                 [NSNumber numberWithInteger:(351)],
                 [NSNumber numberWithInteger:(356)],
                 [NSNumber numberWithInteger:(378)],
                 [NSNumber numberWithInteger:(390)],
                 [NSNumber numberWithInteger:(391)],
                 nil];
    provinceName = [provinces objectAtIndex:0];
    cityName = [citys objectAtIndex:0];
    provinceId = 1;
    cityId = 1;
}

// 地址选择器弹出
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
    CGRect mainSF = [[UIScreen mainScreen] applicationFrame];
    CGFloat y1 = mainSF.size.height - mAddressView.frame.size.height - 44;
    [self setFrame:CGRectMake(0, y1, 320, 260)];
    [UIView commitAnimations];
}

// 地址选择器关闭
- (void)dimiss 
{
    if (!self) 
    {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.3];
    CGRect mainSF = [[UIScreen mainScreen] applicationFrame];
    CGFloat y0 = mainSF.size.height;
    [self setFrame:CGRectMake(0, y0, 320, 260)];
    [UIView commitAnimations];
}

// 完成
- (void)doFinish
{
    Info *mInfo = [Info getInstance];
    mInfo.provinceId = provinceId;
    mInfo.cityId = cityId;
    
//    NSLog(@"provinceId = %d", provinceId);
//    NSLog(@"cityId = %d", cityId);
//    
    [self getAddressWithId:provinceId :cityId]; 
    [delegate passValue:2 Value:[[Info getInstance] mAddress]];
    [self dimiss];
}

#pragma mark - 
#pragma mark 实现UIPickerViewDataSource接口

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{    
    return component == 0?[ provinces count]:[citys count];
}

#pragma mark - 
#pragma mark 重写UIPickerViewDelegate接口

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) 
    {
        return [provinces objectAtIndex:row];
    }
    else if(component == 1)
    {
        return [citys objectAtIndex:row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) 
    {
        provinceId = row + 1;
        
        provinceName = [provinces objectAtIndex:row];
        
        NSNumber *aNumber = [citystart objectAtIndex:row];
        startId = [aNumber intValue];
        cityId = startId;
        
        NSString *selKey = [provinces objectAtIndex:row];
        citys = [dict objectForKey:(selKey)];
        
        cityName = [citys objectAtIndex:0];
        
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
    }
    else if(component == 1)
    {
        cityName = [citys objectAtIndex:row];
        cityId = startId + row;
    }
}

// 根据返回的省份id和城市id取得地址
- (void)getAddressWithId:(NSInteger)pId :(NSInteger)cId
{
    if (pId == 0||pId > 34||cId == 0) 
    {
        return;
    }
    if (!dict) 
    {
        [self parameterInit];
    }
    NSString *pName = [provinces objectAtIndex:(pId - 1)];
    NSArray *cNames = [dict objectForKey:pName];
    NSNumber *aNumber = [citystart objectAtIndex:(pId - 1)];
    NSInteger startId = [aNumber intValue];
    if (cId < startId) 
    {
        return;
    }
    cId = cId - startId;
    NSString *cName = [cNames objectAtIndex:cId];
    if ([cName isEqualToString:pName]) 
    {
        [[Info getInstance] setMAddress:pName];
//        NSLog(@"pName = %@", [[Info getInstance] mAddress]);
        return;
    }
    NSMutableString *addressBuf = [[NSMutableString alloc] init];
    [addressBuf appendString:pName];
    [addressBuf appendString:@" "];
    [addressBuf appendString:cName];
    
    [[Info getInstance] setMAddress:addressBuf]; 
    [addressBuf release];
//    NSLog(@"address = %@", [[Info getInstance] mAddress]);
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    