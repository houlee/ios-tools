//
//  GCScrollView.m
//  caibo
//
//  Created by houchenguang on 14-4-22.
//
//

#import "GCScrollView.h"

@implementation GCScrollView
@synthesize delegatea;

- (void)dealloc{
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{

    if([view isKindOfClass:[UIButton class]]){
        
        
        if (delegatea&&[delegatea respondsToSelector:@selector(btnTouchesBegan)]) {
            
            [delegatea btnTouchesBegan];
        }
        
    }
    
    return YES;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view{

    if([view isKindOfClass:[UIButton class]]){
        
        
        if (delegatea&&[delegatea respondsToSelector:@selector(btnTouchesCancel)]) {
            
            [delegatea btnTouchesCancel];
        }
        
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (delegatea&&[delegatea respondsToSelector:@selector(touchesBeganFunc)]) {
        
        [delegatea touchesBeganFunc];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    