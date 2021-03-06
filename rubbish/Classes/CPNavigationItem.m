//
//  CPNavigationItem.m
//  caibo
//
//  Created by yaofuyu on 12-12-12.
//
//

#import "CPNavigationItem.h"

@implementation CPNavigationItem

@synthesize title             = _title;
@synthesize titleView         = _titleView;
@synthesize titleLabel        = _titleLabel;
@synthesize hidesBackButton;
@synthesize leftBarButtonItem = _leftBarButtonItem;
@synthesize rightBarButtonItem= _rightBarButtonItem;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        // Initialization code
        _titleLabel = [[UILabel alloc] init];
#ifdef isCaiPiaoForIPad
        _titleLabel.frame = CGRectMake(0, 0, frame.size.width -40, self.frame.size.height);
#else
         _titleLabel.frame = CGRectMake(0, 0, frame.size.width -90, self.frame.size.height );
#endif
        _titleLabel.center = CGPointMake(self.bounds.size.width/2, (self.bounds.size.height )/2);
        [self addSubview:_titleLabel];
        [_titleLabel release];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        
        self.barImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0 - 20, 320, 20)] autorelease];
        self.barImage.backgroundColor = self.backgroundColor;
        [self addSubview:self.barImage];
        
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
        _lineView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.15];
        _lineView.frame = CGRectMake(0, self.bounds.size.height - 0.5, 320, 0.5);
        [_lineView release];
        _lineView.hidden = YES;
        
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
#ifdef isCaiPiaoForIPad
    _titleLabel.frame = CGRectMake(0, 0, frame.size.width -40, self.frame.size.height);
#else
    _titleLabel.frame = CGRectMake(0, 0 , frame.size.width -90, self.frame.size.height );
#endif
    
    _titleLabel.center = CGPointMake(self.bounds.size.width/2, (self.bounds.size.height )/2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem1 {
    NSLog(@"%@",leftBarButtonItem1.customView);
    [_leftBtn removeFromSuperview];
    [_leftBtn release];
    [_leftBarButtonItem release];
    _leftBarButtonItem = [leftBarButtonItem1 retain];
    _leftBtn = (UIButton *)leftBarButtonItem1.customView;
    [self addSubview:_leftBtn];
    _leftBtn.hidden = hidesBackButton;
    _leftBtn.center = CGPointMake( _leftBtn.frame.size.width/2 + 5, (self.frame.size.height )/2);
    [_leftBtn retain];
}

- (void)setHidesBackButton:(BOOL)_hidesBackButton {
    hidesBackButton = _hidesBackButton;
        _leftBtn.hidden = hidesBackButton;
}

- (void)setTitleView:(UIView *)titleView {
    [_titleView removeFromSuperview];
    [_titleView release];
    _titleView = [titleView retain];
    if (titleView) {
        _titleLabel.hidden = YES;
    }
    else {
        _titleLabel.hidden = NO;
    }
    
    [self insertSubview:titleView atIndex:0];
    NSLog(@"%@",self.subviews);
}

- (void)setTitle:(NSString *)title {
    [_title release];
    _title = [title retain];
    _titleLabel.text = title;
}

- (void)changeleftTo:(CGRect)rect {
    _leftBtn.frame = rect;
}

- (void)changeRightTo:(CGRect)rect {
    _rightBtn.frame = rect;
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem1 {
    [_rightBtn release];
    [_rightBtn removeFromSuperview];
    [_rightBarButtonItem release];
    _rightBarButtonItem = [rightBarButtonItem1 retain];
    _rightBtn = (UIButton *)rightBarButtonItem1.customView;
    [self addSubview:_rightBtn];
    _rightBtn.center = CGPointMake(self.frame.size.width - _rightBtn.frame.size.width/2-5, (self.frame.size.height )/2);
    [_rightBtn retain];
}


- (void)markNavigationViewUserName:(NSString *)name{
    
    [self setHidesBackButton:YES];
    UILabel * userNameLabe = [[UILabel alloc] initWithFrame:CGRectMake(10, 4 , 300, 20)];
    userNameLabe.backgroundColor = [UIColor clearColor];
    userNameLabe.tag = 11;
    userNameLabe.textColor = [UIColor whiteColor];
    userNameLabe.font = [UIFont boldSystemFontOfSize:16];
    userNameLabe.textAlignment = NSTextAlignmentLeft;
    userNameLabe.text = name;
    [self addSubview:userNameLabe];
    [userNameLabe release];
    
    
    UILabel * caiPiaoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20 , 300, 20)];
    caiPiaoLabel.backgroundColor = [UIColor clearColor];
    caiPiaoLabel.tag = 12;
    caiPiaoLabel.textColor = [UIColor whiteColor];
    caiPiaoLabel.font = [UIFont boldSystemFontOfSize:10];
    caiPiaoLabel.textAlignment = NSTextAlignmentLeft;
    caiPiaoLabel.text = @"365 yuecai365.com";
    [self addSubview:caiPiaoLabel];
    [caiPiaoLabel release];
    
    
}

- (void)clearMarkLabel{
    [self setHidesBackButton:NO];
    UILabel * userNameLabel = (UILabel *)[self viewWithTag:11];
    UILabel * caiPiaoLabel = (UILabel *)[self viewWithTag:12];
    [userNameLabel removeFromSuperview];
    [caiPiaoLabel removeFromSuperview];
}



- (void)dealloc {
    self.barImage = nil;
    [_rightBarButtonItem release];
    [_leftBarButtonItem release];
    [_titleView release];
    [_title release];
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    