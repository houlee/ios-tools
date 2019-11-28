//
//  MyPickerView.m
//  caibo
//
//  Created by GongHe on 14-7-18.
//
//

#import "MyPickerView.h"
#import "caiboAppDelegate.h"
#import "ColorView.h"
#define DURATION 0.2
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)

@implementation MyPickerView
@synthesize delegate;

- (void)dealloc
{
    [pickerView release];
    [pickerBG release];
    [contentArray release];

    [super dealloc];
}

- (id)DefaultPickerView
{
    self = [super init];
    if (self) {
        [self initWithFrame:CGRectMake(0, [caiboAppDelegate getAppDelegate].window.bounds.size.height - 209.5, [caiboAppDelegate getAppDelegate].window.bounds.size.width, 209.5) contentArray:@[@"公开",@"保密",@"截止后公开",@"隐藏"]];
    }
    return self;
}

- (id)initWithContentArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        [self initWithFrame:CGRectMake(0, [caiboAppDelegate getAppDelegate].window.bounds.size.height - 209.5, [caiboAppDelegate getAppDelegate].window.bounds.size.width, 209.5) contentArray:array];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame contentArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        contentArray = [[NSArray alloc] initWithArray:array];
        
        self.frame = [caiboAppDelegate getAppDelegate].window.bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        [[caiboAppDelegate getAppDelegate].window addSubview:self];
        
        pickerBG = [[UIView alloc] init];
        pickerBG.backgroundColor = [UIColor clearColor];
        [self addSubview:pickerBG];
        
        UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 45)] autorelease];
        topView.userInteractionEnabled = YES;
        topView.tag = 2031;
        topView.backgroundColor = [UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
        [pickerBG addSubview:topView];
        
        UIButton * cancelButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 45)] autorelease];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        cancelButton.adjustsImageWhenHighlighted = NO;
        [topView addSubview:cancelButton];
        [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * rightButton = [[[UIButton alloc] initWithFrame:CGRectMake(topView.frame.size.width - 100, 0, 100, 45)] autorelease];
        rightButton.backgroundColor = [UIColor clearColor];
        [rightButton setTitle:@"确定" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:18];
        rightButton.adjustsImageWhenHighlighted = NO;
        [topView addSubview:rightButton];
        [rightButton addTarget:self action:@selector(right) forControlEvents:UIControlEventTouchUpInside];
        
        //ios7 以及 ios7一下均不使用系统的Picker
        if (0) {
            pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(topView), frame.size.width, frame.size.height)];
            pickerView.backgroundColor = [UIColor whiteColor];
            [pickerBG addSubview:pickerView];
            pickerView.showsSelectionIndicator = YES;
            pickerView.delegate = self;
            pickerView.dataSource = self;
            
            showFrame = CGRectMake(0, self.frame.size.height - (pickerView.frame.size.height + topView.frame.size.height), self.frame.size.width, pickerView.frame.size.height + topView.frame.size.height);
        }else{
            UIScrollView * scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(topView), frame.size.width, frame.size.height)] autorelease];
            for (int i = 0; i < contentArray.count; i++) {
                NSString *contentStr = [contentArray objectAtIndex:i];
                BOOL isTwoPath = NO;
                NSString *contentStr1 = nil;
                NSArray *contentStrArr1 = [contentStr componentsSeparatedByString:@"("];
                
                // @"2元优惠码   (   充值100以上可用)"
                if(contentStrArr1.count == 2){
                
                    isTwoPath = YES;
                    contentStr = [contentStrArr1 objectAtIndex:0];
                    contentStr1 = [NSString stringWithFormat:@"(%@",[contentStrArr1 objectAtIndex:1]];
                }
                CGSize contentStrSize = CGSizeMake(320, 42);
                CGSize contentStrSize1 = [contentStr sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:contentStrSize lineBreakMode:NSLineBreakByCharWrapping];
                
                CGSize contentStr1Size = CGSizeMake(320, 42);
                CGSize contentStr1Size1 = [contentStr1 sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:contentStr1Size lineBreakMode:NSLineBreakByCharWrapping];
                
                
                UILabel * contentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake((scrollView.frame.size.width-contentStrSize1.width-contentStr1Size1.width)/2.0, (scrollView.frame.size.height - 42)/2 + i * 42, contentStrSize1.width, 42)];
                contentLabel1.text = contentStr;
                contentLabel1.font = [UIFont systemFontOfSize:20];
                contentLabel1.backgroundColor = [UIColor clearColor];
                contentLabel1.textAlignment = 1;
                contentLabel1.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
                [scrollView addSubview:contentLabel1];
                [contentLabel1 release];
                
                
                if(isTwoPath){
                
                    UILabel * contentLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(contentLabel1.frame.origin.x+contentLabel1.frame.size.width, (scrollView.frame.size.height - 42)/2 + i * 42, contentStr1Size1.width, 42)];
                    contentLabel2.text = contentStr1;
                    contentLabel2.font = [UIFont systemFontOfSize:15];
                    contentLabel2.backgroundColor = [UIColor clearColor];
                    contentLabel2.textAlignment = 1;
                    contentLabel2.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
                    [scrollView addSubview:contentLabel2];
                    [contentLabel2 release];
                }
                
            }
            scrollView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            scrollView.contentSize = CGSizeMake(0, scrollView.frame.size.height + 42 * (contentArray.count - 1));
            scrollView.tag = 1000;
            scrollView.delegate = self;
            scrollView.showsVerticalScrollIndicator = NO;
            [pickerBG addSubview:scrollView];
            
            UIScrollView * scrollView1 = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, (scrollView.frame.size.height - 42)/2 + topView.frame.size.height, frame.size.width, 42)] autorelease];
            for (int i = 0; i < contentArray.count; i++) {
                
                
                NSString *contentStr = [contentArray objectAtIndex:i];
                BOOL isTwoPath = NO;
                NSString *contentStr1 = nil;
                NSArray *contentStrArr1 = [contentStr componentsSeparatedByString:@"("];
                
                // @"2元优惠码   (   充值100以上可用)"
                if(contentStrArr1.count == 2){
                    
                    isTwoPath = YES;
                    contentStr = [contentStrArr1 objectAtIndex:0];
                    contentStr1 = [NSString stringWithFormat:@"(%@",[contentStrArr1 objectAtIndex:1]];
                }
                CGSize contentStrSize = CGSizeMake(320, 42);
                CGSize contentStrSize1 = [contentStr sizeWithFont:[UIFont systemFontOfSize:22] constrainedToSize:contentStrSize lineBreakMode:NSLineBreakByCharWrapping];
                
                CGSize contentStr1Size = CGSizeMake(320, 42);
                CGSize contentStr1Size1 = [contentStr1 sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:contentStr1Size lineBreakMode:NSLineBreakByCharWrapping];
                
                UILabel * contentLabel = [[UILabel alloc] initWithFrame:CGRectMake((scrollView.frame.size.width-contentStrSize1.width-contentStr1Size1.width)/2.0, i * 42, contentStrSize1.width, 42)];
                contentLabel.text = contentStr;
                contentLabel.font = [UIFont systemFontOfSize:22];
                contentLabel.backgroundColor = [UIColor clearColor];
                contentLabel.textAlignment = 1;
                contentLabel.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                [scrollView1 addSubview:contentLabel];
                [contentLabel release];
                
                if(isTwoPath){
                
                    UILabel * contentLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(contentLabel.frame.origin.x+contentLabel.frame.size.width, i * 42, contentStr1Size1.width, 42)];
                    contentLabel1.text = contentStr1;
                    contentLabel1.font = [UIFont systemFontOfSize:15];
                    contentLabel1.backgroundColor = [UIColor clearColor];
                    contentLabel1.textAlignment = 1;
                    contentLabel1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
                    [scrollView1 addSubview:contentLabel1];
                    [contentLabel1 release];
                }
            }
            scrollView1.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            scrollView1.contentSize = CGSizeMake(0, scrollView1.frame.size.height + 42 * (contentArray.count - 1));
            scrollView1.tag = 1001;
            scrollView1.delegate = self;
            scrollView1.showsVerticalScrollIndicator = NO;
            [pickerBG addSubview:scrollView1];
            
            UIView * line = [[[UIView alloc] initWithFrame:CGRectMake(0, scrollView1.frame.origin.y - 0.5, frame.size.width, 0.5)] autorelease];
            line.backgroundColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
            [pickerBG addSubview:line];
            
            UIView * line1 = [[[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(scrollView1) + 0.5, frame.size.width, 0.5)] autorelease];
            line1.backgroundColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
            [pickerBG addSubview:line1];
            
            //上边的渐变阴影
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(topView), scrollView.frame.size.width, 30)];
            image.image=[[UIImage imageNamed:@"upshadow.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:30];
            [pickerBG addSubview:image];
            [image release];
            
            
            //下边的渐变阴影
            UIImageView *image1=[[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(scrollView) - 30, scrollView.frame.size.width, 30)];
            image1.image=[[UIImage imageNamed:@"downshadow.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:30];
            [pickerBG addSubview:image1];
            [image1 release];

            
            showFrame = CGRectMake(0, self.frame.size.height - (scrollView.frame.size.height + topView.frame.size.height), self.frame.size.width, scrollView.frame.size.height + topView.frame.size.height);
        }
        
        beginFrame = CGRectMake(showFrame.origin.x, self.frame.size.height, showFrame.size.width, showFrame.size.height);
        
        pickerBG.frame = beginFrame;
    }
    return self;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIScrollView * bigScrollView = (UIScrollView *)[pickerBG viewWithTag:1000];
    UIScrollView * smallScrollView = (UIScrollView *)[pickerBG viewWithTag:1001];
    
    if (scrollView.tag == 1000) {
        smallScrollView.contentOffset = CGPointMake(0, bigScrollView.contentOffset.y);
    }else{
        bigScrollView.contentOffset = CGPointMake(0, smallScrollView.contentOffset.y);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y >= 0) {
        if (scrollView.contentOffset.y/42 - (int)scrollView.contentOffset.y/42 > 0.5) {
            if ((int)scrollView.contentOffset.y/42 < contentArray.count - 1) {
                [scrollView setContentOffset:CGPointMake(0, ((int)scrollView.contentOffset.y/42 + 1) * 42) animated:YES];
            }
        }else{
            [scrollView setContentOffset:CGPointMake(0, (int)scrollView.contentOffset.y/42 * 42) animated:YES];
        }
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [contentArray objectAtIndex:row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return contentArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    contentString = [[contentArray objectAtIndex:row] copy];
}

-(void)showWithTitle:(NSString *)title
{
    if (title) {
        titleString = [title copy];
    }
    
    
    for (int i = 0; i < contentArray.count; i++) {
        if ([[contentArray objectAtIndex:i] isEqualToString:title]) {
            if (IS_IOS7) {
                [pickerView selectRow:i inComponent:0 animated:NO];
            }else{
                UIScrollView * bigScrollView = (UIScrollView *)[pickerBG viewWithTag:1000];
                bigScrollView.contentOffset = CGPointMake(0, i * 42);
            }
            break;
        }
    }
    [UIView animateWithDuration:DURATION animations:^{
        [[caiboAppDelegate getAppDelegate].window addSubview:self];
        pickerBG.frame = showFrame;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)right
{
    
    //ios7 与 ios7一下均不用系统Picker
//    if (!IS_IOS7) {
        UIScrollView * bigScrollView = (UIScrollView *)[pickerBG viewWithTag:1000];
        contentString = [contentArray objectAtIndex:(int)bigScrollView.contentOffset.y/42];
//    }
//    if ((!contentString || ![contentString length]) && titleString) {
//        contentString = [titleString copy];
//    }
    if (delegate && [delegate respondsToSelector:@selector(myPickerView:content:)]) {
        [delegate myPickerView:self content:contentString];
    }
    
    if(delegate && [delegate respondsToSelector:@selector(myPickerView:cellIndex:content:)]){
    
        [delegate myPickerView:self cellIndex:(int)bigScrollView.contentOffset.y/42 content:contentString];
    }
    [self cancel];
    
}

-(void)cancel
{
    [UIView animateWithDuration:DURATION animations:^{
        pickerBG.frame = beginFrame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    