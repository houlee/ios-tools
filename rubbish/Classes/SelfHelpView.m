//
//  SelfHelpView.m
//  caibo
//
//  Created by cp365dev on 14-5-20.
//
//

#import "SelfHelpView.h"

@implementation SelfHelpView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame andTitle1:(NSString *)title1 title2:(NSString *)title2
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6.0;
        self.layer.borderWidth = 0.3;
        self.layer.borderColor = [[UIColor grayColor] CGColor];
        
        //左线
        UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(9, 22, 30, 1)];
        [xian1 setImage:UIImageGetImageFromName(@"wf_xian2.png")];
        [self addSubview:xian1];
        [xian1 release];
        
        //Title 1
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(xian1.frame.origin.x+xian1.frame.size.width+5, 13, 160, 17)];
        label1.backgroundColor = [UIColor clearColor];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = title1;
        label1.font = [UIFont systemFontOfSize:12];
        [self addSubview:label1];
        [label1 release];
        //右线
        UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(label1.frame.origin.x+label1.frame.size.width+5, 22, 30, 1)];
        [xian2 setImage:UIImageGetImageFromName(@"wf_xian2.png")];
        [self addSubview:xian2];
        [xian2 release];
        
        
        
        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(9, 39, 241, 151)];
        [bgImage setImage:UIImageGetImageFromName(@"selfhelp_BackGround.png")];
        [self addSubview:bgImage];
        [bgImage release];
        
        
        //左线
        UIImageView *xian11 = [[UIImageView alloc] initWithFrame:CGRectMake(9, bgImage.frame.origin.y+bgImage.frame.size.height+22, 30, 1)];
        [xian11 setImage:UIImageGetImageFromName(@"wf_xian2.png")];
        [self addSubview:xian11];
        [xian11 release];
        
        //Title 2
        UILabel *label11 = [[UILabel alloc] initWithFrame:CGRectMake(xian11.frame.origin.x+xian11.frame.size.width+5, bgImage.frame.origin.y+bgImage.frame.size.height+13, 160, 17)];
        label11.backgroundColor = [UIColor clearColor];
        label11.textAlignment = NSTextAlignmentCenter;
        label11.text = title2;
        label11.font = [UIFont systemFontOfSize:12];
        [self addSubview:label11];
        [label11 release];
        
        //右线
        UIImageView *xian21 = [[UIImageView alloc] initWithFrame:CGRectMake(label11.frame.origin.x+label11.frame.size.width+5, xian11.frame.origin.y, 30, 1)];
        [xian21 setImage:UIImageGetImageFromName(@"wf_xian2.png")];
        [self addSubview:xian21];
        [xian21 release];
        
        bgImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(9, label11.frame.origin.y+label11.frame.size.height+9, 241, 151)];
        [bgImage1 setImage:UIImageGetImageFromName(@"selfhelp_BackGround.png")];
        [self addSubview:bgImage1];
        [bgImage1 release];
        
    }
    return self;
    
}
//上方进度条
-(void)showUpLoadSlider
{
    NSLog(@"显示上传进度");
    
    //灰色遮罩层
    grayView1 = [[UIImageView alloc] initWithFrame:bgImage.frame];
    [grayView1 setBackgroundColor:[UIColor clearColor]];
    [self addSubview:grayView1];
    [grayView1 release];
    
    //上传中...
    uploadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, grayView1.frame.size.width, 17)];
    uploadingLabel.backgroundColor = [UIColor clearColor];
    uploadingLabel.textColor = [UIColor whiteColor];
    uploadingLabel.textAlignment = NSTextAlignmentCenter;
    uploadingLabel.text  = @"上传中...";
    [grayView1 addSubview:uploadingLabel];
    [uploadingLabel release];
    
    //进度条背景
    UIImageView *sliderbg = [[UIImageView alloc] initWithFrame:CGRectMake(30,uploadingLabel.frame.origin.y+uploadingLabel.frame.size.height + 20 , 181, 7)];
    [sliderbg setImage:UIImageGetImageFromName(@"selfhelp_sliderbg.png")];
    [grayView1 addSubview:sliderbg];
    [sliderbg release];
    //进度条(已完成部分)
    sliderFinish = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, sliderbg.frame.size.height)];
    [sliderFinish setImage:UIImageGetImageFromName(@"selfhelp_sliderjindu.png")];
    [sliderbg addSubview:sliderFinish];
    [sliderFinish release];
    //圆
    sliderRound = [[UIImageView alloc] initWithFrame:CGRectMake(sliderFinish.frame.origin.x+sliderFinish.frame.size.width-7, -4, 15, 15)];
    [sliderRound setImage:UIImageGetImageFromName(@"selfhelp_slideryuan.png")];
    [sliderbg addSubview:sliderRound];
    [sliderRound release];
    //进度条精度背景
    sliderjingdubg = [[UIImageView alloc] initWithFrame:CGRectMake(sliderFinish.frame.origin.x+sliderFinish.frame.size.width-15, sliderRound.frame.origin.y+sliderRound.frame.size.height, 30, 16)];
    [sliderjingdubg setImage:UIImageGetImageFromName(@"selfhelp_sliderjingdu.png")];
    [sliderbg addSubview:sliderjingdubg];
    [sliderjingdubg release];
    //进度条精度
    sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, sliderjingdubg.frame.size.width, sliderjingdubg.frame.size.height-2)];
    sliderLabel.backgroundColor = [UIColor clearColor];
    sliderLabel.textAlignment = NSTextAlignmentCenter;
    sliderLabel.text = @"0%";
    sliderLabel.textColor = [UIColor whiteColor];
    sliderLabel.font = [UIFont systemFontOfSize:6];
    [sliderjingdubg addSubview:sliderLabel];
    [sliderLabel release];
    
    
    [self showBelowUpLoadSlider];
}

-(void)refreshUploadSlider:(float)progress 
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:0.02];
    
    sliderFinish.frame = CGRectMake(0, 0, 181*progress, sliderFinish.frame.size.height);
    sliderRound.frame = CGRectMake(sliderFinish.frame.origin.x+sliderFinish.frame.size.width-7, -4, 15, 15);
    sliderjingdubg.frame =CGRectMake(sliderFinish.frame.origin.x+sliderFinish.frame.size.width-15, sliderRound.frame.origin.y+sliderRound.frame.size.height, 30, 16);
    sliderLabel.frame =CGRectMake(0, 2, sliderjingdubg.frame.size.width, sliderjingdubg.frame.size.height-2);
    sliderLabel.text = [NSString stringWithFormat:@"%.2f%%",progress*100];
    
    if(progress == 1)
    {
        uploadingLabel.hidden = YES;
    }
//    [UIView commitAnimations];
    
    
}
-(void)refreshBelowUploadSlider:(float)progress
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.01];
    
    sliderFinish1.frame = CGRectMake(0, 0, 181*progress, sliderFinish.frame.size.height);
    sliderRound1.frame = CGRectMake(sliderFinish1.frame.origin.x+sliderFinish1.frame.size.width-7, -4, 15, 15);
    sliderjingdubg1.frame =CGRectMake(sliderFinish1.frame.origin.x+sliderFinish1.frame.size.width-15, sliderRound1.frame.origin.y+sliderRound1.frame.size.height, 30, 16);
    sliderLabel1.frame =CGRectMake(0, 2, sliderjingdubg1.frame.size.width, sliderjingdubg1.frame.size.height-2);
    sliderLabel1.text = [NSString stringWithFormat:@"%.2f%%",progress*100];
    
    if(progress == 1)
    {
        uploadingLabel1.hidden = YES;
    }
//    [UIView commitAnimations];
}
//下方进度条
-(void)showBelowUpLoadSlider
{
    //灰色遮罩层
    grayView2 = [[UIImageView alloc] initWithFrame:bgImage1.frame];
    [grayView2 setBackgroundColor:[UIColor clearColor]];
    [self addSubview:grayView2];
    [grayView2 release];
    
    //上传中...
    uploadingLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, grayView2.frame.size.width, 17)];
    uploadingLabel1.backgroundColor = [UIColor clearColor];
    uploadingLabel1.textColor = [UIColor whiteColor];
    uploadingLabel1.textAlignment = NSTextAlignmentCenter;
    uploadingLabel1.text  = @"上传中...";
    [grayView2 addSubview:uploadingLabel1];
    [uploadingLabel1 release];
    
    //进度条背景
    UIImageView *sliderbg = [[UIImageView alloc] initWithFrame:CGRectMake(30,uploadingLabel1.frame.origin.y+uploadingLabel1.frame.size.height + 20 , 181, 7)];
    [sliderbg setImage:UIImageGetImageFromName(@"selfhelp_sliderbg.png")];
    [grayView2 addSubview:sliderbg];
    [sliderbg release];
    //进度条(已完成部分)
    sliderFinish1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 181*0.0, sliderbg.frame.size.height)];
    [sliderFinish1 setImage:UIImageGetImageFromName(@"selfhelp_sliderjindu.png")];
    [sliderbg addSubview:sliderFinish1];
    [sliderFinish1 release];
    //圆
    sliderRound1 = [[UIImageView alloc] initWithFrame:CGRectMake(sliderFinish1.frame.origin.x+sliderFinish1.frame.size.width-7, -4, 15, 15)];
    [sliderRound1 setImage:UIImageGetImageFromName(@"selfhelp_slideryuan.png")];
    [sliderbg addSubview:sliderRound1];
    [sliderRound1 release];
    //进度条精度背景
    sliderjingdubg1 = [[UIImageView alloc] initWithFrame:CGRectMake(sliderFinish1.frame.origin.x+sliderFinish1.frame.size.width-15, sliderRound1.frame.origin.y+sliderRound1.frame.size.height, 30, 16)];
    [sliderjingdubg1 setImage:UIImageGetImageFromName(@"selfhelp_sliderjingdu.png")];
    [sliderbg addSubview:sliderjingdubg1];
    [sliderjingdubg1 release];
    //进度条精度
    sliderLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, sliderjingdubg1.frame.size.width, sliderjingdubg1.frame.size.height-2)];
    sliderLabel1.backgroundColor = [UIColor clearColor];
    sliderLabel1.textAlignment = NSTextAlignmentCenter;
    sliderLabel1.text = @"0%";
    sliderLabel1.textColor = [UIColor whiteColor];
    sliderLabel1.font = [UIFont systemFontOfSize:6];
    [sliderjingdubg1 addSubview:sliderLabel1];
    [sliderLabel1 release];

}
-(void)removeSliderFromSuperView
{
    if([grayView1 isDescendantOfView:self])
    {
        [grayView1 removeFromSuperview];
    }
    if([grayView2 isDescendantOfView:self])
    {
        [grayView2 removeFromSuperview];
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