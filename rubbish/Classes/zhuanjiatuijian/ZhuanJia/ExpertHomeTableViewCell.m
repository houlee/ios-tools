//
//  ExpertHomeTableViewCell.m
//  caibo
//
//  Created by GongHe on 16/8/11.
//
//

#import "ExpertHomeTableViewCell.h"
#import "caiboAppDelegate.h"

@implementation ExpertHomeTableViewCell

+(id)ExpertSuperiorBaseCellWithTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * superiorCellId=@"superior";
    ExpertHomeTableViewCell * cell=[tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[ExpertHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:superiorCellId];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView * headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 45, 45)];//y坐标待定
        [self.contentView addSubview:headImageView];
        headImageView.layer.cornerRadius=22.5;
        headImageView.layer.masksToBounds=YES;
        self.headImgView=headImageView;
        
        UIImageView *markView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(headImageView.frame)+30*MyWidth/320, CGRectGetMinY(headImageView.frame)+30*MyWidth/320, 15*MyWidth/320, 15*MyWidth/320)];
        markView.layer.cornerRadius=7.5*MyWidth/320;
        markView.layer.masksToBounds=YES;
        markView.image=[UIImage imageNamed:@"V_red"];
        [self.contentView addSubview:markView];
        _markImgView=markView;
        
        UILabel * nickName=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, 15, 40, 20)];
        nickName.font=FONTTHIRTY;
        nickName.textColor=RGB(21., 136., 218.);
        [self.contentView addSubview:nickName];
        self.nickNamelab=nickName;
        
        UIImageView *rangImgV=[[UIImageView alloc] initWithFrame:CGRectMake(ORIGIN_X(nickName)+10, 17, 39, 14)];
        rangImgV.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:rangImgV];
        rangImgV.hidden = YES;
        _rankImgView=rangImgV;
        
        UILabel *rankLab=[[UILabel alloc] initWithFrame:CGRectMake(15, 0, 22, 14)];
        rankLab.backgroundColor=[UIColor clearColor];
        rankLab.font=[UIFont systemFontOfSize:8.0];
        rankLab.textColor=RGBColor(255.0, 96.0, 0.0);
        rankLab.textAlignment=NSTextAlignmentLeft;
        [rangImgV addSubview:rankLab];
        rankLab.hidden = YES;
        _rankLab=rankLab;
        
        UILabel * dueOfTwoSides=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, CGRectGetMaxY(nickName.frame)+8, 150, 20)];
        dueOfTwoSides.font=FONTTHIRTY;
        dueOfTwoSides.textColor=[UIColor blackColor];
        dueOfTwoSides.alpha=0.87;
        [self.contentView addSubview:dueOfTwoSides];
        self.twoSideLab=dueOfTwoSides;
        
        UIImageView *ypImgV=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(dueOfTwoSides.frame)+5.5, CGRectGetMinY(dueOfTwoSides.frame)+2.5, 15, 15)];
        ypImgV.image=[UIImage imageNamed:@"yapan"];
        ypImgV.hidden=YES;
        [self.contentView addSubview:ypImgV];
        self.ypImgView=ypImgV;
        
        //状态，5中5
        UIImage * correctImage=[UIImage imageNamed:@"5中5"];
        UIImageView * correctImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MyWidth-correctImage.size.width-15,nickName.frame.origin.y,correctImage.size.width, correctImage.size.height)];
        correctImageView.image=correctImage;
        self.zhongView=correctImageView;
        [self.contentView addSubview:correctImageView];
        
        UILabel * statics=[[UILabel alloc]initWithFrame:CGRectMake(correctImageView.frame.origin.x+5,correctImageView.frame.origin.y, correctImage.size.width-10,correctImage.size.height)];
        self.statLab=statics;
        [self.contentView addSubview:statics];
        statics.textAlignment=NSTextAlignmentCenter;
        statics.font=FONTTHIRTY;
        statics.textColor=RGB(240., 70., 14.);
        statics.backgroundColor=[UIColor clearColor];
        
        UIImageView *refundImgView=[[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(statics.frame)+5.5, CGRectGetMinY(statics.frame)+2.5, 15, 15)];
        refundImgView.image=[UIImage imageNamed:@"refund"];
        refundImgView.hidden=YES;
        [self.contentView addSubview:refundImgView];
        self.refundImgView=refundImgView;
        
        UILabel * time=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(headImageView.frame)+15, CGRectGetMaxY(dueOfTwoSides.frame)+8, 80, 20)];
        time.font=FONTTWENTY_FOUR;
        time.textColor=[UIColor blackColor];
        time.alpha=0.54;
        [self.contentView addSubview:time];
        self.timeLab=time;
        
        //类型
        UILabel * matchType=[[UILabel alloc]initWithFrame:CGRectMake(MyWidth - 15 - 150,time.frame.origin.y, 150, 20)];
        matchType.font=FONTTWENTY_FOUR;
        matchType.textColor=[UIColor blackColor];
        matchType.alpha=0.54;
        matchType.textAlignment = 2;
        [self.contentView addSubview:matchType];
        self.leagueTypeLab=matchType;

        UILabel *price=[[UILabel alloc] initWithFrame:CGRectMake(MyWidth-55, time.frame.origin.y, 40, 20)];
        price.font=FONTTWENTY_FOUR;
        price.textColor=RGB(255., 59., 48.);
        price.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:price];
        price.hidden = YES;
        self.priceLab=price;
        
        //UIImageView * imgStatus=[[UIImageView alloc] initWithFrame:CGRectMake(MyWidth-50.5, 100-82.5, 50.5, 82.5)];
        //imgStatus.hidden=YES;
        //[self.contentView addSubview:imgStatus];
        //_staImgV=imgStatus;
        
        //黑线
        UIView * Line=[[UIView alloc]initWithFrame:CGRectMake(0,99.5, MyWidth, 0.5)];
        [self.contentView addSubview:Line];
        Line.backgroundColor=[UIColor blackColor];
        Line.alpha=0.1;
    }
    return self;
}

/**
 *  填充cell上子控件的数据
 */
-(void)setCellSuperHead:(NSString *)head name:(NSString *)name starNo:(NSInteger)starNo odds:(NSString *)odds matchSides:(NSString *)matchSides time:(NSString *)time leagueType:(NSString *)leagueType exPrice:(float)exPrice exDiscount:(float)discount exRank:(NSInteger)exRank refundOrNo:(NSInteger)refundOrNo flag:(BOOL)flag lotryTp:(NSString *)lotryTp
{
    NSURL *url=[NSURL URLWithString:head];
    [_headImgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    NSString *subString=name;
    if(name.length>4){
        NSRange range=NSMakeRange(0, 4);
        subString=[name substringWithRange:range];
    }
    _nickNamelab.text=subString;
    _nickNamelab.backgroundColor=[UIColor clearColor];
    
    CGSize cellUIsize=[PublicMethod setNameFontSize:subString andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (cellUIsize.width>72.0) {
        self.nickNamelab.frame=CGRectMake(CGRectGetMaxX(self.headImgView.frame)+15, 15,72,cellUIsize.height);
    } else {
        self.nickNamelab.frame=CGRectMake(CGRectGetMaxX(self.headImgView.frame)+15, 15, cellUIsize.width,cellUIsize.height);
    }
    
    [_rankImgView setFrame:CGRectMake(ORIGIN_X(_nickNamelab)+10, 15+(cellUIsize.height-14)/2, 39, 14)];
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
    CGSize reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)starNo] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_rankLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    if (!flag) {
        self.zhongView.hidden=YES;
        self.statLab.hidden=YES;
    } else {
        self.zhongView.hidden=NO;
        self.statLab.hidden=NO;
    }
    
    _statLab.text=odds;
    if ([odds isEqualToString:@"0中0"]||[odds isEqualToString:@"1中0"]) {
        _statLab.hidden=YES;
        _zhongView.hidden=YES;
    }
    
    if (exRank==0) {
        _markImgView.hidden=NO;
    }else{
        _markImgView.hidden=YES;
    }
    
    _twoSideLab.text=matchSides;
    cellUIsize=[PublicMethod setNameFontSize:self.twoSideLab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (cellUIsize.width>=MyWidth-75) {
        self.twoSideLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.nickNamelab.frame)+8, MyWidth-75, cellUIsize.height);
    } else {
        self.twoSideLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.nickNamelab.frame)+8, cellUIsize.width, cellUIsize.height);
    }
    if ([lotryTp isEqualToString:@"202"]) {
        self.ypImgView.hidden=NO;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5, CGRectGetMinY(_twoSideLab.frame)+2.5, 15, 15)];
    }else{
        self.ypImgView.hidden=YES;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5, CGRectGetMinY(_twoSideLab.frame)+2.5, 0, 15)];
    }
    
    [_refundImgView setFrame:CGRectMake(CGRectGetMaxX(self.ypImgView.frame)+5.5, CGRectGetMinY(self.twoSideLab.frame)+2.5, 15, 15)];
    if (refundOrNo==1) {
        _refundImgView.hidden=NO;
    }
    
    _timeLab.text=time;
    cellUIsize=[PublicMethod setNameFontSize:self.timeLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (cellUIsize.width>=136) {
        self.timeLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.twoSideLab.frame)+8, 136, 20);
    } else {
        self.timeLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.twoSideLab.frame)+8, cellUIsize.width, 20);
    }
    
    _leagueTypeLab.text=leagueType;
    
    CGRect rect=_priceLab.frame;
    _priceLab.backgroundColor=[UIColor clearColor];
    
    if(discount==0.00||exPrice==0.00){
#if defined YUCEDI || defined DONGGEQIU
        if ([[caiboAppDelegate getAppDelegate] isShenhe]) {
            _priceLab.hidden = YES;
        }
#endif
        _priceLab.text=@"免费";
        cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.priceLab.frame=CGRectMake(MyWidth-cellUIsize.width-15, _timeLab.frame.origin.y, cellUIsize.width, rect.size.height);
    }else{
        if (discount==1) {
            _priceLab.text=[NSString stringWithFormat:@"%.2f元",exPrice];
#ifdef CRAZYSPORTS
            int jinbibeishu = 10;//金币和钱比例
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
                jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
            }
            _priceLab.text = [NSString stringWithFormat:@"%.0f金币",exPrice * jinbibeishu];
#endif
            cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            self.priceLab.frame=CGRectMake(MyWidth-cellUIsize.width-15, _timeLab.frame.origin.y, cellUIsize.width, rect.size.height);
        }else{
            _priceLab.text=[NSString stringWithFormat:@"%.2f元",exPrice*discount];
            QFLineLabel * discountPrice=[[QFLineLabel alloc] init];
            if(exPrice==0.00){
                discountPrice.text=@"免费";
            }else {
                discountPrice.text=[NSString stringWithFormat:@"%.2f元",exPrice];
            }
#ifdef CRAZYSPORTS
            int jinbibeishu = 10;//金币和钱比例
            if ([[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"]) {
                jinbibeishu = [[[NSUserDefaults standardUserDefaults] valueForKey:@"NsUerintegralRatio"] intValue];
            }
            _priceLab.text=[NSString stringWithFormat:@"%.0f金币",exPrice*discount * jinbibeishu];
            if(exPrice==0.00){
                discountPrice.text=@"免费";
            }else {
                discountPrice.text=[NSString stringWithFormat:@"%.0f金币",exPrice * jinbibeishu];
            }
#endif
            cellUIsize=[PublicMethod setNameFontSize:discountPrice.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            [discountPrice setFrame:CGRectMake(MyWidth-cellUIsize.width-15, _timeLab.frame.origin.y, cellUIsize.width, rect.size.height)];
            discountPrice.font=FONTTWENTY_FOUR;
            discountPrice.textColor=[UIColor grayColor];
            discountPrice.textAlignment=NSTextAlignmentRight;
            discountPrice.lineType=LineTypeMiddle;
            discountPrice.lineColor=[UIColor grayColor];
            discountPrice.backgroundColor=[UIColor clearColor];
            [self.contentView addSubview:discountPrice];
            self.disCountLab=discountPrice;
            self.disCountLab.hidden = YES;
            
            cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            self.priceLab.frame=CGRectMake(CGRectGetMinX(_disCountLab.frame)-cellUIsize.width-5, _timeLab.frame.origin.y, cellUIsize.width, rect.size.height);
        }
    }
    cellUIsize=[PublicMethod setNameFontSize:self.leagueTypeLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    rect=_leagueTypeLab.frame;
    self.leagueTypeLab.frame=CGRectMake(MyWidth - 15 - 150,_timeLab.frame.origin.y, 150, rect.size.height);
    
    //    CGFloat outOfborder=CGRectGetMaxX(self.leagueTypeLab.frame)-self.priceLab.frame.origin.x;
    //    if (CGRectGetMaxX(self.leagueTypeLab.frame)>=MyWidth-47.71) {
    //        self.leagueTypeLab.frame=CGRectMake(CGRectGetMaxX(self.timeLab.frame)+37.5,self.timeLab.frame.origin.y, self.leagueTypeLab.frame.size.width-outOfborder, self.leagueTypeLab.frame.size.height);
    //    }
}

//已购方案
-(void)HeadImageView:(NSString * )HeadImageView vImageView:(NSString *)vImageView nickName:(NSString *)nickName levels:(NSString *)levels statics:(NSString *)statics dueOfTwoSides:(NSString *)dueOfTwoSides time:(NSString *)time price:(NSString *)price flag:(NSString *)flag refundOrNo:(NSInteger)refundOrNo lotryTp:(NSString *)lotryTp
{
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:HeadImageView] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    self.leagueTypeLab.text = @"";
    self.zhongView.hidden = YES;
    self.markImgView.image = [UIImage imageNamed:vImageView];
    self.statLab.textAlignment=NSTextAlignmentRight;
    self.statLab.textColor = BLACK_EIGHTYSEVER;
    self.nickNamelab.text = nickName;
    
    self.nickNamelab.textColor = BLACK_EIGHTYSEVER;
    CGSize cellUIsize=[PublicMethod setNameFontSize:self.nickNamelab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (cellUIsize.width>72.0) {
        self.nickNamelab.frame=CGRectMake(CGRectGetMaxX(self.headImgView.frame)+15, 15,72.0,cellUIsize.height);
    }else{
        self.nickNamelab.frame=CGRectMake(CGRectGetMaxX(self.headImgView.frame)+15, 15, cellUIsize.width,cellUIsize.height);
    }
    
    int level=[levels intValue];
    //int level=arc4random()%5;
    
    [_rankImgView setFrame:CGRectMake(ORIGIN_X(_nickNamelab)+10, 15+(cellUIsize.height-14)/2, 39, 14)];
    NSString *rankImg=@"";
    if (level<=5) {
        rankImg=@"ranklv1-5";
        _rankLab.textColor=[UIColor colorWithRed:181.0/255 green:155.0/255 blue:155.0/255 alpha:1.0];
    }else if (level>5&&level<=10){
        rankImg=@"ranklv6-10";
        _rankLab.textColor=[UIColor colorWithRed:221.0/255 green:145.0/255 blue:85.0/255 alpha:1.0];
    }else if (level>10&&level<=15){
        rankImg=@"ranklv11-15";
        _rankLab.textColor=[UIColor colorWithRed:255.0/255 green:96.0/255 blue:0.0/255 alpha:1.0];
    }else if (level>15&&level<=20){
        rankImg=@"ranklv16-20";
        _rankLab.textColor=[UIColor whiteColor];
    }else if (level>20&&level<=25){
        rankImg=@"ranklv21-25";
        _rankLab.textColor=[UIColor whiteColor];
    }
    _rankImgView.image=[UIImage imageNamed:rankImg];
    _rankLab.text=[NSString stringWithFormat:@"LV%ld",(long)level];
    CGSize reSize=[PublicMethod setNameFontSize:[NSString stringWithFormat:@"LV%ld",(long)level] andFont:[UIFont systemFontOfSize:8.0] andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [_rankLab setFrame:CGRectMake(26-reSize.width/2,7-reSize.height/2,reSize.width,reSize.height)];
    
    //竞彩:主队VS客队/数字彩:双色球 11222期
    if ([flag isEqualToString:@"001"]) {
        self.twoSideLab.text = dueOfTwoSides;
    }else if ([flag isEqualToString:@"002"]) {
        NSString * typeOfQ;
        if ([[dueOfTwoSides substringToIndex:3]isEqualToString:@"001"]) {
            typeOfQ = @"双色球";
        }if ([[dueOfTwoSides substringToIndex:3]isEqualToString:@"002"]) {
            typeOfQ = @"3D";
        }if ([[dueOfTwoSides substringToIndex:3]isEqualToString:@"108"]) {
            typeOfQ = @"排列三";
        }if ([[dueOfTwoSides substringToIndex:3]isEqualToString:@"113"]) {
            typeOfQ = @"大乐透";
        }
        self.twoSideLab.text = [NSString stringWithFormat:@"%@ %@",typeOfQ,[dueOfTwoSides substringFromIndex:4]];
    }
    
    //对决双方@"伯明翰 VS 德比郡";
    cellUIsize=[PublicMethod setNameFontSize:self.twoSideLab.text andFont:FONTTHIRTY andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (cellUIsize.width>=MyWidth-75) {
        self.twoSideLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.nickNamelab.frame)+8, MyWidth-75, cellUIsize.height);
    }else{
        self.twoSideLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.nickNamelab.frame)+8, cellUIsize.width, cellUIsize.height);
    }
    
    if ([lotryTp isEqualToString:@"202"]) {
        self.ypImgView.hidden=NO;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5, CGRectGetMinY(_twoSideLab.frame)+2.5, 15, 15)];
    }else{
        self.ypImgView.hidden=YES;
        [self.ypImgView setFrame:CGRectMake(CGRectGetMaxX(_twoSideLab.frame)+5.5, CGRectGetMinY(_twoSideLab.frame)+2.5, 0, 15)];
    }
    
    [_refundImgView setFrame:CGRectMake(CGRectGetMaxX(self.ypImgView.frame)+5.5, CGRectGetMinY(self.twoSideLab.frame)+2.5, 15, 15)];
    if (refundOrNo==1) {
        _refundImgView.hidden=NO;
    }
    
    //时间
    self.timeLab.text = time;
    cellUIsize=[PublicMethod setNameFontSize:self.timeLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    if (cellUIsize.width>=136) {
        self.timeLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.twoSideLab.frame)+8, 136, cellUIsize.height);
    }else{
        self.timeLab.frame=CGRectMake(self.nickNamelab.frame.origin.x, CGRectGetMaxY(self.twoSideLab.frame)+8, cellUIsize.width, cellUIsize.height);
    }
    
    //赛名英超
    cellUIsize=[PublicMethod setNameFontSize:self.leagueTypeLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.leagueTypeLab.frame=CGRectMake(MyWidth - 15 - 150,self.timeLab.frame.origin.y, 150, cellUIsize.height);
    
    //价格
    self.priceLab.text = price;
    cellUIsize=[PublicMethod setNameFontSize:self.priceLab.text andFont:FONTTWENTY_FOUR andMaxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.priceLab.frame=CGRectMake(MyWidth-cellUIsize.width-20, 85-cellUIsize.height, cellUIsize.width, cellUIsize.height);
    
    CGFloat outOfborder=CGRectGetMaxX(self.leagueTypeLab.frame)-self.priceLab.frame.origin.x;
    if (CGRectGetMaxX(self.leagueTypeLab.frame)>=MyWidth-47.71) {
        self.leagueTypeLab.frame=CGRectMake(MyWidth - 15 - 150,self.timeLab.frame.origin.y, 150, self.leagueTypeLab.frame.size.height);
    }
    //[NSString stringWithFormat:@"%@%@",jgMdl.CLOSE_STATUS,jgMdl.HIT_STATUS]
    self.statLab.text = statics;
    if ([[statics substringToIndex:1]isEqualToString:@"3"]) {
        //_priceLab.frame = CGRectMake(MyWidth-85, _nickNamelab.frame.origin.y,70, 15);
        //_statLab.frame = CGRectZero;
        //_staImgV.hidden=NO;
        if ([[statics substringFromIndex:1] isEqualToString:@"1"]) {
            self.statLab.text = @"荐中";
            self.statLab.textColor = [UIColor colorWithRed:1.0 green:59.0/255.0 blue:48.0/255.0 alpha:1.0];
            //_staImgV.image = [UIImage imageNamed:@"荐中@2x"];
        }else if ([[statics substringFromIndex:1] isEqualToString:@"2"]) {
            self.statLab.text = @"未中";
            //_staImgV.image = [UIImage imageNamed:@"未中@2x"];
            if (refundOrNo==1) {
                self.statLab.text = @"已退款";
            }
        }else if ([[statics substringFromIndex:1] isEqualToString:@"4"]) {
            self.statLab.text = @"走盘";
            if (refundOrNo==1) {
                self.statLab.text = @"已退款";
            }
        }
    }else if (![[statics substringToIndex:1]isEqualToString:@"3"]) {
        self.statLab.text = @"未开";
        //_staImgV.hidden = YES;
    }
    
    self.statLab.frame = CGRectMake(MyWidth - 70,self.zhongView.frame.origin.y, 50,20);
    
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    