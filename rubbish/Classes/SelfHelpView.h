//
//  SelfHelpView.h
//  caibo
//
//  Created by cp365dev on 14-5-20.
//
//

#import <UIKit/UIKit.h>



@interface SelfHelpView : UIView
{
    UIImageView *bgImage;
    UIImageView *bgImage1;
    
    UIImageView *sliderFinish; //已完成部分
    UIImageView *sliderRound;  //圆球位置
    UIImageView *sliderjingdubg;
    UILabel *sliderLabel;
    UILabel *uploadingLabel;
    UILabel *uploadingLabel1;
    
    UIImageView *sliderFinish1;
    UIImageView *sliderRound1;
    UILabel *sliderLabel1;
    UIImageView *sliderjingdubg1;
    
    UIImageView *grayView1;
    UIImageView *grayView2;
}
-(id)initWithFrame:(CGRect)frame andTitle1:(NSString *)title1 title2:(NSString *)title2;

-(void)showUpLoadSlider;  //添加遮罩层  并显示上传进度

-(void)refreshUploadSlider:(float)progress;

-(void)refreshBelowUploadSlider:(float)progress;

-(void)removeSliderFromSuperView;
@end
