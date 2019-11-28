//
//  CP_TouZhuAlert.m
//  caibo
//
//  Created by yaofuyu on 14-3-14.
//
//

#import "CP_TouZhuAlert.h"
#import "FAQView.h"
#import "QuestionViewController.h"
#import "MLNavigationController.h"
#import "caiboAppDelegate.h"
#import "ImageUtils.h"

@implementation CP_TouZhuAlert
@synthesize title;
@synthesize backScrollView;
@synthesize buyResult;
@synthesize delegate;

#define ORIGIN_X(view) (view.frame.origin.x + view.frame.size.width)
#define ORIGIN_Y(view) (view.frame.origin.y + view.frame.size.height)

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.frame = [UIScreen mainScreen].bounds;
        self.title = @"提 示";
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
    }
    return self;
}

- (void)quxiao:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(CP_TouZhuAlert:didDismissWithButtonIndex:)]) {
        [delegate CP_TouZhuAlert:self didDismissWithButtonIndex:sender.tag];
    }
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
}

- (void)goWenHao:(UIButton *)sender{
        
//    FAQView *faq = [[FAQView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    faq.faqdingwei = Zhongjiang;
//    [faq Show];
//    [faq release];
    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
    
    QuestionViewController *qvc=[[QuestionViewController alloc]init];
    qvc.question = ZhongjiangType;
    [(MLNavigationController *)[caiboAppDelegate getAppDelegate].window.rootViewController pushViewController:qvc animated:YES];
    [qvc release];
}

- (void)show {
    UIImageView *backImageV = [[UIImageView alloc] init];
//    backImageV.image = UIImageGetImageFromName(@"TYHBG960-1.png");
    backImageV.image = [UIImageGetImageFromName(@"shuZiAlertBG1.png") stretchableImageWithLeftCapWidth:0 topCapHeight:22];
    backImageV.frame = CGRectMake(23, 100, 274, 328);
    backImageV.userInteractionEnabled = YES;
    [self addSubview:backImageV];
    backImageV.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    [backImageV release];
    
    
//    float backHeight = 10;
//    UIImageView *titleImage = nil;
//    if (self.title) {
//        titleImage = [[UIImageView alloc] init];
//        titleImage.image = UIImageGetImageFromName(@"TYCD960.png");
//        titleImage.frame = CGRectMake(87.5, 1, 125, 30);
//        [backImageV addSubview:titleImage];
//        UILabel *lable = [[UILabel alloc] initWithFrame:titleImage.bounds];
//        lable.text = self.title;
//        [titleImage addSubview:lable];
//        lable.textAlignment = NSTextAlignmentCenter;
//        
//        lable.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//        lable.font = [UIFont boldSystemFontOfSize:18];
//        lable.shadowColor = [UIColor whiteColor];//阴影
//        lable.shadowOffset = CGSizeMake(0, 1.0);
//        lable.backgroundColor = [UIColor clearColor];
//        [lable release];
//        [titleImage release];
////        backHeight = backHeight + 30;
//    }
    
//    UIImageView *infoImage = [[UIImageView alloc] init];
//    infoImage.image = [UIImageGetImageFromName(@"TYBG960.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
//    infoImage.userInteractionEnabled = YES;
//    [backImageV addSubview:infoImage];
//    infoImage.frame = CGRectMake(17, 40, 266, 225);
//    [infoImage release];
    
    UIImageView *duihaoImageV = [[UIImageView alloc] init];
    duihaoImageV.image = [UIImageGetImageFromName(@"touzhuchenggong.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    duihaoImageV.userInteractionEnabled = YES;
    [backImageV addSubview:duihaoImageV];
    duihaoImageV.frame = CGRectMake((backImageV.frame.size.width - 70)/2, 45, 70, 70);
    [duihaoImageV release];
    
    UILabel *lable1 = [[[UILabel alloc] init] autorelease];
    lable1.text = @"付款成功";
    [backImageV addSubview:lable1];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable1.font = [UIFont boldSystemFontOfSize:17];
    lable1.backgroundColor = [UIColor clearColor];
    CGSize lable1Size = [lable1.text sizeWithFont:lable1.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
    lable1.frame = CGRectMake(0, ORIGIN_Y(duihaoImageV) + 18, backImageV.frame.size.width, lable1Size.height);
    
    
    UILabel *lable2 = [[[UILabel alloc] init] autorelease];
    lable2.text = [NSString stringWithFormat:@"预计开奖时间:  %@",self.buyResult.kaijiangTime];;
    [backImageV addSubview:lable2];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable2.font = [UIFont systemFontOfSize:15];
    lable2.backgroundColor = [UIColor clearColor];
    CGSize lable2Size = [lable2.text sizeWithFont:lable2.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
    lable2.frame = CGRectMake(0, ORIGIN_Y(lable1) + 18, backImageV.frame.size.width, lable2Size.height);
    
    if ([self.buyResult.kaijiangTime length] < 3) {
        lable2.hidden = YES;
    }
    
    UILabel *lable3 = [[[UILabel alloc] init] autorelease];
    lable3.text = [NSString stringWithFormat:@"预计派奖时间:  %@",self.buyResult.paijiangTime];
    [backImageV addSubview:lable3];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.textColor = [UIColor  colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    lable3.font = [UIFont systemFontOfSize:15];
    lable3.backgroundColor = [UIColor clearColor];
    CGSize lable3Size = [lable3.text sizeWithFont:lable3.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
    lable3.frame = CGRectMake(0, ORIGIN_Y(lable2) + 10, backImageV.frame.size.width, lable3Size.height);
    
    if ([self.buyResult.paijiangTime length] < 3) {
        lable3.hidden = YES;
    }
    
//    UILabel *lable4 = [[[UILabel alloc] init] autorelease];
//    lable4.text = @"开奖后如何领奖";
//    [backImageV addSubview:lable4];
//    lable4.textAlignment = NSTextAlignmentRight;
//    lable4.textColor = [UIColor  colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
//    lable4.font = [UIFont boldSystemFontOfSize:16];
//    lable4.backgroundColor = [UIColor clearColor];
//    CGSize lable4Size = [lable4.text sizeWithFont:lable4.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
//    lable4.frame = CGRectMake(100, ORIGIN_Y(lable3) + 45, lable4Size.width, lable4Size.height);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [backImageV addSubview:btn];
    btn.tag = 999;
    [btn addTarget:self action:@selector(goWenHao:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"开奖后如何领奖        " forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    CGSize btnSize = [btn.titleLabel.text sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, INT_MAX)];
    btn.frame = CGRectMake(backImageV.frame.size.width - 15 - btnSize.width, ORIGIN_Y(lable3) + 30, btnSize.width, 24);
    
    UIImageView *wenhaoImage = [[UIImageView alloc] initWithFrame:CGRectMake(btnSize.width - 24, 0, 24, 24)];
    [btn addSubview:wenhaoImage];
    wenhaoImage.image = UIImageGetImageFromName(@"touwenhao.png");
    [wenhaoImage release];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor clearColor];
    btn1.frame = CGRectMake(0, backImageV.frame.size.height - 44, backImageV.frame.size.width/2, 44);
    [backImageV addSubview:btn1];
    btn1.tag = 0;
    [btn1 addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"关闭" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:18];

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor clearColor];
    btn2.frame = CGRectMake(ORIGIN_X(btn1),btn1.frame.origin.y, backImageV.frame.size.width/2, 44);
    [backImageV addSubview:btn2];
    btn2.tag = 1;
    [btn2 addTarget:self action:@selector(quxiao:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"方案详情" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:18];
    
    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];
    
}

- (void)dealloc {
    self.title = nil;
    self.backScrollView = nil;
    self.buyResult = nil;
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    