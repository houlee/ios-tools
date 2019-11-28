//
//  ExpertDetailCell.m
//  Experts
//
//  Created by v1pin on 15/10/28.
//  Copyright © 2015年 YC. All rights reserved.
//

#import "ExpertDetailCell.h"

@interface ExpertDetailCell()

@end

@implementation ExpertDetailCell

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+(id)ExpertDetailCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    static NSString * superiorCellId=@"superior";
    ExpertDetailCell * cell=(ExpertDetailCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[ExpertDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:superiorCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //创建cell上的子控件
        UIImageView * headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15*MyWidth/320, 15, 45*MyWidth/320, 45*MyWidth/320)];
        [self.contentView addSubview:headImageView];
        headImageView.layer.cornerRadius=22.5*MyWidth/320;
        headImageView.layer.masksToBounds=YES;
        self.headImgView=headImageView;
        
        UIImageView *markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headImageView.frame)+32.5*MyWidth/320, CGRectGetMinY(headImageView.frame)+32.5*MyWidth/320, 10*MyWidth/320, 10*MyWidth/320)];
        markView.layer.cornerRadius=5*MyWidth/320;
        markView.layer.masksToBounds=YES;
        markView.image=[UIImage imageNamed:@"V_red"];
        [self.contentView addSubview:markView];
        _markImgView=markView;
        
        UILabel *nickNameLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15*MyWidth/320, 15, 100, 20)];
        nickNameLab.font=FONTTHIRTY;
        nickNameLab.textColor=[UIColor colorWithRed:21.0/255 green:136.0/255 blue:218.0/255 alpha:1.0];
        nickNameLab.backgroundColor=[UIColor clearColor];
        [self addSubview:nickNameLab];
        self.nickNamelab=nickNameLab;
        
        UIImageView *rangImgV=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(nickNameLab)+10, nickNameLab.frame.size.height/2-7, 39, 14)];
        rangImgV.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:rangImgV];
        _rankImgView=rangImgV;
        
        UILabel *rankLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 24, 14)];
        rankLab.backgroundColor=[UIColor clearColor];
        rankLab.font=[UIFont systemFontOfSize:8.0];
        rankLab.textColor=RGBColor(255.0, 96.0, 0.0);
        rankLab.textAlignment=NSTextAlignmentCenter;
        [rangImgV addSubview:rankLab];
        _rankLab=rankLab;
        
        UIImageView *imgZhongView=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth-62,20,47,18.5)];
        imgZhongView.image=[UIImage imageNamed:@"5中5"];
        [self addSubview:imgZhongView];
        _zhongView=imgZhongView;
        
        //状态
        UILabel * statics=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 47, 18.5)];
        [imgZhongView addSubview:statics];
        statics.font=[UIFont systemFontOfSize:12.0f];
        statics.textColor=[UIColor colorWithRed:240.0/255 green:70.0/255 blue:14.0/255 alpha:1.0];
        statics.backgroundColor=[UIColor clearColor];
        self.statLab=statics;
        statics.textAlignment=NSTextAlignmentCenter;
        
        //对决
        UILabel * twoSideLab=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15*MyWidth/320, CGRectGetMaxY(nickNameLab.frame)+8, 150, 20)];
        twoSideLab.font=FONTTHIRTY;
        twoSideLab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
        [self addSubview:twoSideLab];
        self.twoSideLab=twoSideLab;
        
        UIImageView *ypImgVw=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(twoSideLab.frame)+5.5*MyWidth/320, CGRectGetMinY(twoSideLab.frame)+2.5, 15, 15)];
        ypImgVw.image=[UIImage imageNamed:@"yapan"];
        ypImgVw.hidden=YES;
        [self addSubview:ypImgVw];
        self.ypImgView=ypImgVw;
        
        UIImageView *refundImgView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(ypImgVw.frame)+5.5*MyWidth/320, CGRectGetMinY(twoSideLab.frame)+2.5, 15, 15)];
        refundImgView.image=[UIImage imageNamed:@"refund"];
        refundImgView.hidden=YES;
        [self addSubview:refundImgView];
        self.refundImgView=refundImgView;
        
        UILabel * time=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15*MyWidth/320, CGRectGetMaxY(twoSideLab.frame)+8, 80, 20)];
        time.font=[UIFont systemFontOfSize:12.0f];
        time.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.54];
        time.backgroundColor=[UIColor clearColor];
        [self addSubview:time];
        self.timeLab=time;
        
        UILabel * twoSideLab2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15*MyWidth/320, CGRectGetMaxY(time.frame)+8, 150, 20)];
        twoSideLab2.font=FONTTHIRTY;
        twoSideLab2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
        [self addSubview:twoSideLab2];
        self.name2=twoSideLab2;
        
        UILabel * time2=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15*MyWidth/320, CGRectGetMaxY(twoSideLab2.frame)+8, 90, 20)];
        time2.font=[UIFont systemFontOfSize:12.0f];
        time2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.54];
        time2.backgroundColor=[UIColor clearColor];
        [self addSubview:time2];
        self.time2=time2;
        
        UILabel *leagueTypeLab=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(time.frame)+32.5*MyWidth/320, CGRectGetMaxY(twoSideLab.frame)+8, 40, 20)];
        leagueTypeLab.font=[UIFont systemFontOfSize:12.0f];
        leagueTypeLab.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
        leagueTypeLab.backgroundColor=[UIColor clearColor];
        [self addSubview:leagueTypeLab];
        self.leagueTypeLab=leagueTypeLab;
        
        UILabel *leagueTypeLab2=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(time.frame)+32.5*MyWidth/320, CGRectGetMaxY(twoSideLab2.frame)+8, 40, 20)];
        leagueTypeLab2.font=[UIFont systemFontOfSize:12.0f];
        leagueTypeLab2.textColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.87];
        leagueTypeLab2.backgroundColor=[UIColor clearColor];
        [self addSubview:leagueTypeLab2];
        self.league2=leagueTypeLab2;
        
        UILabel * price=[[UILabel alloc]initWithFrame:CGRectMake(MyWidth-55, CGRectGetMaxY(twoSideLab.frame)+8, 40, 20)];
        price.font=[UIFont systemFontOfSize:12.0f];
        price.textColor=[UIColor colorWithRed:255/255 green:59/255 blue:48/255 alpha:1.0];
        price.textAlignment=NSTextAlignmentRight;
        [self addSubview:price];
        self.priceLab=price;
        
        //黑线
        UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,58+45*MyWidth/320-0.5, MyWidth, 0.5)];
        Line.backgroundColor=[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
        [self addSubview:Line];
        self.line = Line;
    }
    return self;
}

- (void)expertHead:(NSString *)head name:(NSString *)name starNo:(NSInteger)starNo odds:(NSString *)odds matchSides:(NSString *)matchSides time:(NSString *)time leagueType:(NSString *)leagueType exPrice:(float)exPrice exDiscount:(float)discount exRank:(NSInteger)exRank refundOrNo:(NSInteger)refundOrNo lotype:(NSString *)lotype{
    
    _name2.hidden = YES;
    _time2.hidden = YES;
    _league2.hidden = YES;
    _line.frame = CGRectMake(0,58+45*MyWidth/320-0.5, MyWidth, 0.5);
    
    NSURL *url=[NSURL URLWithString:head];
    [_headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    
    NSString *subString=name;
    if(name.length>4){
        NSRange range=NSMakeRange(0, 4);
        subString=[name substringWithRange:range];
    }
    _nickNamelab.text=subString;
    _nickNamelab.backgroundColor=[UIColor clearColor];
    
    CGSize reSize=[PublicMethod setNameFontSize:subString andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=_nickNamelab.frame;
    if (reSize.width>72.0) {
        rect.size.width=72.0;
    } else {
        rect.size.width=reSize.width;
    }
    rect.size.height=reSize.height;
    [_nickNamelab setFrame:rect];
    
    [_rankImgView setFrame:CGRectMake(ORIGIN_X(_nickNamelab)+10, 15+(rect.size.height-14)/2, 39, 14)];
    NSString *rankImg=@"";
    if (starNo<=5) {
        rankImg=@"ranklv1-5";
        _rankLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (starNo>5&&starNo<=10){
        rankImg=@"ranklv6-10";
        _rankLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (starNo>10&&starNo<=15){
        rankImg=@"ranklv11-15";
        _rankLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (starNo>15&&starNo<=20){
        rankImg=@"ranklv16-20";
        _rankLab.textColor=[UIColor whiteColor];
    }else if (starNo>20&&starNo<=25){
        rankImg=@"ranklv21-25";
        _rankLab.textColor=[UIColor whiteColor];
    }
    _rankImgView.image=[UIImage imageNamed:rankImg];
    
    _rankLab.text=[NSString stringWithFormat:@"LV%ld",(long)starNo];
    reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)starNo] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_rankLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    _statLab.text=odds;
    if ([odds isEqualToString:@"0中0"]) {
        _statLab.hidden=YES;
        _zhongView.hidden=YES;
    }
    
    _twoSideLab.text=matchSides;
    reSize=[PublicMethod setNameFontSize:matchSides andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=_twoSideLab.frame;
    rect.size.width=reSize.width;
    rect.size.height=reSize.height;
    [_twoSideLab setFrame:rect];
    
    if ([lotype isEqualToString:@"202"]) {
        self.ypImgView.hidden=NO;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5*MyWidth/320, CGRectGetMinY(_twoSideLab.frame)+2.5, 15, 15)];
    }else{
        self.ypImgView.hidden=YES;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5*MyWidth/320, CGRectGetMinY(_twoSideLab.frame)+2.5, 0, 15)];
    }
    
    if(refundOrNo==1){
        self.refundImgView.hidden=NO;
    }
    rect=self.refundImgView.frame;
    rect.origin.x=ORIGIN_X(_ypImgView)+5.5*MyWidth/320;
    [self.refundImgView setFrame:rect];
    
    _timeLab.text=time;
    _leagueTypeLab.text=leagueType;
    
    rect=_priceLab.frame;
    
    if (exPrice==0.0||discount==0.0) {
        _priceLab.text=@"免费";
        CGSize cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.priceLab.frame=CGRectMake(MyWidth-cellUIsize.width-15, rect.origin.y, cellUIsize.width, rect.size.height);
    }else{
        if (discount!=1) {
            _priceLab.text=[NSString stringWithFormat:@"%.2f元",exPrice*discount];
            QFLineLabel * discountPrice=[[QFLineLabel alloc] init];
            discountPrice.text=[NSString stringWithFormat:@"%.2f元",exPrice];
//#ifdef CRAZYSPORTS
//            int jinbibeishu = 10;//金币和钱比例
//            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//                jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//            }
//            _priceLab.text=[NSString stringWithFormat:@"%.0f金币",exPrice*discount * jinbibeishu];
//            discountPrice.text=[NSString stringWithFormat:@"%.0f金币",exPrice * jinbibeishu];
//#endif
            CGSize cellUIsize=[PublicMethod setNameFontSize:discountPrice.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            [discountPrice setFrame:CGRectMake(MyWidth-cellUIsize.width-15, rect.origin.y, cellUIsize.width, rect.size.height)];
            discountPrice.font=FONTTWENTY_FOUR;
            discountPrice.textColor=[UIColor grayColor];
            discountPrice.textAlignment=NSTextAlignmentRight;
            discountPrice.lineType=LineTypeMiddle;
            discountPrice.lineColor=[UIColor grayColor];
            [self.contentView addSubview:discountPrice];
            self.disCountLab=discountPrice;
            
            cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            self.priceLab.frame=CGRectMake(CGRectGetMinX(_disCountLab.frame)-cellUIsize.width-5, rect.origin.y, cellUIsize.width, rect.size.height);
        }else{
            _priceLab.text=[NSString stringWithFormat:@"%.2f元",exPrice];
//#ifdef CRAZYSPORTS
//            int jinbibeishu = 10;//金币和钱比例
//            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//                jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//            }
//            _priceLab.text=[NSString stringWithFormat:@"%.0f金币",exPrice * jinbibeishu];
//#endif
        
            
            CGSize cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            self.priceLab.frame=CGRectMake(MyWidth-cellUIsize.width-15, rect.origin.y, cellUIsize.width, rect.size.height);
        }
    }
    
    reSize=[PublicMethod setNameFontSize:leagueType andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=_leagueTypeLab.frame;
    rect.origin.x=CGRectGetMinX(_priceLab.frame)-reSize.width-10;
    rect.size.width=reSize.width;
    [_leagueTypeLab setFrame:rect];

    if (exRank==0) {
        _markImgView.hidden=NO;
    }else{
        _markImgView.hidden=YES;
    }
    
    if([lotype isEqualToString:@"204"]){//篮球
        _refundImgView.hidden=YES;
        _rankImgView.hidden = YES;
        _rankLab.hidden = YES;
        _zhongView.hidden = YES;
        _statLab.hidden = YES;
        
        NSMutableAttributedString * aString = [[NSMutableAttributedString alloc] initWithString:matchSides];
        
        NSRange range = [matchSides rangeOfString:@" "];
        
        [aString setAttributes:@{NSForegroundColorAttributeName:BLACK_EIGHTYSEVER,NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(0, range.location)];
        [aString setAttributes:@{NSForegroundColorAttributeName:DEFAULT_TEXTGRAYCOLOR,NSFontAttributeName:[UIFont systemFontOfSize:11]} range:NSMakeRange(range.location, aString.length-range.location)];
        _twoSideLab.attributedText = aString;
        
        _twoSideLab.frame = CGRectMake(CGRectGetMaxX(self.headImgView.frame)+15*MyWidth/320, CGRectGetMaxY(self.nickNamelab.frame)+4, self.contentView.frame.size.width-_twoSideLab.frame.origin.x-15, 35);
        _twoSideLab.numberOfLines = 2;
    }
}
- (void)expertHead:(NSString *)head name:(NSString *)name starNo:(NSInteger)starNo odds:(NSString *)odds matchSides:(NSString *)matchSides time:(NSString *)time leagueType:(NSString *)leagueType exPrice:(float)exPrice exDiscount:(float)discount exRank:(NSInteger)exRank refundOrNo:(NSInteger)refundOrNo lotype:(NSString *)lotype name2:(NSString *)name2 time2:(NSString *)time2 league2:(NSString *)league2{
    
    _name2.hidden = NO;
    _time2.hidden = NO;
    _league2.hidden = NO;
    
    NSURL *url=[NSURL URLWithString:head];
    [_headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    
    NSString *subString=name;
    if(name.length>4){
        NSRange range=NSMakeRange(0, 4);
        subString=[name substringWithRange:range];
    }
    _nickNamelab.text=subString;
    _nickNamelab.backgroundColor=[UIColor clearColor];
    
    CGSize reSize=[PublicMethod setNameFontSize:subString andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    CGRect rect=_nickNamelab.frame;
    if (reSize.width>72.0) {
        rect.size.width=72.0;
    } else {
        rect.size.width=reSize.width;
    }
    rect.size.height=reSize.height;
    [_nickNamelab setFrame:rect];
    
    [_rankImgView setFrame:CGRectMake(ORIGIN_X(_nickNamelab)+10, 15+(rect.size.height-14)/2, 39, 14)];
    NSString *rankImg=@"";
    if (starNo<=5) {
        rankImg=@"ranklv1-5";
        _rankLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (starNo>5&&starNo<=10){
        rankImg=@"ranklv6-10";
        _rankLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (starNo>10&&starNo<=15){
        rankImg=@"ranklv11-15";
        _rankLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (starNo>15&&starNo<=20){
        rankImg=@"ranklv16-20";
        _rankLab.textColor=[UIColor whiteColor];
    }else if (starNo>20&&starNo<=25){
        rankImg=@"ranklv21-25";
        _rankLab.textColor=[UIColor whiteColor];
    }
    _rankImgView.image=[UIImage imageNamed:rankImg];
    
    _rankLab.text=[NSString stringWithFormat:@"LV%ld",(long)starNo];
    reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)starNo] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_rankLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    _statLab.text=odds;
    if ([odds isEqualToString:@"0中0"]) {
        _statLab.hidden=YES;
        _zhongView.hidden=YES;
    }
    
    _twoSideLab.text=matchSides;
    reSize=[PublicMethod setNameFontSize:matchSides andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=_twoSideLab.frame;
    rect.size.width=reSize.width;
    rect.size.height=reSize.height;
    [_twoSideLab setFrame:rect];
    
    if ([lotype isEqualToString:@"202"]) {
        self.ypImgView.hidden=NO;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5*MyWidth/320, CGRectGetMinY(_twoSideLab.frame)+2.5, 15, 15)];
    }else{
        self.ypImgView.hidden=YES;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5*MyWidth/320, CGRectGetMinY(_twoSideLab.frame)+2.5, 0, 15)];
    }
    
    if(refundOrNo==1){
        self.refundImgView.hidden=NO;
    }
    rect=self.refundImgView.frame;
    rect.origin.x=ORIGIN_X(_ypImgView)+5.5*MyWidth/320;
    [self.refundImgView setFrame:rect];
    
    _timeLab.text=time;
    _leagueTypeLab.text=leagueType;
    
    rect=_priceLab.frame;
    
    if (exPrice==0.0||discount==0.0) {
        _priceLab.text=@"免费";
        CGSize cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.priceLab.frame=CGRectMake(MyWidth-cellUIsize.width-15, rect.origin.y, cellUIsize.width, rect.size.height);
    }else{
        if (discount!=1) {
            _priceLab.text=[NSString stringWithFormat:@"%.2f元",exPrice*discount];
            QFLineLabel * discountPrice=[[QFLineLabel alloc] init];
            discountPrice.text=[NSString stringWithFormat:@"%.2f元",exPrice];
//#ifdef CRAZYSPORTS
//            int jinbibeishu = 10;//金币和钱比例
//            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//                jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//            }
//            _priceLab.text=[NSString stringWithFormat:@"%.0f金币",exPrice*discount * jinbibeishu];
//            discountPrice.text=[NSString stringWithFormat:@"%.0f金币",exPrice * jinbibeishu];
//#endif
            CGSize cellUIsize=[PublicMethod setNameFontSize:discountPrice.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            [discountPrice setFrame:CGRectMake(MyWidth-cellUIsize.width-15, rect.origin.y, cellUIsize.width, rect.size.height)];
            discountPrice.font=FONTTWENTY_FOUR;
            discountPrice.textColor=[UIColor grayColor];
            discountPrice.textAlignment=NSTextAlignmentRight;
            discountPrice.lineType=LineTypeMiddle;
            discountPrice.lineColor=[UIColor grayColor];
            [self.contentView addSubview:discountPrice];
            self.disCountLab=discountPrice;
            
            cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            self.priceLab.frame=CGRectMake(CGRectGetMinX(_disCountLab.frame)-cellUIsize.width-5, rect.origin.y, cellUIsize.width, rect.size.height);
        }else{
            _priceLab.text=[NSString stringWithFormat:@"%.2f元",exPrice];
//#ifdef CRAZYSPORTS
//            int jinbibeishu = 10;//金币和钱比例
//            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
//                jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
//            }
//            _priceLab.text=[NSString stringWithFormat:@"%.0f金币",exPrice * jinbibeishu];
//#endif
            
            
            CGSize cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            self.priceLab.frame=CGRectMake(MyWidth-cellUIsize.width-15, rect.origin.y, cellUIsize.width, rect.size.height);
        }
    }
    
    reSize=[PublicMethod setNameFontSize:leagueType andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=_leagueTypeLab.frame;
    rect.origin.x=CGRectGetMinX(_priceLab.frame)-reSize.width-10;
    rect.size.width=reSize.width;
    [_leagueTypeLab setFrame:rect];
    
    
    _name2.text = name2;
    _league2.text = league2;
    _time2.text = time2;
    
    
    
    rect=_league2.frame;
    rect.origin.x=CGRectGetMinX(_priceLab.frame)-reSize.width-10;
    [_league2 setFrame:rect];
    
    rect=_priceLab.frame;
    rect.origin.y=_league2.frame.origin.y;
    [_priceLab setFrame:rect];
    [self.disCountLab setFrame:CGRectMake(self.disCountLab.frame.origin.x, rect.origin.y, self.disCountLab.frame.size.width, self.disCountLab.frame.size.height)];
    
    if (exRank==0) {
        _markImgView.hidden=NO;
    }else{
        _markImgView.hidden=YES;
    }
    
    _line.frame=CGRectMake(0,58+45*MyWidth/320-0.5+56, MyWidth, 0.5);
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