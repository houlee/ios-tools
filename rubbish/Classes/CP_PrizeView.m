//
//  CP_PrizeView.m
//  caibo
//
//  Created by cp365dev on 15/1/24.
//
//

#import "CP_PrizeView.h"
#import "SharedMethod.h"
@implementation CP_PrizeView
@synthesize title;
@synthesize prizeType;
@synthesize delegate;
@synthesize btnName;
@synthesize returnType;
@synthesize topicID;
@synthesize lotteryID;
-(void)dealloc{

    self.returnType = nil;
    self.lotteryID = nil;
    self.topicID = nil;
    self.btnName = nil;
    self.title = nil;
    [super dealloc];
}
-(id)initWithtitle:(NSString *)_title andBtnName:(NSString *)_btnName returnType:(NSString *)_returntype topPicID:(NSString *)_topicid lotteryID:(NSString *)_lotteryid{

    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if(self){
    
        self.title = [_title copy];
        
        self.btnName = [_btnName copy];
        
        self.returnType = [_returntype copy];
        
        self.topicID = [_topicid copy];
        
        self.lotteryID = [_lotteryid copy];
    }
    return self;
}
-(void)show{
    
    self.backgroundColor = [UIColor clearColor];
    
    backgroundView = [[UIView alloc] initWithFrame:self.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [self addSubview:backgroundView];
    [backgroundView release];
    
    
    
    bgImg = [[UIImageView alloc] initWithFrame:CGRectMake(39, 150, 242, 204)];
    bgImg.backgroundColor = [UIColor  clearColor];
    bgImg.userInteractionEnabled = YES;
    
    if(self.prizeType == CP_PrizeViewTextType){
    
        bgImg.image = [UIImageGetImageFromName(@"prize_unBtn_bg.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [backgroundView addSubview:bgImg];
        [bgImg release];

        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        [close setFrame:CGRectMake(200, 0, 40, 40)];
        close.backgroundColor = [UIColor clearColor];
        [close addTarget:self action:@selector(closePrizeView:) forControlEvents:UIControlEventTouchUpInside];
        [bgImg addSubview:close];
        
        
        UIImageView *closeImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 10, 10)];
        closeImg1.backgroundColor = [UIColor clearColor];
        closeImg1.image = UIImageGetImageFromName(@"prize_close.png");
        [close addSubview:closeImg1];
        [closeImg1 release];
        
        
        UIImageView *hongbaoImg = [[UIImageView alloc] initWithFrame:CGRectMake(87, 20, 68, 49)];
        hongbaoImg.image = UIImageGetImageFromName(@"prize_unBtn_hongbao.png");
        [bgImg addSubview:hongbaoImg];
        [hongbaoImg release];
        
        
        CGSize size = CGSizeMake(202, 100);
        CGSize size1 = [self.title sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, hongbaoImg.frame.origin.y+hongbaoImg.frame.size.height+17, 202, size1.height)];
        textLabel.text = self.title;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:17];
        textLabel.textColor = [SharedMethod getColorByHexString:@"454545"];
        [bgImg addSubview:textLabel];
        [textLabel release];
        
        
        if(self.btnName && self.btnName.length){
            
            UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [getBtn setFrame:CGRectMake(58.5, 154, 125, 36)];
            [getBtn setBackgroundImage:UIImageGetImageFromName(@"prize_btn.png") forState:UIControlStateNormal];
            [getBtn setTitle:self.btnName forState:UIControlStateNormal];
            [getBtn addTarget:self action:@selector(getPress) forControlEvents:UIControlEventTouchUpInside];
            [getBtn setTitleColor:[SharedMethod getColorByHexString:@"ffe9d4"] forState:UIControlStateNormal];
            [bgImg addSubview:getBtn];
            
        }
        
        
        [self addSelf];
        
    }
    

    if(self.prizeType == CP_PrizeViewHongBaoType){
    
        closeImg = [[UIImageView alloc] initWithFrame:CGRectMake(107, 200, 106, 71)];;
        closeImg.image = UIImageGetImageFromName(@"prize_btn_close.png");
        closeImg.backgroundColor = [UIColor clearColor];
        [backgroundView addSubview:closeImg];
        [closeImg release];
        
        [UIView animateWithDuration:0.1 animations:^{
        
            closeImg.frame = CGRectMake(107+3, 200, 106, 71);
            
        } completion:^(BOOL finish){
        
            closeImg.frame = CGRectMake(107, 200, 106, 71);
            

            [UIView animateWithDuration:0.1 animations:^{
                
                closeImg.frame = CGRectMake(107+3, 200, 106, 71);
                
            } completion:^(BOOL finish){
                
                closeImg.frame = CGRectMake(107, 200, 106, 71);
                
                [UIView animateWithDuration:0.1 animations:^{
                    
                    closeImg.frame = CGRectMake(107+3, 200, 106, 71);
                    
                } completion:^(BOOL finish){
                    
                    closeImg.frame = CGRectMake(107, 200, 106, 71);
                    
                    [UIView animateWithDuration:0.1 animations:^{
                        
                        closeImg.frame = CGRectMake(107+3, 200, 106, 71);
                        
                    } completion:^(BOOL finish){
                        
                        [self performSelector:@selector(changeImage) withObject:nil afterDelay:0.2];
                        
                        
                    }];
                    
                }];
                
            }];

        }];
        
        
        
        [self addSelf];
    }
}

-(void)changeImage{

    closeImg.frame = CGRectMake(107, 200, 106, 99);

    closeImg.image = UIImageGetImageFromName(@"prize_btn_open.png");

    [self performSelector:@selector(changeAnotherImage) withObject:nil afterDelay:0.4];
    

}
-(void)changeAnotherImage{

    [UIView animateWithDuration:0.1 animations:^{
    
    } completion:^(BOOL finish){
    
        
        UIImageView *lightImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 260)];
        lightImg.backgroundColor = [UIColor clearColor];
        lightImg.image = UIImageGetImageFromName(@"prize_light.png");
        [backgroundView addSubview:lightImg];
        [lightImg release];
        
        
        bgImg.image = UIImageGetImageFromName(@"prize_bg.png");
        bgImg.frame = CGRectMake(37, 140, 245.5, 226.5);
        [backgroundView addSubview:bgImg];
        [bgImg release];
        
        
        UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
        [close setFrame:CGRectMake(190, 80, 40, 40)];
        close.backgroundColor = [UIColor clearColor];
        [close addTarget:self action:@selector(closePrizeView:) forControlEvents:UIControlEventTouchUpInside];
        [bgImg addSubview:close];
        
        
        UIImageView *closeBtnImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 10, 10)];
        closeBtnImg.backgroundColor = [UIColor clearColor];
        closeBtnImg.image = UIImageGetImageFromName(@"prize_close.png");
        [close addSubview:closeBtnImg];
        [closeBtnImg release];
        
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 108, 245.5, 34)];
        textLabel.text = self.title;
        textLabel.backgroundColor = [UIColor clearColor];
        textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        textLabel.numberOfLines = 0;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = [UIFont systemFontOfSize:17];
        textLabel.textColor = [SharedMethod getColorByHexString:@"ffffff"];
        [bgImg addSubview:textLabel];
        [textLabel release];
        
        if(self.btnName && self.btnName.length){
            
            UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [getBtn setFrame:CGRectMake(60, textLabel.frame.origin.y+textLabel.frame.size.height+30, 125, 36)];
            [getBtn setBackgroundImage:UIImageGetImageFromName(@"prize_btn.png") forState:UIControlStateNormal];
            [getBtn setTitle:self.btnName forState:UIControlStateNormal];
            [getBtn setTitleColor:[SharedMethod getColorByHexString:@"461502"] forState:UIControlStateNormal];
            [getBtn addTarget:self action:@selector(getPress) forControlEvents:UIControlEventTouchUpInside];
            [bgImg addSubview:getBtn];
            
        }
        
        [backgroundView bringSubviewToFront:lightImg];
        [backgroundView bringSubviewToFront:bgImg];
        
    }];

}
-(void)getPress{


    if(delegate && [delegate respondsToSelector:@selector(CP_PrizeViewGetPressDelegate:returnType:topPicID:lotteryID:)]){
    
        [delegate CP_PrizeViewGetPressDelegate:self returnType:self.returnType topPicID:self.topicID lotteryID:self.lotteryID];
    }
    [self disMissFromSuperView];

}

- (void)disMissFromSuperView{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0;
        
    } completion:^(BOOL finish){
        
        
        if(self.superview){
            
            [self removeFromSuperview];
            
            if(delegate && [delegate respondsToSelector:@selector(disMissFromSuperView:)])
            {
                [delegate disMissFromSuperView:self];
                
            }
            
        }
        
        
    }];
}

-(void)addSelf{

    [[[UIApplication sharedApplication].windows objectAtIndex:0] addSubview:self];

}
-(void)closePrizeView:(UIButton *)sender{

    [self removeFromSuperview];
}
@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    