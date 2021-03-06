//
//  FootballHintView.m
//  caibo
//
//  Created by houchenguang on 14-10-13.
//
//

#import "FootballHintView.h"
#import "caiboAppDelegate.h"

@implementation FootballHintView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initType:(ShowType)type{
    self = [super init];
    if (self) {
        // Initialization code
        self.frame = [[UIScreen mainScreen] bounds];
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
        
        UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 293)/2, (self.frame.size.height - 208)/2, 293, 208)];
        backImageView.backgroundColor = [UIColor clearColor];
        backImageView.image = [UIImageGetImageFromName(@"tanchukuangone.png") stretchableImageWithLeftCapWidth:100 topCapHeight:20];
        backImageView.userInteractionEnabled = YES;
        [self addSubview:backImageView];
        [backImageView release];
        
        
        
        if (type == betShowType) {
            UILabel * oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 37, backImageView.frame.size.width, 20)];
            oneLabel.textAlignment = NSTextAlignmentCenter;
            oneLabel.font = [UIFont systemFontOfSize:13];
            oneLabel.textColor = [UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1];
            oneLabel.backgroundColor = [UIColor clearColor];
            oneLabel.text = @"您当前选的比赛需要串关,至少选择2场!";
            [backImageView addSubview:oneLabel];
            [oneLabel release];
            
            UILabel * twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 100, 140, 20)];
            twoLabel.textAlignment = NSTextAlignmentCenter;
            twoLabel.font = [UIFont systemFontOfSize:13];
            twoLabel.textColor = [UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1];
            twoLabel.backgroundColor = [UIColor clearColor];
            twoLabel.text = @"有此标志的可以选单场";
            [backImageView addSubview:twoLabel];
            [twoLabel release];
            
            UIImageView * hintimage = [[UIImageView alloc] initWithFrame:CGRectMake(172, 72, 90, 80)];
            hintimage.backgroundColor = [UIColor clearColor];
            hintimage.image = UIImageGetImageFromName(@"hintimage.png");
            [backImageView addSubview:hintimage];
            [hintimage release];
        }else if (type == oneShowType){
        
        
           
            
            UILabel * twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 100 - 25, 140, 20)];
            twoLabel.textAlignment = NSTextAlignmentCenter;
            twoLabel.font = [UIFont systemFontOfSize:13];
            twoLabel.textColor = [UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1];
            twoLabel.backgroundColor = [UIColor clearColor];
            twoLabel.text = @"有此标志的可以选单场";
            [backImageView addSubview:twoLabel];
            [twoLabel release];
            
            UIImageView * hintimage = [[UIImageView alloc] initWithFrame:CGRectMake(172, 72 - 35, 90, 80)];
            hintimage.backgroundColor = [UIColor clearColor];
            hintimage.image = UIImageGetImageFromName(@"hintimage.png");
            [backImageView addSubview:hintimage];
            [hintimage release];
        }else if (type == danShowType){
        
            UILabel * oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 47, backImageView.frame.size.width-40, 70)];
//            oneLabel.textAlignment = NSTextAlignmentCenter;
            oneLabel.font = [UIFont systemFontOfSize:13];
            oneLabel.textColor = [UIColor colorWithRed:63/255.0 green:63/255.0 blue:63/255.0 alpha:1];
            oneLabel.backgroundColor = [UIColor clearColor];
            oneLabel.lineBreakMode = NSLineBreakByWordWrapping;
            oneLabel.numberOfLines = 0;
            oneLabel.text = @"选择你确定的赛果设胆，设胆的赛果与其他赛果进行组合投注，其他赛果之间不进行组合，降低投资金额。";
            [backImageView addSubview:oneLabel];
            [oneLabel release];
        
        }
        
       
        
        
        UIButton * zdlButton = [UIButton buttonWithType:UIButtonTypeCustom];
        zdlButton.backgroundColor = [UIColor clearColor];
        zdlButton.frame = CGRectMake(0, 208 - 42, 293, 42);
        [zdlButton addTarget:self action:@selector(presszdlButton:) forControlEvents:UIControlEventTouchUpInside];
        [backImageView addSubview:zdlButton];
        
        
        UILabel * zdlLabel = [[UILabel alloc] initWithFrame:zdlButton.bounds];
        zdlLabel.textAlignment = NSTextAlignmentCenter;
        zdlLabel.font = [UIFont systemFontOfSize:18];
        zdlLabel.textColor = [UIColor colorWithRed:24/255.0 green:143/255.0 blue:254/255.0 alpha:1];
        zdlLabel.backgroundColor = [UIColor clearColor];
        zdlLabel.text = @"知道了";
        [zdlButton addSubview:zdlLabel];
        [zdlLabel release];

        
        
    }
    return self;
    

}
- (void)show{

    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    [app.window addSubview:self];
    
}

- (void)presszdlButton:(UIButton *)sender{

    [self removeFromSuperview];
    
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    