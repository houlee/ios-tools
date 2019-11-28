//
//  StartYindaoView.m
//  caibo
//
//  Created by cp365dev6 on 15/1/5.
//
//

#import "StartYindaoView.h"

@implementation StartYindaoView
@synthesize delegate;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        isUp = YES;
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"startAnimated"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startAnimated) name:@"startAnimated" object:nil];
        
        
        myScrollView = [[UIScrollView alloc]initWithFrame:frame];
        myScrollView.backgroundColor=[UIColor clearColor];
        myScrollView.pagingEnabled=YES;
        myScrollView.delegate =self;
        myScrollView.showsHorizontalScrollIndicator = NO;
        myScrollView.showsVerticalScrollIndicator = NO;
        myScrollView.contentSize = CGSizeMake(frame.size.width, frame.size.height * 3);
        myScrollView.bounces = NO;
        [self addSubview:myScrollView];
        [myScrollView release];
                
        baImaView1 = [[UIImageView alloc]init];
        baImaView1.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        baImaView1.image = [[UIImage imageNamed:@"yindaobeijing1.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        baImaView1.backgroundColor = [UIColor clearColor];
        [myScrollView addSubview:baImaView1];
        [baImaView1 release];
        UIImageView *imaView1 = [[UIImageView alloc]init];
        imaView1.frame = CGRectMake((baImaView1.frame.size.width - 280)/2, 30 + (IS_IPHONE_5 ? 20 : 0), 280, 280);
        imaView1.backgroundColor = [UIColor clearColor];
        imaView1.image = [UIImage imageNamed:@"yindao1.png"];
        [baImaView1 addSubview:imaView1];
        [imaView1 release];
        
        baImaView2 = [[UIImageView alloc]init];
        baImaView2.frame = CGRectMake(0, frame.size.height, frame.size.width, frame.size.height);
        baImaView2.image = [[UIImage imageNamed:@"yindaobeijing2.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        baImaView2.backgroundColor = [UIColor clearColor];
        [myScrollView addSubview:baImaView2];
        [baImaView2 release];
        UIImageView *imaView2 = [[UIImageView alloc]init];
        imaView2.frame = CGRectMake((baImaView2.frame.size.width - 280)/2, 30 + (IS_IPHONE_5 ? 20 : 0), 280, 280);
        imaView2.backgroundColor = [UIColor clearColor];
        imaView2.image = [UIImage imageNamed:@"yindao2.png"];
        [baImaView2 addSubview:imaView2];
        [imaView2 release];
        
        baImaView3 = [[UIImageView alloc]init];
        baImaView3.frame = CGRectMake(0, frame.size.height * 2, frame.size.width, frame.size.height);
        baImaView3.image = [[UIImage imageNamed:@"yindaobeijing3.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
        baImaView3.backgroundColor = [UIColor clearColor];
        baImaView3.userInteractionEnabled = YES;
        [myScrollView addSubview:baImaView3];
        [baImaView3 release];
        UIImageView *imaView3 = [[UIImageView alloc]init];
        imaView3.frame = CGRectMake((baImaView3.frame.size.width - 280)/2, 30 + (IS_IPHONE_5 ? 20 : 0), 280, 280);
        imaView3.backgroundColor = [UIColor clearColor];
        imaView3.image = [UIImage imageNamed:@"yindao3.png"];
        [baImaView3 addSubview:imaView3];
        [imaView3 release];
        
        NSArray *imaArray = [[NSArray alloc]initWithObjects:@"yindaowenzi1_1.png",@"yindaowenzi1_2.png",@"yindaowenzi1_3.png",@"yindaowenzi2_1.png",@"yindaowenzi2_2.png",@"yindaowenzi2_3.png",@"yindaowenzi3_1.png",@"yindaowenzi3_2.png",@"yindaowenzi3_3.png",@"yindaowenzi3_4.png", nil];
        
        firstIma1 = [[UIImageView alloc]init];
        firstIma1.frame = CGRectMake(40, baImaView1.frame.size.height - (IS_IPHONE_5 ? 213 : 180) + YiDongJuLi, 74, 23);
        firstIma1.backgroundColor=[UIColor clearColor];
        firstIma1.image = [UIImage imageNamed:[imaArray objectAtIndex:0]];
        firstIma1.alpha = 0;
        [baImaView1 addSubview:firstIma1];
        [firstIma1 release];
        firstIma2 = [[UIImageView alloc]init];
        firstIma2.frame = CGRectMake(40, firstIma1.frame.origin.y + firstIma1.frame.size.height + 13, 163, 15.5);
        firstIma2.backgroundColor = [UIColor clearColor];
        firstIma2.image = [UIImage imageNamed:[imaArray objectAtIndex:1]];
        firstIma2.alpha = 0;
        [baImaView1 addSubview:firstIma2];
        [firstIma2 release];
        firstIma3 = [[UIImageView alloc]init];
        firstIma3.frame = CGRectMake(40, firstIma2.frame.origin.y + firstIma2.frame.size.height + 13, 81, 15.5);
        firstIma3.backgroundColor = [UIColor clearColor];
        firstIma3.image = [UIImage imageNamed:[imaArray objectAtIndex:2]];
        firstIma3.alpha = 0;
        [baImaView1 addSubview:firstIma3];
        [firstIma3 release];
        
        secondIma1 = [[UIImageView alloc]init];
        secondIma1.frame = CGRectMake(40, baImaView2.frame.size.height - (IS_IPHONE_5 ? 213 : 180) + YiDongJuLi, 32, 15.5);
        secondIma1.backgroundColor=[UIColor clearColor];
        secondIma1.image = [UIImage imageNamed:[imaArray objectAtIndex:3]];
        secondIma1.alpha = 0;
        [baImaView2 addSubview:secondIma1];
        [secondIma1 release];
        secondIma2 = [[UIImageView alloc]init];
        secondIma2.frame = CGRectMake(40, secondIma1.frame.origin.y + secondIma1.frame.size.height + 13, 83, 15.5);
        secondIma2.backgroundColor = [UIColor clearColor];
        secondIma2.image = [UIImage imageNamed:[imaArray objectAtIndex:4]];
        secondIma2.alpha = 0;
        [baImaView2 addSubview:secondIma2];
        [secondIma2 release];
        secondIma3 = [[UIImageView alloc]init];
        secondIma3.frame = CGRectMake(40, secondIma2.frame.origin.y + secondIma2.frame.size.height + 13, 130, 23);
        secondIma3.backgroundColor = [UIColor clearColor];
        secondIma3.image = [UIImage imageNamed:[imaArray objectAtIndex:5]];
        secondIma3.alpha = 0;
        [baImaView2 addSubview:secondIma3];
        [secondIma3 release];
        
        thirdIma1 = [[UIImageView alloc]init];
        thirdIma1.frame = CGRectMake(40, baImaView3.frame.size.height - (IS_IPHONE_5 ? 212.5 : 180) + YiDongJuLi, 65, 15.5);
        thirdIma1.backgroundColor=[UIColor clearColor];
        thirdIma1.image = [UIImage imageNamed:[imaArray objectAtIndex:6]];
        thirdIma1.alpha = 0;
        [baImaView3 addSubview:thirdIma1];
        [thirdIma1 release];
        thirdIma2 = [[UIImageView alloc]init];
        thirdIma2.frame = CGRectMake(40, thirdIma1.frame.origin.y + thirdIma1.frame.size.height + 13, 131, 15.5);
        thirdIma2.backgroundColor = [UIColor clearColor];
        thirdIma2.image = [UIImage imageNamed:[imaArray objectAtIndex:7]];
        thirdIma2.alpha = 0;
        [baImaView3 addSubview:thirdIma2];
        [thirdIma2 release];
        thirdIma3 = [[UIImageView alloc]init];
        thirdIma3.frame = CGRectMake(40, thirdIma2.frame.origin.y + thirdIma2.frame.size.height + 13, 62, 15.5);
        thirdIma3.backgroundColor = [UIColor clearColor];
        thirdIma3.image = [UIImage imageNamed:[imaArray objectAtIndex:8]];
        thirdIma3.alpha = 0;
        [baImaView3 addSubview:thirdIma3];
        [thirdIma3 release];
        thirdIma4 = [[UIImageView alloc]init];
        thirdIma4.frame = CGRectMake(40, thirdIma3.frame.origin.y + thirdIma3.frame.size.height + 13, 137.5, 15.5);
        thirdIma4.backgroundColor = [UIColor clearColor];
        thirdIma4.image = [UIImage imageNamed:[imaArray objectAtIndex:9]];
        thirdIma4.alpha = 0;
        [baImaView3 addSubview:thirdIma4];
        [thirdIma4 release];
        
        jiantouIma1 = [[UIImageView alloc]init];
        jiantouIma1.backgroundColor=[UIColor clearColor];
        jiantouIma1.frame = CGRectMake((baImaView1.frame.size.width - 22)/2, baImaView1.frame.size.height - 13.5 - 15, 22, 13.5);
        jiantouIma1.image = [UIImage imageNamed:@"yindaosanjiao_2.png"];
        [baImaView1 addSubview:jiantouIma1];
        [jiantouIma1 release];
        jiantouIma2 = [[UIImageView alloc]init];
        jiantouIma2.backgroundColor=[UIColor clearColor];
        jiantouIma2.frame = CGRectMake((baImaView2.frame.size.width - 22)/2, baImaView2.frame.size.height - 13.5 - 15, 22, 13.5);
        jiantouIma2.image = [UIImage imageNamed:@"yindaosanjiao_2.png"];
        [baImaView2 addSubview:jiantouIma2];
        [jiantouIma2 release];
        jiantouIma3 = [[UIImageView alloc]init];
        jiantouIma3.backgroundColor=[UIColor clearColor];
        jiantouIma3.frame = CGRectMake((baImaView3.frame.size.width - 22)/2, 5 + TiaoYueDa + (I6 ? 20 : 0), 22, 13.5);
        jiantouIma3.image = [UIImage imageNamed:@"yindaosanjiao_1.png"];
        [baImaView3 addSubview:jiantouIma3];
        [jiantouIma3 release];
        
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        startBtn.frame = CGRectMake((baImaView3.frame.size.width - 88)/2, baImaView3.frame.size.height - (IS_IPHONE_5 ? 40 : 20) - 31.5, 88, 31.5);
        startBtn.backgroundColor = [UIColor clearColor];
        startBtn.tag = 555;
        [startBtn addTarget:self action:@selector(pressStart:) forControlEvents:UIControlEventTouchUpInside];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"yindaostart.png"] forState:UIControlStateNormal];
        [startBtn setTitle:@"即刻启程" forState:UIControlStateNormal];
        [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        startBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        startBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [baImaView3 addSubview:startBtn];
        
        
        myTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeatAnimated) userInfo:nil repeats:YES];
        
    }
    
    
    return self;
}
-(void)startAnimated
{
    [self donghuaXiaoguo:1];
}
-(void)repeatAnimated
{
    [UIView animateWithDuration:0.1 animations:^{
        jiantouIma1.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15 - TiaoYueDa , 22, 13.5);
        jiantouIma2.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15 - TiaoYueDa, 22, 13.5);
        jiantouIma3.frame = CGRectMake((baImaView3.frame.size.width - 22)/2, 5 + (I6 ? 20 : 0), 22, 13.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            jiantouIma1.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15, 22, 13.5);
            jiantouIma2.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15, 22, 13.5);
            jiantouIma3.frame = CGRectMake((baImaView3.frame.size.width - 22)/2, 5 + TiaoYueDa + (I6 ? 20 : 0), 22, 13.5);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                jiantouIma1.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15 - TiaoYueXiao, 22, 13.5);
                jiantouIma2.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15 - TiaoYueXiao, 22, 13.5);
                jiantouIma3.frame = CGRectMake((baImaView3.frame.size.width - 22)/2, 5 + TiaoYueDa - TiaoYueXiao + (I6 ? 20 : 0), 22, 13.5);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    jiantouIma1.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15, 22, 13.5);
                    jiantouIma2.frame = CGRectMake((self.frame.size.width - 22)/2, self.frame.size.height - 13.5 - 15, 22, 13.5);
                    jiantouIma3.frame = CGRectMake((baImaView3.frame.size.width - 22)/2, 5 + TiaoYueDa + (I6 ? 20 : 0), 22, 13.5);
                }];
            }];
        }];
    }];
}
-(void)firstAnimated
{
    [UIView animateWithDuration:1 animations:^{
        firstIma2.alpha = 1;
        firstIma2.frame = CGRectMake(40, firstIma1.frame.origin.y + firstIma1.frame.size.height + 13, 163, 15.5);
    }];
}
-(void)firstAnimated2
{
    [UIView animateWithDuration:1 animations:^{
        firstIma3.alpha = 1;
        firstIma3.frame = CGRectMake(40, firstIma2.frame.origin.y + firstIma2.frame.size.height + 13, 81, 15.5);
    }];
}
-(void)secondAnimated
{
    [UIView animateWithDuration:1 animations:^{
        secondIma2.alpha = 1;
        secondIma2.frame = CGRectMake(40, secondIma1.frame.origin.y + secondIma1.frame.size.height + 13, 83, 15.5);
    }];
}
-(void)secondAnimated2
{
    [UIView animateWithDuration:1 animations:^{
        secondIma3.alpha = 1;
        secondIma3.frame = CGRectMake(40, secondIma2.frame.origin.y + secondIma2.frame.size.height + 13, 130, 23);
    }];
}
-(void)thirdAnimated1
{
    [UIView animateWithDuration:1 animations:^{
        thirdIma2.alpha = 1;
        thirdIma2.frame = CGRectMake(40, thirdIma1.frame.origin.y + thirdIma1.frame.size.height + 13, 131, 15.5);
    }];
}
-(void)thirdAnimated2
{
    [UIView animateWithDuration:1 animations:^{
        thirdIma3.alpha = 1;
        thirdIma3.frame = CGRectMake(40, thirdIma2.frame.origin.y + thirdIma2.frame.size.height + 13, 62, 15.5);
    }];
}
-(void)thirdAnimated3
{
    [UIView animateWithDuration:1 animations:^{
        thirdIma4.alpha = 1;
        thirdIma4.frame = CGRectMake(40, thirdIma3.frame.origin.y + thirdIma3.frame.size.height + 13, 137.5, 15.5);
    }];
}
-(void)donghuaXiaoguo:(NSInteger)indexPath
{
//    [[self class] cancelPreviousPerformRequestsWithTarget:self];
//    if(indexPath == 1)
//    {
//        firstIma1.alpha = 0;
//        firstIma2.alpha = 0;
//        firstIma3.alpha = 0;
//        firstIma1.frame = CGRectMake(40, baImaView1.frame.size.height - 212.5 + YiDongJuLi, 72, 22.5);
//        firstIma2.frame = CGRectMake(40, firstIma1.frame.origin.y + firstIma1.frame.size.height + 13, 162.5, 15.5);
//        firstIma3.frame = CGRectMake(40, firstIma2.frame.origin.y + firstIma2.frame.size.height + 13, 80, 15.5);
////        [[self class] cancelPreviousPerformRequestsWithTarget:self];
//        
//        [UIView animateWithDuration:1 animations:^{
//            firstIma1.alpha = 1;
//            firstIma1.frame = CGRectMake(40, baImaView1.frame.size.height - 212.5, 72, 22.5);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:1 animations:^{
//                firstIma3.alpha = 1;
//                firstIma3.frame = CGRectMake(40, firstIma2.frame.origin.y + firstIma2.frame.size.height + 13, 80, 15.5);
//            }];
////            [UIView animateWithDuration:1 animations:^{
////                firstIma3.alpha = 1;
////                firstIma3.frame = CGRectMake(40, firstIma2.frame.origin.y + firstIma2.frame.size.height + 13, 80, 15.5);
////            } completion:^(BOOL finished) {
////                openAnimated = NO;
////            }];
//        }];
//        [self performSelector:@selector(firstAnimated) withObject:nil afterDelay:0.5];
//    }
//    if(indexPath == 2)
//    {
//        secondIma1.alpha = 0;
//        secondIma2.alpha = 0;
//        secondIma3.alpha = 0;
//        secondIma1.frame = CGRectMake(40, baImaView2.frame.size.height - 212.5 + YiDongJuLi, 31, 15.5);
//        secondIma2.frame = CGRectMake(40, secondIma1.frame.origin.y + secondIma1.frame.size.height + 13, 83, 15.5);
//        secondIma3.frame = CGRectMake(40, secondIma2.frame.origin.y + secondIma2.frame.size.height + 13, 130, 22.5);
////        [[self class] cancelPreviousPerformRequestsWithTarget:self];
//        [UIView animateWithDuration:1 animations:^{
//            secondIma1.alpha = 1;
//            secondIma1.frame = CGRectMake(40, baImaView2.frame.size.height - 212.5, 31, 15.5);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:1 animations:^{
//                secondIma3.alpha = 1;
//                secondIma3.frame = CGRectMake(40, secondIma2.frame.origin.y + secondIma2.frame.size.height + 13, 130, 22.5);
//            }];
////            [UIView animateWithDuration:1 animations:^{
////                secondIma3.alpha = 1;
////                secondIma3.frame = CGRectMake(40, secondIma2.frame.origin.y + secondIma2.frame.size.height + 13, 130, 22.5);
////            } completion:^(BOOL finished) {
////                openAnimated = NO;
////            }];
//        }];
//        [self performSelector:@selector(secondAnimated) withObject:nil afterDelay:0.5];
//    }
//    if(indexPath == 3)
//    {
//        thirdIma1.alpha = 0;
//        thirdIma2.alpha = 0;
//        thirdIma3.alpha = 0;
//        thirdIma4.alpha = 0;
//        thirdIma1.frame = CGRectMake(40, baImaView3.frame.size.height - 212.5 + YiDongJuLi, 64, 15.5);
//        thirdIma2.frame = CGRectMake(40, thirdIma1.frame.origin.y + thirdIma1.frame.size.height + 13, 130, 15.5);
//        thirdIma3.frame = CGRectMake(40, thirdIma2.frame.origin.y + thirdIma2.frame.size.height + 13, 61, 15.5);
//        thirdIma4.frame = CGRectMake(40, thirdIma3.frame.origin.y + thirdIma3.frame.size.height + 13, 136.5, 15.5);
////        [[self class] cancelPreviousPerformRequestsWithTarget:self];
//        [UIView animateWithDuration:1 animations:^{
//            thirdIma1.alpha = 1;
//            thirdIma1.frame = CGRectMake(40, baImaView3.frame.size.height - 212.5, 64, 15.5);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:1 animations:^{
//                thirdIma3.alpha = 1;
//                thirdIma3.frame = CGRectMake(40, thirdIma2.frame.origin.y + thirdIma2.frame.size.height + 13, 61, 15.5);
//            }];
//        }];
//        [self performSelector:@selector(thirdAnimated) withObject:nil afterDelay:0.5];
//    }
    [[self class] cancelPreviousPerformRequestsWithTarget:self];
    if(indexPath == 1)
    {
        firstIma1.alpha = 0;
        firstIma2.alpha = 0;
        firstIma3.alpha = 0;
        firstIma1.frame = CGRectMake(40, baImaView1.frame.size.height - (IS_IPHONE_5 ? 213 : 180) + YiDongJuLi, 74, 23);
        firstIma2.frame = CGRectMake(40, firstIma1.frame.origin.y + firstIma1.frame.size.height + 13, 163, 15.5);
        firstIma3.frame = CGRectMake(40, firstIma2.frame.origin.y + firstIma2.frame.size.height + 13, 81, 15.5);
        [UIView animateWithDuration:1 animations:^{
            firstIma1.alpha = 1;
            firstIma1.frame = CGRectMake(40, baImaView1.frame.size.height - (IS_IPHONE_5 ? 213 : 180), 74, 23);
        }];
        [self performSelector:@selector(firstAnimated) withObject:self afterDelay:YanChiTime];
        [self performSelector:@selector(firstAnimated2) withObject:self afterDelay:YanChiTime * 2];
    }
    if(indexPath == 2)
    {
        secondIma1.alpha = 0;
        secondIma2.alpha = 0;
        secondIma3.alpha = 0;
        secondIma1.frame = CGRectMake(40, baImaView2.frame.size.height - (IS_IPHONE_5 ? 213 : 180) + YiDongJuLi, 32, 15.5);
        secondIma2.frame = CGRectMake(40, secondIma1.frame.origin.y + secondIma1.frame.size.height + 13, 83, 15.5);
        secondIma3.frame = CGRectMake(40, secondIma2.frame.origin.y + secondIma2.frame.size.height + 13, 130, 23);
        [UIView animateWithDuration:1 animations:^{
            secondIma1.alpha = 1;
            secondIma1.frame = CGRectMake(40, baImaView2.frame.size.height - (IS_IPHONE_5 ? 213 : 180), 32, 15.5);
        }];
        [self performSelector:@selector(secondAnimated) withObject:self afterDelay:YanChiTime];
        [self performSelector:@selector(secondAnimated2) withObject:self afterDelay:YanChiTime * 2];
    }
    if(indexPath == 3)
    {
        thirdIma1.alpha = 0;
        thirdIma2.alpha = 0;
        thirdIma3.alpha = 0;
        thirdIma4.alpha = 0;
        thirdIma1.frame = CGRectMake(40, baImaView3.frame.size.height - (IS_IPHONE_5 ? 212.5 : 180) + YiDongJuLi, 65, 15.5);
        thirdIma2.frame = CGRectMake(40, thirdIma1.frame.origin.y + thirdIma1.frame.size.height + 13, 131, 15.5);
        thirdIma3.frame = CGRectMake(40, thirdIma2.frame.origin.y + thirdIma2.frame.size.height + 13, 61, 15.5);
        thirdIma4.frame = CGRectMake(40, thirdIma3.frame.origin.y + thirdIma3.frame.size.height + 13, 137.5, 15.5);
        [UIView animateWithDuration:1 animations:^{
            thirdIma1.alpha = 1;
            thirdIma1.frame = CGRectMake(40, baImaView3.frame.size.height - (IS_IPHONE_5 ? 212.5 : 180), 65, 15.5);
        }];
        [self performSelector:@selector(thirdAnimated1) withObject:self afterDelay:YanChiTime];
        [self performSelector:@selector(thirdAnimated2) withObject:self afterDelay:YanChiTime * 2];
        [self performSelector:@selector(thirdAnimated3) withObject:self afterDelay:YanChiTime * 3];
        
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    NSLog(@"%f",scrollView.contentOffset.y);
    CGFloat currentSize = scrollView.contentOffset.y;
    
    if(currentSize >= 0)
    {
        CGFloat fangxiang;
        fangxiang = currentSize - jiluSize;
        BOOL up;
        if(fangxiang > 0)//向shang滑
        {
            up = YES;
            if((currentSize > 150.0 && currentSize <= self.frame.size.height) || isUp != up)
            {
                if(!openAnimated)
                {
                    openAnimated = YES;
                    [self donghuaXiaoguo:2];
                }
            }
            if((currentSize > 150.0 + self.frame.size.height && currentSize <= self.frame.size.height * 2) || isUp != up)
            {
                if(!openAnimated)
                {
                    openAnimated = YES;
                    [self donghuaXiaoguo:3];
                }
            }
        }
        else if(fangxiang < 0)//向xia滑
        {
            up = NO;
            if((currentSize >= self.frame.size.height && currentSize <= self.frame.size.height * 2 - 150) || isUp != up)
            {
                if(!openAnimated)
                {
                    openAnimated = YES;
                    [self donghuaXiaoguo:2];
                }
            }
            if((currentSize >= 0.0 && currentSize < self.frame.size.height-150) || isUp != up)
            {
                if(!openAnimated)
                {
                    openAnimated = YES;
                    [self donghuaXiaoguo:1];
                }
            }
            
        }
        isUp = up;
        jiluSize = currentSize;
    }
    else
    {
        
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    openAnimated = NO;
    NSLog(@"scrollViewDidEndDragging");
}
-(void)pressStart:(UIButton *)sender
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
////    [UIView setAnimationDidStopSelector:@selector(yindaoHidden)];
//    self.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
//    [UIView commitAnimations];
//    [self yindaoHidden];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, -self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self yindaoHidden];
    }];
    
    
    if(delegate && [delegate respondsToSelector:@selector(disMissFromSuperView:withBtnIndex:)]){
    
        [delegate disMissFromSuperView:self withBtnIndex:sender.tag];
    }
}
-(void)yindaoHidden
{
    if(self.superview != nil)
    {
        [myTimer invalidate];
        myTimer = nil;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"startAnimated"];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"startAnimated" object:nil];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    