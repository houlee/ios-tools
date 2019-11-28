//
//  StartGuideView.m
//  caibo
//
//  Created by cp365dev on 14-6-5.
//
//

#import "StartGuideView.h"
#import "New_PageControl.h"
@implementation StartGuideView
@synthesize delegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        myScrollView = [[UIScrollView alloc] initWithFrame:frame];
        myScrollView.delegate = self;
        myScrollView.pagingEnabled = YES;
        myScrollView.backgroundColor =[UIColor clearColor];
        [myScrollView setShowsVerticalScrollIndicator:NO];
        [myScrollView setShowsHorizontalScrollIndicator:NO];
        [myScrollView setContentSize:CGSizeMake(frame.size.width*4, frame.size.height)];
        [self addSubview:myScrollView];
        [myScrollView release];
        
        isArePerform = NO;
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [myScrollView addSubview:image1];
        [image1 release];
        
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, frame.size.width, frame.size.height)];
        [myScrollView addSubview:image2];
        [image2 release];
        
        UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, frame.size.width, frame.size.height)];
        [myScrollView addSubview:image3];
        image3.userInteractionEnabled = YES;
        [image3 release];
        
        UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(960, 0, frame.size.width, frame.size.height)];
        [myScrollView addSubview:image4];
        [image4 release];
        

        
        
//        myPageControl = [[New_PageControl alloc] initWithFrame:CGRectMake((320 - (25*3))/2+10, myScrollView.frame.origin.y+myScrollView.frame.size.height - 36, 25*3, 12)];
//        myPageControl.guideBool = YES;
//        myPageControl.tag = 30 ;
//        myPageControl.currentPage = 0;
//        myPageControl.numberOfPages = 3;
//        [self addSubview:myPageControl];
//        [myPageControl release];
        
//        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [startBtn setImage:UIImageGetImageFromName(@"guidePage_btn_normal.png") forState:UIControlStateNormal];
//        [startBtn setImage:UIImageGetImageFromName(@"guidePage_btn_selected.png") forState:UIControlStateHighlighted];
//        startBtn.backgroundColor = [UIColor clearColor];
//        [startBtn addTarget:self action:@selector(pressStart:) forControlEvents:UIControlEventTouchUpInside];
//        [image3 addSubview:startBtn];


        if(IS_IPHONE_5){
//            [startBtn setFrame:CGRectMake(92, frame.size.height-84, 136, 29)];

            [image1 setImage:UIImageGetImageFromName(@"guidePage_ip5_01.png")];
            
            [image2 setImage:UIImageGetImageFromName(@"guidePage_ip5_02.png")];
            
            [image3 setImage:UIImageGetImageFromName(@"guidePage_ip5_03.png")];
            
            [image4 setImage:UIImageGetImageFromName(@"guidePage_ip5_04.png")];

        }
        else{
//            [startBtn setFrame:CGRectMake(92, frame.size.height-74, 136, 29)];

            [image1 setImage:UIImageGetImageFromName(@"guidePage_01.png")];
            
            [image2 setImage:UIImageGetImageFromName(@"guidePage_02.png")];
            
            [image3 setImage:UIImageGetImageFromName(@"guidePage_03.png")];
            
            [image4 setImage:UIImageGetImageFromName(@"guidePage_04.png")];

        }
        
        
        
//        myPageControl.frame = CGRectMake((320 - (25*3))/2+10, myScrollView.frame.origin.y+myScrollView.frame.size.height - 30, 25*3, 12);


    }
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    if (myScrollView) {
//        NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width/3)/scrollView.frame.size.width;
//        
//        myPageControl.currentPage = page;
        
        if(scrollView.contentOffset.x < 0)
        {
            [myScrollView setContentOffset:CGPointMake(0, myScrollView.contentOffset.y)];
        }
        if(scrollView.contentOffset.x > 1010)
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationDidStopSelector:@selector(guideHidden)];
            self.frame = CGRectMake(-320, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
            [UIView commitAnimations];
            
            if(!isArePerform)
            {
                isArePerform = YES;
                
                if(delegate && [delegate respondsToSelector:@selector(disMissGuideViewFromSuperView)])
                {
                    [delegate disMissGuideViewFromSuperView];
                }
            }
            

        }
    }
    
}

-(void)pressStart:(UIButton *)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDidStopSelector:@selector(guideHidden)];
    self.frame = CGRectMake(-320, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
}
-(void)guideHidden
{
    if(self.superview != nil)
    {
        [myScrollView removeFromSuperview];
        myScrollView.delegate = nil;
        myScrollView = nil;
    }
    


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