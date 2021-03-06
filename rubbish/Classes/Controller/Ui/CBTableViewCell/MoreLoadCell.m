//
//  MoreLoadCell.m
//  caibo
//
//  Created by jacob on 11-6-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoreLoadCell.h"

#import"ColorUtils.h"

static NSString *sLabels[] = {
    @"更多...",
    @"",
    @"更新中...",
};

@implementation MoreLoadCell

@synthesize spinner;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        NSLog(@"width = %f", self.frame.size.width);
        
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        label = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width-300)/2, 0, 300, self.frame.size.height)];
        NSLog(@"x = %f", label.frame.origin.x);
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		label.backgroundColor = [UIColor clearColor];
		label.font = [UIFont systemFontOfSize:FONT_BIGER];
		label.textAlignment = NSTextAlignmentCenter;
		label.textColor = [UIColor blackColor];
		label.numberOfLines = 1;
//		label.text = @"更多...";
		[self.contentView addSubview:label];
		[label release];
        
        
//        _activityView = [[UIImageView alloc] init];
//        _activityView.frame = CGRectMake(150.5f, 20, 19.0f, 19.5f);
//        _activityView.image = UIImageGetImageFromName(@"yezi.png");
        
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
//        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
//            _activityView.layer.contentsScale = [[UIScreen mainScreen] scale];
//        }
//#endif
//        [self.contentView addSubview:_activityView];
//        [_activityView release];
        
        
		spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
		spinner.frame = CGRectMake(self.frame.size.width/2+100, self.frame.size.height/2, 16, 16);
		[self.contentView addSubview:spinner];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier rect:(CGRect)_rect 
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        label = [[UILabel alloc] init];
        label.bounds = CGRectMake((_rect.size.width-100)/2, 0, 100, _rect.size.height);
        NSLog(@"x = %f", label.frame.origin.x);
//        label.center = CGPointMake(_rect.size.width/2, _rect.size.height/2);
		label.backgroundColor = [UIColor clearColor];
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
		label.font = [UIFont systemFontOfSize:FONT_BIGER];
		label.textAlignment = NSTextAlignmentCenter;
        label.text = @"更多...";
		[self.contentView addSubview:label];
		[label release];
        
//        _activityView = [[UIImageView alloc] init];
//        _activityView.frame = CGRectMake(150.5f, 20, 19.0f, 19.5f);
//        _activityView.image = UIImageGetImageFromName(@"yezi.png");
        
        //#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
        //        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        //            _activityView.layer.contentsScale = [[UIScreen mainScreen] scale];
        //        }
        //#endif
//        [self.contentView addSubview:_activityView];
//        [_activityView release];
        
		spinner = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
		spinner.bounds = CGRectMake(0, 0, 16, 16);
        spinner.center = CGPointMake(_rect.size.width - 16/2 - 50, _rect.size.height/2);
		[self.contentView addSubview:spinner];
    }
    return self;
}
- (loadCellType)type{
    return type;
}
- (void)setType:(loadCellType)_type{
    type = _type;
    label.text = sLabels[type];
}
//- (void)setType:(loadCellType)aType
//{
//    type = aType;
//    label.text = sLabels[type];
//}
- (void)setCellStyle:(CellStyle)style
{
    cellStyle = style;
    if (cellStyle == StyleNormal) {
    }
    if (cellStyle == StyleOne) {
        [self.contentView setBackgroundColor:[UIColor clearColor]];  
    }
}
// 开始旋转
-(void)spinnerStartAnimating
{
	[spinner startAnimating];
    label.text = @"加载中...";
    
//    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * -M_PI) * 20 +arc4random()%4];
//    rotationAnimation.duration = 20.0f;
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    [_activityView.layer addAnimation:rotationAnimation forKey:@"run"];
//    _activityView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0); //
}

// 停止旋转
-(void)spinnerStopAnimating
{
	[spinner stopAnimating];
    label.text = @"更多...";
    
//    [_activityView stopAnimating];
//    [_activityView.layer removeAllAnimations];
}

// 开始旋转
-(void)spinnerStartAnimating2
{
    [self setType:MSG_TYPE_LOAD_LOADING];
    [spinner setHidden:NO];
	[spinner startAnimating];
    label.text = @"加载中...";
//    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
//    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * -M_PI) * 20 +arc4random()%4];
//    rotationAnimation.duration = 20.0f;
//    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    [_activityView.layer addAnimation:rotationAnimation forKey:@"run"];
//    _activityView.layer.transform = CATransform3DMakeRotation([rotationAnimation.toValue floatValue],0.0,0.0,1.0); //
}

// 停止旋转
-(void)spinnerStopAnimating2:(BOOL)isDataNone
{
    [spinner stopAnimating];
    if (isDataNone)
    {
        [self setType:MSG_TYPE_LOAD_NODATA];
    }
    else
    {
        [self setType:MSG_TYPE_LOAD_MORE];
    }
    label.text = @"更多...";
//    [_activityView stopAnimating];
//    [_activityView.layer removeAllAnimations];
}

- (void)setInfoText:(NSString *)text
{
    label.text = text;
    [spinner stopAnimating];
//    [_activityView stopAnimating];
//    [_activityView.layer removeAllAnimations];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated 
{    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}

- (void)dealloc 
{
    [super dealloc];
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    