//
//  DetailHeaderView.m
//  Experts
//
//  Created by hudong yule on 15/10/30.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "DetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "caiboAppDelegate.h"

@implementation DetailHeaderView

-(DetailHeaderView *)DetailHeaderViewWithArray:(NSArray *)dataArray andShowManayFalgs:(BOOL)showManayFlags andDigitalNavBtnTag:(NSInteger)btnTag headStr:(NSString *)headStr superNick:(NSString *)superNick superIntro:(NSString *)superIntro superLevelValue:(NSString *)superLevelValue exsource:(NSString *)exsource smgBtn:(BOOL)smgBtn totalRecNo:(NSString *)totalRecNo weekWinRate:(NSString *)weekWinRate monthWinRate:(NSString *)monthWinRate isfocusOrNo:(NSInteger)isfocusOrNo source:(NSString *)source isSdOrZj:(BOOL)isSdOrZj
{
    _showManayFlags=showManayFlags;
    
    _headerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 55, 55)];
    NSURL *url=[NSURL URLWithString:headStr];
    [_headerImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageRetryFailed|SDWebImageContinueInBackground];
    _headerImageView.layer.cornerRadius=27.5;
    _headerImageView.layer.masksToBounds=YES;
    [self addSubview:_headerImageView];
    
    UIImageView *markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_headerImageView.frame)+40, CGRectGetMinY(_headerImageView.frame)+40, 15, 15)];
    markView.layer.cornerRadius=7.5;
    markView.layer.masksToBounds=YES;
    markView.image=[UIImage imageNamed:@"V_red"];
    [self addSubview:markView];
    if ([exsource intValue]==0) {
        markView.hidden=NO;
    }else{
        markView.hidden=YES;
    }
    
    _nikeName=[[UILabel alloc]init];
    //    NSString *subString=superNick;
    //    if(superNick.length>4){
    //        NSRange range=NSMakeRange(0, 4);
    //        subString=[superNick substringWithRange:range];
    //    }
    
    _nikeName.text=superNick;
    _nikeName.font=FONTTHIRTY_TWO;
    _nikeName.textColor=[UIColor blackColor];
    _nikeName.alpha=0.87;
    CGSize headerViewSize=[PublicMethod setNameFontSize:_nikeName.text andFont:FONTTHIRTY_TWO andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (_SMGOrDigitalFlags) {
        _nikeName.frame=CGRectMake(CGRectGetMaxX(_headerImageView.frame)+15,_headerImageView.frame.origin.y,headerViewSize.width, headerViewSize.height);
    }else{
        _nikeName.frame=CGRectMake(CGRectGetMaxX(_headerImageView.frame)+15,CGRectGetMaxY(_headerImageView.frame)-headerViewSize.height/2-22.5,headerViewSize.width, headerViewSize.height);
    }
    [self addSubview:_nikeName];
        
    UIView *focusView=[[UIView alloc] initWithFrame:CGRectMake(MyWidth-60*MyWidth/320, 15, 60*MyWidth/320, 35)];
    focusView.backgroundColor=[UIColor clearColor];
    if(isSdOrZj){
        focusView.hidden=YES;
    }
    [self addSubview:focusView];
    
    NSString *imgName=@"";
    NSString *focusIsOrNo=@"";
    if (isfocusOrNo==1) {
//        imgName=@"已关注";//
        imgName=@"CS_atlascomment_collect";
        focusIsOrNo=@"已关注";
    }else{
//        imgName=@"待关注";
        imgName=@"CS_atlascomment_nocollect";
        focusIsOrNo=@"关注";
    }
    
    UIImage *focusImg=[UIImage imageNamed:imgName];
    UIImageView *focusImgView=[[UIImageView alloc] initWithFrame:CGRectMake(30*MyWidth/320-focusImg.size.width/2 + 10, 5, focusImg.size.width/2.0, focusImg.size.height/2.0)];
    focusImgView.image=focusImg;
    focusImgView.contentMode=UIViewContentModeScaleAspectFit;
    [focusView addSubview:focusImgView];
    focusImgView.backgroundColor=[UIColor clearColor];
    _focusImgV=focusImgView;
    
    
    headerViewSize=[PublicMethod setNameFontSize:@"已关注" andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    UILabel *focusLab=[[UILabel alloc] initWithFrame:CGRectMake(15*MyWidth/320 - 5, CGRectGetMaxY(focusImgView.frame), 40*MyWidth/320, headerViewSize.width)];
    focusLab.text=focusIsOrNo;
    focusLab.textAlignment=NSTextAlignmentCenter;
    focusLab.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    focusLab.textColor=[UIColor colorWithRed:230.0/255.0 green:69.0/255.0 blue:74.0/255.0 alpha:1.0];
    focusLab.font=FONTTWENTY;
    [focusView addSubview:focusLab];
    _focusLab=focusLab;
    
    UITapGestureRecognizer *focusTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusClick:)];
    focusView.userInteractionEnabled=YES;
    [focusView addGestureRecognizer:focusTap];
    
    if (_SMGOrDigitalFlags) {
        headerViewSize=[PublicMethod setNameFontSize:@"总推荐数" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *tolRecNo=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(_nikeName.frame), CGRectGetMaxY(_nikeName.frame)+10, headerViewSize.width, headerViewSize.height)];
        tolRecNo.text=@"总推荐数";
        tolRecNo.font=FONTTWENTY_FOUR;
        tolRecNo.textColor=BLACK_SEVENTY;
        [self addSubview:tolRecNo];
        
        headerViewSize=[PublicMethod setNameFontSize:totalRecNo andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *tolRecNoLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tolRecNo.frame)+10, CGRectGetMinY(tolRecNo.frame), headerViewSize.width, headerViewSize.height)];
        tolRecNoLab.text=totalRecNo;
        tolRecNoLab.font=FONTTWENTY_FOUR;
        tolRecNoLab.textColor=[UIColor colorWithRed:255.0/255 green:59.0/255 blue:48.0/255 alpha:1.0];
        [self addSubview:tolRecNoLab];
        
        headerViewSize=[PublicMethod setNameFontSize:@"周胜率" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *weWinRate=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(tolRecNo.frame), CGRectGetMaxY(tolRecNo.frame)+10, headerViewSize.width, headerViewSize.height)];
        weWinRate.text=@"周胜率";
        weWinRate.font=FONTTWENTY_FOUR;
        weWinRate.textColor=BLACK_SEVENTY;
        [self addSubview:weWinRate];
        
        headerViewSize=[PublicMethod setNameFontSize:weekWinRate andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _weekWinRateLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(weWinRate.frame)+10, CGRectGetMinY(weWinRate.frame), headerViewSize.width, headerViewSize.height)];
        _weekWinRateLab.text=weekWinRate;
        _weekWinRateLab.font=FONTTWENTY_FOUR;
        _weekWinRateLab.textColor=[UIColor colorWithRed:255.0/255 green:59.0/255 blue:48.0/255 alpha:1.0];
        [self addSubview:_weekWinRateLab];
        
        headerViewSize=[PublicMethod setNameFontSize:@"月胜率" andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        UILabel *mouWinRate=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_weekWinRateLab.frame)+20, CGRectGetMinY(_weekWinRateLab.frame), headerViewSize.width, headerViewSize.height)];
        mouWinRate.text=@"月胜率";
        mouWinRate.font=FONTTWENTY_FOUR;
        mouWinRate.textColor=BLACK_SEVENTY;
        [self addSubview:mouWinRate];
        
        headerViewSize=[PublicMethod setNameFontSize:monthWinRate andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _mouthWinRateLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(mouWinRate.frame)+10, CGRectGetMinY(mouWinRate.frame), headerViewSize.width, headerViewSize.height)];
        _mouthWinRateLab.text=monthWinRate;
        _mouthWinRateLab.font=FONTTWENTY_FOUR;
        _mouthWinRateLab.textColor=[UIColor colorWithRed:255.0/255 green:59.0/255 blue:48.0/255 alpha:1.0];
        [self addSubview:_mouthWinRateLab];
        
        if([source isEqualToString:@"204"]){
            weWinRate.hidden = YES;
            _weekWinRateLab.hidden = YES;
            mouWinRate.hidden = YES;
            _mouthWinRateLab.hidden = YES;
        }
    }
    
    //    if(![superOdd isEqualToString:@"最近0中0"]&&![superOdd isEqualToString:@"最近"]){
    //        //状态，5中5
    //        UIImage * correctImage=[UIImage imageNamed:@"单关-最近5中5"];
    //        UIImageView * correctImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_nikeName.frame.origin.x,CGRectGetMaxY(_nikeName.frame)+15,correctImage.size.width, correctImage.size.height)];
    //        correctImageView.image=correctImage;
    //        self.correctImageView=correctImageView;
    //        if (_SMGOrDigitalFlags) {
    //            [self addSubview:correctImageView];
    //        }
    //
    //        UILabel * statics=[[UILabel alloc]initWithFrame:CGRectMake(correctImageView.frame.origin.x,correctImageView.frame.origin.y, correctImage.size.width,correctImage.size.height)];
    //        self.correctCountLab=statics;
    //        statics.text=superOdd;
    //        statics.textAlignment=NSTextAlignmentCenter;
    //        statics.font=FONTTWENTY_FOUR;
    //        statics.textColor=RGB(240., 70., 14.);
    //        if (_SMGOrDigitalFlags) {
    //            [self addSubview:statics];
    //        }
    //    }
    
    //简介
    _introductionLab=[[UILabel alloc]init];
    if ([superIntro isEqualToString:@""]||superIntro==nil) {
        superIntro=@"";
    }
    _introductionLab.text=[NSString stringWithFormat:@"简介：%@",superIntro];
    _introductionLab.font=FONTTWENTY_FOUR;
    _introductionLab.numberOfLines=0;
    _introductionLab.textColor=[UIColor blackColor];
    _introductionLab.alpha=0.87;
    [self addSubview:_introductionLab];
    
    headerViewSize=[PublicMethod setNameFontSize:_introductionLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MyWidth-30, MAXFLOAT)];
    _introductionLabHeight=headerViewSize.height-30;//2行大概是28.64,这个变量记录的是多于两行之外的简介文字的高度
    if (headerViewSize.height>30) {
        //大于2行要此按钮
        _introductionLab.frame=CGRectMake(15, CGRectGetMaxY(_headerImageView.frame)+20, MyWidth-30, 30);
    } else {
        _introductionLab.frame=CGRectMake(15, CGRectGetMaxY(_headerImageView.frame)+20, MyWidth-30, headerViewSize.height);
        _isDuoYuTwo=YES;
    }
    //_showManayImage=[UIImage imageNamed:@"向下展开箭头"];
    if (showManayFlags) {
        _introductionLab.frame=CGRectMake(15, CGRectGetMaxY(_headerImageView.frame)+20, MyWidth-30, 30+_introductionLabHeight);
        //_showManayImage=[UIImage imageNamed:@"向上收缩箭头"];
    }
    
    headerViewSize=[PublicMethod setNameFontSize:@"展开" andFont:FONTTWENTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    //箭头按钮
    _showManayBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _showManayBtn.frame=CGRectMake(MyWidth-headerViewSize.width-25, CGRectGetMaxY(_introductionLab.frame), headerViewSize.width+20, headerViewSize.height+10);
    [_showManayBtn setBackgroundColor:[UIColor clearColor]];
    //[_showManayBtn setImage:_showManayImage forState:UIControlStateNormal];
    //[_showManayBtn setImage:_showManayImage forState:UIControlStateHighlighted];
    [_showManayBtn setTitle:@"展开" forState:UIControlStateNormal];
    [_showManayBtn setTitle:@"展开" forState:UIControlStateHighlighted];
    if(_showManayFlags){
        [_showManayBtn setTitle:@"收起" forState:UIControlStateNormal];
        [_showManayBtn setTitle:@"收起" forState:UIControlStateHighlighted];
    }
    [_showManayBtn setTitleColor:BLACK_FIFITYFOUR forState:UIControlStateNormal];
    [_showManayBtn setTitleColor:BLACK_FIFITYFOUR forState:UIControlStateHighlighted];
    _showManayBtn.titleEdgeInsets=UIEdgeInsetsMake(5, 10, 5, 10);
    _showManayBtn.titleLabel.font=FONTTWENTY;
    [_showManayBtn addTarget:self action:@selector(showManayBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    if (_isDuoYuTwo) {
        //少于两行不显示显示更多按钮
        _showManayBtn.frame=CGRectMake(MyWidth-headerViewSize.width-15, CGRectGetMaxY(_introductionLab.frame)+5, headerViewSize.width,0);
        _showManayBtn.hidden=YES;
    }
    [self addSubview:_showManayBtn];
    
    _viewOfDigital=[[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_showManayBtn.frame)+10, MyWidth, 42)];
    [self addSubview:_viewOfDigital];
    
    UIView * line=[[UIView alloc]initWithFrame:CGRectMake(0,0, MyWidth, 0.5)];
    line.backgroundColor=SEPARATORCOLOR;
    [_viewOfDigital addSubview:line];
    
    
    CGFloat btnW=0.0;
    CGFloat btnH=43.5;
    
    //这里添加判断，判断进来的是竞足还是数字彩
    if (!_SMGOrDigitalFlags) {//数字彩
        _btnTitleArray=[NSArray arrayWithObjects:@"双色球",@"大乐透",@"3D",@"排列三",nil];
    } else {
//        _btnTitleArray=[NSArray arrayWithObjects:@"竞足",@"亚盘",nil];
//        _btnTitleArray=[NSArray arrayWithObjects:@"竞足",@"2串1",nil];
        _btnTitleArray=[NSArray arrayWithObjects:@"竞足",@"篮彩",@"2串1",nil];
    }
    btnW=(MyWidth-(_btnTitleArray.count-1)*0.5)/[_btnTitleArray count];
    for (int i=0; i<_btnTitleArray.count; i++) {
        UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_viewOfDigital addSubview:btn];
        btn.frame=CGRectMake((CGFloat)(btnW+0.5)*i, 0.5, btnW, btnH);
        NSLog(@"%f",btn.frame.origin.x);
        btn.titleLabel.font=FONTTHIRTY;
        [btn setBackgroundImage:[UIImage imageNamed:@"背景-1"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"背景-2蓝色"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"背景-2蓝色"] forState:UIControlStateHighlighted];
        [btn setTitle:[_btnTitleArray objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitle:[_btnTitleArray objectAtIndex:i] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[SharedMethod getColorByHexString:@"1588da"] forState:UIControlStateSelected];
        [btn setTitleColor:[SharedMethod getColorByHexString:@"1588da"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(digitalNavBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=100+i;
        
#if defined CRAZYSPORTS
        [btn setBackgroundImage:[UIImage imageNamed:@"背景-2"] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"背景-2"] forState:UIControlStateHighlighted];
        [btn setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateSelected];
        [btn setTitleColor:[SharedMethod getColorByHexString:@"6e29bd"] forState:UIControlStateHighlighted];
#endif
        
        //按钮右边的线
        UILabel * lineRight=[[UILabel alloc]initWithFrame:CGRectMake((CGFloat)(btnW+0.5)*i+btnW,btn.frame.origin.y,0.5,_viewOfDigital.frame.size.height-1.5)];
        lineRight.backgroundColor=SEPARATORCOLOR;
        [_viewOfDigital addSubview:lineRight];
        
        if (_SMGOrDigitalFlags) {
            if ([source isEqualToString:@"-201"]&&i==0) {
                btn.selected=YES;
            }else if ([source isEqualToString:@"204"]&&i==1) {
                btn.selected=YES;
            }else if ([source isEqualToString:@"201"]&&i==2) {
                btn.selected=YES;
            }
        }else{
            if (i==btnTag) {
                btn.selected=YES;
            }
        }
    }
    
    //推荐方案所在的黑色背景
    _headerBottomBg=[[UIView alloc] init];
    [_headerBottomBg setFrame:CGRectMake(0, CGRectGetMaxY(_viewOfDigital.frame)+2.5, MyWidth, 25)];
    _headerBottomBg.backgroundColor=[UIColor colorWithHexString:@"f2f2f2"];
    [self addSubview:_headerBottomBg];
    
    UIView *sepView=[[UIView alloc] initWithFrame:CGRectMake(0, _headerBottomBg.frame.size.height-0.5, MyWidth, 0.5)];
    sepView.backgroundColor=SEPARATORCOLOR;
    [_headerBottomBg addSubview:sepView];
    
    //投影
    UIImageView * touYing=[[UIImageView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_viewOfDigital.frame)+2, MyWidth, 0.5)];
//    touYing.image=[UIImage imageNamed:@"touying"];
    touYing.backgroundColor = [UIColor blackColor];
    touYing.alpha = 0.1;
    [self addSubview:touYing];
    
    //添加小竖条
    UIImage * shuTiao=[UIImage imageNamed:@"最新推荐装饰"];
    _shuTiaoImageView=[[UIImageView alloc]initWithImage:shuTiao];
    _shuTiaoImageView.frame=CGRectMake(_introductionLab.frame.origin.x, (25-shuTiao.size.height)*0.5+_headerBottomBg.frame.origin.y, shuTiao.size.width, shuTiao.size.height);
    [self addSubview:_shuTiaoImageView];
    _shuTiaoImageView.hidden = YES;
    
    //推荐方案汉字
    _recommandPlan=[[UILabel alloc]init];
    _recommandPlan.text=@"最新推荐";
    _recommandPlan.textColor=[UIColor blackColor];
    _recommandPlan.font=FONTTHIRTY;
    _recommandPlan.alpha=0.87;
    _recommandPlan.baselineAdjustment=UIBaselineAdjustmentAlignCenters;
    headerViewSize=[PublicMethod setNameFontSize:_recommandPlan.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _newRecommandHeight=headerViewSize.height;
    _recommandPlan.frame=CGRectMake(15, 0.5*(25-headerViewSize.height)+_headerBottomBg.frame.origin.y, headerViewSize.width, headerViewSize.height);
    [self addSubview:_recommandPlan];
    
    UIImage *img=[UIImage imageNamed:@"展开箭头"];
    if (smgBtn) {
        img=[UIImage imageNamed:@"收起箭头"];
    }
    
    _accessoryBtn=[SMGBtn buttonWithType:UIButtonTypeCustom];
    [_accessoryBtn setFrame:CGRectMake(MyWidth-60, CGRectGetMinY(_headerBottomBg.frame), 60, 25)];
    [_accessoryBtn setBackgroundColor:[UIColor clearColor]];
    [_accessoryBtn setImage:img forState:UIControlStateNormal];
    [_accessoryBtn setImage:img forState:UIControlStateHighlighted];
//    _accessoryBtn.imageEdgeInsets=UIEdgeInsetsMake(24-img.size.height/2, 30-img.size.width/2, 24-img.size.height/2, 30-img.size.height/2);
    [_accessoryBtn addTarget:self action:@selector(accessoryBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (_SMGOrDigitalFlags) {
        [self addSubview:_accessoryBtn];
        
    }
    
    CGRect rect=self.frame;
    rect.size.height=CGRectGetMaxY(_headerBottomBg.frame);
    [self setFrame:rect];
    
    return self;
}
/**
 *  显示更多按钮点击响应函数
 */
-(void)showManayBtnOnClick
{
    //代理回传到控制器并带参数：简介的高度
    NSLog(@"显示更多按钮被点击");
    [_delegate showManayBtnOnClick:_introductionLabHeight andFlags:!_showManayFlags];
}
/**
 *  按钮响应函数
 */
-(void)digitalNavBtnOnClick:(UIButton *)btn
{
    NSLog(@"单击了全部、双色球等按钮");
    for (int i=0; i<_btnTitleArray.count; i++) {
        UIButton * digitalNavBtn=(UIButton *)[_viewOfDigital viewWithTag:100+i];
        if (btn.tag==100+i) {
            digitalNavBtn.selected=YES;
        } else {
            digitalNavBtn.selected=NO;
        }
    }
    //在此代理回传被点击事件
    [_delegate digitalNavBtnOnClickWithBtnTag:btn.tag-100];
}

- (void)accessoryBtnClick:(SMGBtn *)btn{
    if (_delegate&&[_delegate respondsToSelector:@selector(showContent:)]) {
        [_delegate showContent:btn];
    }
}

- (void)focusClick:(UITapGestureRecognizer *)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(focusOrNo:)]) {
        [_delegate focusOrNo:tap];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    