//
//  ForecastNumImageView.m
//  caibo
//
//  Created by GongHe on 13-12-27.
//
//

#import "ForecastNumImageView.h"

@implementation ForecastNumImageView
@synthesize numLabel;

- (void)dealloc
{
    [numLabel release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        numLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self addSubview:numLabel];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.font = [UIFont systemFontOfSize:12];
        numLabel.textAlignment = 1;
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

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    