//
//  YiLouTuScrollView.m
//  caibo
//
//  Created by houchenguang on 13-2-26.
//
//

#import "YiLouTuScrollView.h"

@implementation YiLouTuScrollView
@synthesize mdelegate;

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self returnScrollViewTouch:YES];

}

- (void)returnScrollViewTouch:(BOOL)touchbool{
    if ([mdelegate respondsToSelector:@selector(returnScrollViewTouch:)]) {
        [mdelegate returnScrollViewTouch:touchbool];
    }
}

- (void)dealloc{
    [super dealloc];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    