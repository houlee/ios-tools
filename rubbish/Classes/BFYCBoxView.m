//
//  BFYCBoxView.m
//  caibo
//
//  Created by houchenguang on 14-5-27.
//
//

#import "BFYCBoxView.h"
#import "caiboAppDelegate.h"
#import "UIImageExtra.h"

@implementation BFYCBoxView
@synthesize  betData, delegate, typeButtonArray;

- (void)dealloc{
    if (scoreBall) {
        [scoreBall release];
    }
    if (ballBox) {
        [ballBox release];
    }
    [typeButtonArray release];
    [betData release];
    [super dealloc];
}



- (void)bifentypeFunc{
    
    self.backgroundColor = [UIColor clearColor];
    
    
    if (!scoreBall) {
        scoreBall = [[ScoreBallView alloc] initWithFrame:self.bounds betData:betData wangQi:NO];
    }
    
    scoreBall.delegate = self;
    scoreBall.bfycBool = YES;
    scoreBall.wangqiBool = NO;
    scoreBall.betData = betData;
    [self addSubview:scoreBall];


}
- (void)pressShangButton:(UIButton *)sender{
    
    if ([[self.typeButtonArray objectAtIndex:sender.tag] isEqualToString:@"0"]) {
       [self.typeButtonArray replaceObjectAtIndex:sender.tag withObject:@"1"];

        
            [sender setImage:UIImageGetImageFromName(@"tanchukuanganniu_1.png") forState:UIControlStateNormal];
        
        
    }else{
       [self.typeButtonArray replaceObjectAtIndex:sender.tag withObject:@"0"];
        
        [sender setImage:UIImageGetImageFromName(@"tanchukuanganniu.png") forState:UIControlStateNormal];
    }
    
    
    
    
    
}
- (void)pressquxiaobutton:(UIButton *)sender{
    [self removeFromSuperview];
}

- (void)pressbifenqueding:(UIButton *)sender{
    if (delegate && [delegate respondsToSelector:@selector(bfycBoxView:whithBetData:)]) {
         betData.bufshuarr = self.typeButtonArray;
        [delegate bfycBoxView:self whithBetData:betData];
    }
     [self removeFromSuperview];
}

- (void)beidanbifentypeFunc{
    
    self.backgroundColor = [UIColor clearColor];
    
  
    if (!ballBox) {
        ballBox = [[BallBoxView alloc] initWithFrame:self.bounds betData:betData wangQi:NO];
    }
    
    ballBox.delegate = self;
    ballBox.bfycBool = YES;
    ballBox.wangqiBool = NO;
    ballBox.betData = betData;
    [self addSubview:ballBox];
    
}


- (void)setBoxType:(BoxType)_boxType{
    boxType = _boxType;
    if ([betData.bufshuarr count]>0) {
        self.typeButtonArray = [NSMutableArray arrayWithArray:betData.bufshuarr];
    }else{
         self.typeButtonArray = [NSMutableArray arrayWithCapacity:31];
        for (int i = 0; i < 31; i++) {
            [self.typeButtonArray addObject:@"0"];
        }
    }
   
   
     if (boxType == jcbifenboxtype){
        [self bifentypeFunc];
    }else if (boxType == bdbifenboxtype){
        
        [self beidanbifentypeFunc];
    }
}

- (BoxType)boxType{
    return boxType;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
       
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
         caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
        self.frame = appDelegate.window.bounds;
       
        
    }
    return self;
}

- (void)bfycballBoxDelegateReturnData:(GC_BetData *)bd{//北单的弹出框 回调
    if (delegate && [delegate respondsToSelector:@selector(bfycBoxView:whithBetData:)]) {
//        betData.bufshuarr = self.typeButtonArray;
        [delegate bfycBoxView:self whithBetData:betData];
    }
    [self removeFromSuperview];
}

- (void)ballBoxDelegateRemove{//北单的取消
    [self removeFromSuperview];
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