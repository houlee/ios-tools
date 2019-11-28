//
//  StartGuidanceView.m
//  caibo
//
//  Created by houchenguang on 14-5-14.
//
//

#import "StartGuidanceView.h"

@implementation StartGuidanceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
      
       
        
        self.backgroundColor  = [UIColor whiteColor];
        UIImageView * bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 143)/2, 110, 143, 148)];
        bigImageView.backgroundColor = [UIColor clearColor];
        bigImageView.image  = UIImageGetImageFromName(@"daqianbaoimage.png");
        [self addSubview:bigImageView];
        [bigImageView release];
        
        UILabel * kfLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 282, 150, 15)];
        kfLabel.backgroundColor = [UIColor clearColor];
        kfLabel.text = @"余额理财2.0";
        kfLabel.textColor = [UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
        kfLabel.textAlignment = NSTextAlignmentLeft;
        kfLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:kfLabel];
        [kfLabel release];
        
        UIImageView * lcImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 172)/2, 303, 172, 42)];
        lcImageView.backgroundColor = [UIColor clearColor];
        lcImageView.image = UIImageGetImageFromName(@"licai365image.png");
        [self addSubview:lcImageView];
        [lcImageView release];
        
        UIImageView * cpImageView = [[UIImageView alloc] initWithFrame:CGRectMake((320 - 163)/2, 355, 163, 18)];
        cpImageView.backgroundColor = [UIColor clearColor];
        cpImageView.image = UIImageGetImageFromName(@"cpsyimagelc.png");
        [self addSubview:cpImageView];
        [cpImageView release];
        
        UIImageView * twoLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 355+ 38-1, 320, 1)];
        twoLineImage.backgroundColor = [UIColor clearColor];
        twoLineImage.image = UIImageGetImageFromName(@"xuxiancjb.png");
        [self addSubview:twoLineImage];
        [twoLineImage release];
        
        UILabel * jjLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 355+ 58, 320, 15)];
        jjLabel.backgroundColor = [UIColor clearColor];
        jjLabel.text = @"基金服务商-易方达基金";
        jjLabel.textColor = [UIColor colorWithRed:193/255.0 green:185/255.0 blue:163/255.0 alpha:1];
        jjLabel.textAlignment = NSTextAlignmentCenter;
        jjLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:jjLabel];
        [jjLabel release];
        
//        UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.bounds];
//        bgimage.backgroundColor = [UIColor clearColor];
//        if (IS_IPHONE_5) {
//            bgimage.image = UIImageGetImageFromName(@"yindaotuimage_1.jpg");
//        }else{
//            bgimage.image = UIImageGetImageFromName(@"yindaotuimage.jpg");
//        }
//        [self addSubview:bgimage];
//        [bgimage release];
        
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