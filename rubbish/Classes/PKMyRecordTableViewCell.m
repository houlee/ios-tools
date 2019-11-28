//
//  PKMyRecordTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 15/1/23.
//
//

#import "PKMyRecordTableViewCell.h"

@implementation PKMyRecordTableViewCell

//@synthesize caizhongLab,payLab,moneyLab,statueLab,wanfaLab,qihaoLab,zhongjiangIma;
@synthesize betRecordInfo;
@synthesize hemaiInfo;
@synthesize infoData;
@synthesize cellXian;

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [infoData release];
    [infoListData release];
    [zhuihaoinfo release];
    [hemaiInfo release];
    [betRecordInfo release];
    [super dealloc];
}

- (void)setInfoListData:(zhuiHaoDataInfo *)_infoListData{
    
    if (infoListData != _infoListData) {
        [infoListData release];
        infoListData = [_infoListData retain];
    }
    
    
    
    
    lotteryName.text = infoData.lotteryName;
    minName.text = infoData.playName;
    moneyLabel.text = infoListData.fanganMoney;
    
    lotteryState.text  = infoListData.fangantypeString;
    
    
    
    NSString * str = lotteryName.text;
    UIFont * font = [UIFont systemFontOfSize:14];
    CGSize  size = CGSizeMake(100, 20);
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    lotteryName.frame = CGRectMake(10, 8+2, labelSize.width, 20);
    //    minName.frame = CGRectMake(13+lotteryName.frame.size.width, 9, 80, 20);
    NSString * str1 = minName.text;
    UIFont * font1 = [UIFont systemFontOfSize:14];
    CGSize  size1 = CGSizeMake(80, 20);
    CGSize labelSize1 = [str1 sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:UILineBreakModeWordWrap];
    
    minName.frame = CGRectMake(13+lotteryName.frame.size.width, 9+3, labelSize1.width, 20);
    
    moneyLabel.frame = CGRectMake(13+lotteryName.frame.size.width+minName.frame.size.width+3, 9+2, 165-(13+lotteryName.frame.size.width+minName.frame.size.width+2), 20);
    yuanLabel.frame = CGRectMake(165, 9+2, 15, 20);
    
    if ([infoListData.fanganType intValue] == 1) {
        zhongjiangIamge.hidden = NO;
        
        
        
        //        faimage.hidden = NO;
        //        heimage.hidden = NO;
        //
        
        
        if ([infoListData.awardType intValue] == 0) {
            lotteryState.text = @"等待开奖";
        }else if ([infoListData.awardType intValue] == 1){
            lotteryState.text = @"未中奖";
        }
        
        zhongMoney.frame = CGRectMake(192-10, 8, 60, 20);
        zhongYuan.frame = CGRectMake(255-10, 8, 15, 20);
        zhongYuan.hidden = NO;
        zhongMoney.hidden = NO;
        lotteryState.hidden = YES;
        zhongMoney.text = infoListData.awardAmount;
        NSLog(@"lotterymoney = %@", infoListData.awardAmount);
        
        if ([zhongMoney.text floatValue] > 99999) {
            zhongMoney.hidden = YES;
            zhongYuan.hidden = YES;
            lotteryState.hidden = NO;
            lotteryState.text = @"金额无法显示";
            lotteryState.textColor = [UIColor redColor];
        }else if([zhongMoney.text floatValue] == 0){
            
            zhongMoney.hidden = YES;
            zhongYuan.hidden = YES;
            lotteryState.hidden = NO;
            
        }else{
            lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            lotteryState.hidden = YES;
        }
    }else{
        zhongjiangIamge.hidden = YES;
        zhongMoney.hidden = YES;
        zhongYuan.hidden = YES;
        lotteryState.hidden = NO;
        zhongMoney.text = @"";
        lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
    issueLabel.text = infoListData.lotteryIssue;
    
    
    
    
    
    if ([infoListData.awardAmount intValue] > 0) {
        zhongjiangIamge.hidden = NO;
    }else{
        zhongjiangIamge.hidden = YES;
    }
    
    if ([infoListData.secrecyType intValue] == 1) {
        suoImage.frame = CGRectMake(33, 34+10+1, 15, 16);
        suoImage.hidden = NO;
    }
    
    
    zhuiImge.frame = CGRectMake(33+18, 34+11, 15, 16);
    zhuiImge.hidden = NO;
    
    
}

- (zhuiHaoDataInfo *)infoListData{
    
    return infoListData;
}




// 追号
- (void)setZhuihaoinfo:(zhuiHaoDataInfo *)_zhuihaoinfo{
    
    if (zhuihaoinfo != _zhuihaoinfo) {
        [zhuihaoinfo release];
        zhuihaoinfo = [_zhuihaoinfo retain];
    }
    
    scheduleImage.hidden = NO;
    shengyinimageUp.hidden = NO;
    percentageLabel.hidden = NO;
    //    awardAmount.hidden = NO;
    issueLabel.frame = CGRectMake(180, 35+8, 90, 20);
    lotteryName.text = zhuihaoinfo.lotteryName;
    minName.text = zhuihaoinfo.playName;
    moneyLabel.text = [NSString stringWithFormat:@"%@",zhuihaoinfo.betAmount];
    
    
    
    
    lotteryState.text  = zhuihaoinfo.lotteryIssue;
    NSString * str = lotteryName.text;
    UIFont * font = [UIFont systemFontOfSize:14];
    CGSize  size = CGSizeMake(100, 20);
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    lotteryName.frame = CGRectMake(10, 8+2, labelSize.width, 20);
    //    minName.frame = CGRectMake(13+lotteryName.frame.size.width, 9, 80, 20);
    NSString * str1 = minName.text;
    UIFont * font1 = [UIFont systemFontOfSize:14];
    CGSize  size1 = CGSizeMake(80, 20);
    CGSize labelSize1 = [str1 sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:UILineBreakModeWordWrap];
    
    minName.frame = CGRectMake(13+lotteryName.frame.size.width, 9+3, labelSize1.width, 20);
    
    moneyLabel.frame = CGRectMake(13+lotteryName.frame.size.width+minName.frame.size.width+3, 9+2, 165-(13+lotteryName.frame.size.width+minName.frame.size.width+2), 20);
    yuanLabel.frame = CGRectMake(165, 9+2, 15, 20);
    
    
    if ([zhuihaoinfo.yuliu intValue] == 2) {
        zhongjiangIamge.hidden = NO;
        
        zhongMoney.frame = CGRectMake(192-10, 8, 60, 20);
        zhongYuan.frame = CGRectMake(255-10, 8, 15, 20);
        zhongYuan.hidden = NO;
        zhongMoney.hidden = NO;
        lotteryState.hidden = YES;
        zhongMoney.text = zhuihaoinfo.awardAmount;
        
        
        NSLog(@"lotterymoney = %@", zhuihaoinfo.awardAmount);
        
        if ([zhongMoney.text floatValue] > 99999) {
            zhongMoney.hidden = YES;
            zhongYuan.hidden = YES;
            lotteryState.hidden = NO;
            lotteryState.text = @"金额无法显示";
            lotteryState.textColor = [UIColor redColor];
        }else if([zhongMoney.text floatValue] == 0){
            
            zhongMoney.hidden = YES;
            zhongYuan.hidden = YES;
            lotteryState.hidden = NO;
            
        }else{
            lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            lotteryState.hidden = YES;
        }
    }else{
        zhongjiangIamge.hidden = YES;
        zhongMoney.hidden = YES;
        zhongYuan.hidden = YES;
        lotteryState.hidden = NO;
        zhongMoney.text = @"";
        lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
    if (zhuihaoinfo.zhuiHaoSet == 0) {
        issueLabel.text = @"中奖后停追";
    }
    //    else if(zhuihaoinfo.zhuiHaoSet == 1){
    //        issueLabel.text = @"中奖后继续";
    //    }else if(zhuihaoinfo.zhuiHaoSet == 2){
    //        issueLabel.text = [NSString stringWithFormat:@"中奖金额大于%@停止", zhuihaoinfo.stopAmount];
    //    }
    else{
        issueLabel.text = @"";
    }
    if ([zhuihaoinfo.yuliu intValue] == 2) {
        zhongjiangIamge.hidden = NO;
    }else{
        zhongjiangIamge.hidden = YES;
    }
    
    zhuiImge.frame = CGRectMake(33, 34+11, 15, 16);
    zhuiImge.hidden = NO;
    
    percentageLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)zhuihaoinfo.yiZhuiIssue, (long)zhuihaoinfo.zhuiHaoIssue];
    NSString * a = [NSString stringWithFormat:@"%ld", (long)zhuihaoinfo.yiZhuiIssue];
    NSString * b = [NSString stringWithFormat:@"%ld", (long)zhuihaoinfo.zhuiHaoIssue];
    
    float width = [a floatValue]/[b floatValue];
    NSLog(@"hahahahahhahahhahahahahhahahahhaha = %f", width);
    width = scheduleImage.frame.size.width * width;
    NSLog(@"hahahahahhahahhahahahahhahahahhaha = %f", width);
    shengyinimageUp.frame = CGRectMake(shengyinimageUp.frame.origin.x, shengyinimageUp.frame.origin.y, width, shengyinimageUp.frame.size.height);
    //     shengyinimageUp.image = [UIImageGetImageFromName(@"jindutiaoup.png") stretchableImageWithLeftCapWidth:4 topCapHeight:2];
    //    if (zhuihaoinfo.awardIssue > 0) {
    //        awardAmount.hidden = NO;
    //        awardAmount.text = [NSString stringWithFormat:@"中%d期", zhuihaoinfo.awardIssue];
    //    }
    
}

- (zhuiHaoDataInfo *)zhuihaoinfo{
    
    return zhuihaoinfo;
}


- (void)LoadData:(BetRecordInfor *)info {
    isHemai = NO;
    self.betRecordInfo = info;
    
    
    lotteryName.text = info.lotteryName;
    minName.text = info.mode;
    
    if ([info.mode isEqualToString:@"-"]) {
        minName.text = nil;
    }
    
    if ([info.issue length]>4) {
        if ([info.lotteryName isEqualToString:@"双色球"] || [info.lotteryName isEqualToString:@"7乐彩"] || [info.lotteryName isEqualToString:@"3D"]) {
            NSString * issuestr = [info.issue substringWithRange:NSMakeRange(2, [info.issue length]-2)];
            issueLabel.text = [NSString stringWithFormat:@"%@期",issuestr];
        }else{
            issueLabel.text = [NSString stringWithFormat:@"%@期",info.issue];
        }
        
    }
    else {
        issueLabel.text = nil;
    }
    
    float i = [info.lotteryMoney integerValue];
    NSString * programString = @"";
    if ([info.programState isEqualToString:@"1"]) {
        if ([info.awardState isEqualToString:@"等待开奖"]) {
            programString = @"等待开奖";
//        }else if([info.awardState isEqualToString:@"未中奖"] || (i == 0)){
            }else if(i == 0){
            programString = @"未中奖";
            
//        }else if([info.awardState isEqualToString:@"中奖"] || (i > 0)){
                }else if(i > 0){
            programString = @"中奖";
        }else if ([info.awardState isEqualToString:@"等待派奖"]) {
            programString = @"等待派奖";
        }
    }else{
        
        if ([info.programState isEqualToString:@"0"]) {
            programString = @"未出票";
            
        }else if([info.programState isEqualToString:@"1"]){
            programString = @"出票成功";
        }else if([info.programState isEqualToString:@"2"]){
            programString = @"出票失败";
        }else if([info.programState isEqualToString:@"3"]){
            programString = @"部分成功";
        }else if([info.programState isEqualToString:@"4"]){
            programString = @"已撤销";
        }else if([info.programState isEqualToString:@"5"]){
            programString = @"流单";
        }else if([info.programState isEqualToString:@"6"]){
            programString = @"扣款失败";
        }else if ([info.programState isEqualToString:@"7"]){
            programString = @"撤资";
        }
    }
    
    
    lotteryState.text = programString;
    
    
    //    issueLabel.text = [NSString stringWithFormat:@"%@期",info.issue];
//    moneyLabel.text = info.betAmount;
    moneyLabel.text = [NSString stringWithFormat:@"%@",info.betAmount];
    
    
    
    NSString * str = lotteryName.text;
    UIFont * font = [UIFont systemFontOfSize:14];
    CGSize  size = CGSizeMake(100, 20);
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    lotteryName.frame = CGRectMake(10, 8+2, labelSize.width, 20);
    //    minName.frame = CGRectMake(13+lotteryName.frame.size.width, 9, 80, 20);
    NSString * str1 = minName.text;
    UIFont * font1 = [UIFont systemFontOfSize:14];
    CGSize  size1 = CGSizeMake(80, 20);
    CGSize labelSize1 = [str1 sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:UILineBreakModeWordWrap];
    
    minName.frame = CGRectMake(13+lotteryName.frame.size.width, 9+3, labelSize1.width, 20);
    
    moneyLabel.frame = CGRectMake(13+lotteryName.frame.size.width+minName.frame.size.width+3, 9+2, 165-(13+lotteryName.frame.size.width+minName.frame.size.width+2), 20);
    NSString * xuin = info.betAmount;
    UIFont * fxuniFont = [UIFont systemFontOfSize:14];
    CGSize  xuniSize = CGSizeMake(100, 20);
    CGSize xuniLabelSize = [xuin sizeWithFont:fxuniFont constrainedToSize:xuniSize lineBreakMode:UILineBreakModeWordWrap];
    lotteryName.frame = CGRectMake(10, 8+2, labelSize.width, 20);
    xuniLab.frame = CGRectMake(13 - xuniLabelSize.width, 0, 80, 20);
    yuanLabel.frame = CGRectMake(165, 9+2, 15, 20);
    
    
//    if (([info.awardState isEqualToString:@"中奖"] && [info.programState isEqualToString:@"1"]) || (i > 0)) {
    if (i > 0 && [info.programState isEqualToString:@"1"]) {
        zhongjiangIamge.hidden = NO;
        
        zhongMoney.frame = CGRectMake(192, 8, 60, 20);
        zhongYuan.frame = CGRectMake(255, 8, 15, 20);
        zhongYuan.hidden = NO;
        zhongMoney.hidden = NO;
        lotteryState.hidden = YES;
        zhongMoney.text = info.lotteryMoney;
        NSLog(@"lotterymoney = %@", info.lotteryMoney);
        
        if ([zhongMoney.text floatValue] > 99999) {
            zhongMoney.hidden = YES;
            zhongYuan.hidden = YES;
            lotteryState.hidden = NO;
            lotteryState.text = @"金额无法显示";
            lotteryState.textColor = [UIColor redColor];
        }else{
            lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            lotteryState.hidden = YES;
        }
    }else{
        zhongjiangIamge.hidden = YES;
        zhongMoney.hidden = YES;
        zhongYuan.hidden = YES;
        lotteryState.hidden = NO;
        zhongMoney.text = @"";
        lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
    NSInteger count = 33;
    if ([info.baomiType isEqualToString:@"1"]) {
        suoImage.frame = CGRectMake(count, 34+10+1, 15, 16);
        suoImage.hidden = NO;
        count += 18;
    }else{
        suoImage.hidden = YES;
    }
    
    if ([info.baodistr isEqualToString:@"1"]) {
        baodiImage.frame = CGRectMake(count, 34+11, 15, 16);
        baodiImage.hidden = NO;
        count += 18;
    }else{
        baodiImage.hidden = YES;
    }
    
    
    
    if ([info.buyStyle rangeOfString:@"合买"].location != NSNotFound) {
        heimage.frame = CGRectMake(count, 34+11, 15, 16);
        heimage.hidden = NO;
        count += 18;
    }else{
        heimage.hidden = YES;
    }
    
    if ([info.buyStyle isEqualToString:@"追号"]) {
        zhuiImge.frame = CGRectMake(count, 34+11, 15, 16);
        zhuiImge.hidden = NO;
        count += 18;
    }else{
        
        zhuiImge.hidden = YES;
        
    }
    if (info.voiceLeng > 0) {
        miaoshuLabel.text = [NSString stringWithFormat:@"%ld\"", (long)info.voiceLeng];
        NSString * str22 = miaoshuLabel.text;
        UIFont * font22 = [UIFont systemFontOfSize:12];
        CGSize  size22 = CGSizeMake(40, 15);
        CGSize labelSize22 = [str22 sizeWithFont:font22 constrainedToSize:size22 lineBreakMode:UILineBreakModeWordWrap];
        
        
        shengyinimage.frame = CGRectMake(count, 34, 15+labelSize22.width, 16);
        shengyinimage.hidden = NO;
        miaoshuLabel.frame = CGRectMake(15, 0, labelSize22.width, 15);
        miaoshuLabel.hidden = NO;
        miaoshuLabel.text = [NSString stringWithFormat:@"%ld\"", (long)info.voiceLeng];
    }else{
        miaoshuLabel.hidden = YES;
        miaoshuLabel.text = @"";
        shengyinimage.hidden = YES;
    }
    
    //领取奖励
    if ([info.lingquJiangli isEqualToString:@"1"]) {
        JLimage.hidden = NO;
        JLimage.frame = CGRectMake(count, 34, 15, 16);
    }else {
        
        JLimage.hidden = YES;
    }
    
}

- (void)LoadHemaiData:(BetHeRecordInfor *)info {
    isHemai = YES;
    self.hemaiInfo = info;
    lotteryName.text = info.lotteryName;
    minName.text = info.mode;
    if ([info.mode isEqualToString:@"-"]) {
        minName.text = nil;
    }
    
    //    issueLabel.text = [NSString stringWithFormat:@"%@期",info.issue];
    if ([info.issue length]>4) {
        if ([info.lotteryName isEqualToString:@"双色球"] || [info.lotteryName isEqualToString:@"7乐彩"] || [info.lotteryName isEqualToString:@"3D"]) {
            NSString * issuestr = [info.issue substringWithRange:NSMakeRange(2, [info.issue length]-2)];
            issueLabel.text = [NSString stringWithFormat:@"%@期",issuestr];
        }else{
            issueLabel.text = [NSString stringWithFormat:@"%@期",info.issue];
        }
    }
    else {
        issueLabel.text = nil;
    }
    moneyLabel.text = info.betAmount;
    
    //    if ([info.programState isEqualToString:@"流标"]) {
    //		lotteryState.text = info.programState;
    //	}
    //	else if ([info.awardState isEqualToString:@"等待开奖"]&&![info.programState isEqualToString:@"已出票"]) {
    //		lotteryState.text = info.programState;
    //	}
    //	else {
    //		lotteryState.text = info.awardState;
    //	}
    NSString * programString = @"";
    if ([info.programState isEqualToString:@"1"]) {
        if ([info.awardState isEqualToString:@"0"]) {
            programString = @"等待开奖";
        }else if([info.awardState isEqualToString:@"1"]){
            programString = @"未中奖";
            
        }else if([info.awardState isEqualToString:@"2"]){
            programString = @"中奖";
        }
    }else{
        
        if ([info.programState isEqualToString:@"0"]) {
            programString = @"未出票";
            
        }else if([info.programState isEqualToString:@"1"]){
            programString = @"出票成功";
        }else if([info.programState isEqualToString:@"2"]){
            programString = @"出票失败";
        }else if([info.programState isEqualToString:@"3"]){
            programString = @"部分成功";
        }else if([info.programState isEqualToString:@"4"]){
            programString = @"已撤销";
        }else if([info.programState isEqualToString:@"5"]){
            programString = @"流单";
        }else if([info.programState isEqualToString:@"6"]){
            programString = @"扣款失败";
        }
    }
    
    
    lotteryState.text = programString;
    
    NSString * str = lotteryName.text;
    UIFont * font = [UIFont systemFontOfSize:14];
    CGSize  size = CGSizeMake(100, 20);
    CGSize labelSize = [str sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    lotteryName.frame = CGRectMake(10, 8+2, labelSize.width, 20);
    
    
    NSString * str1 = minName.text;
    UIFont * font1 = [UIFont systemFontOfSize:14];
    CGSize  size1 = CGSizeMake(80, 20);
    CGSize labelSize1 = [str1 sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:UILineBreakModeWordWrap];
    
    minName.frame = CGRectMake(13+lotteryName.frame.size.width, 9+3, labelSize1.width, 20);
    
    
    moneyLabel.frame = CGRectMake(13+lotteryName.frame.size.width+minName.frame.size.width+3, 9+2, 165-(13+lotteryName.frame.size.width+minName.frame.size.width+3+2), 20);
    yuanLabel.frame = CGRectMake(165, 9+2, 15, 20);
    
    if ([info.awardState isEqualToString:@"2"]&&[info.programState isEqualToString:@"1"]) {
        zhongjiangIamge.hidden = NO;
        
        zhongMoney.hidden = NO;
        zhongYuan.hidden = NO;
        zhongMoney.frame = CGRectMake(192-10, 8, 60, 20);
        zhongYuan.frame = CGRectMake(255-10, 8, 15, 20);
        lotteryState.hidden = YES;
        zhongMoney.text = info.lotteryMoney;
        if ([zhongMoney.text floatValue] > 99999) {
            zhongMoney.hidden = YES;
            zhongYuan.hidden = YES;
            lotteryState.hidden = NO;
            lotteryState.text = @"金额无法显示";
            lotteryState.textColor = [UIColor redColor];
        }else{
            lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
            lotteryState.hidden = YES;
        }
    }else{
        zhongjiangIamge.hidden = YES;
        zhongYuan.hidden = YES;
        zhongMoney.hidden = YES;
        lotteryState.hidden = NO;
        lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    }
    
    NSInteger count = 33;
    if ([info.baomiType isEqualToString:@"1"]) {
        suoImage.frame = CGRectMake(count, 34+10+1, 15, 16);
        suoImage.hidden = NO;
        count += 18;
    }else{
        suoImage.hidden = YES;
    }
    
    if ([info.baodistr isEqualToString:@"1"]) {
        baodiImage.frame = CGRectMake(count, 34+11, 15, 16);
        baodiImage.hidden = NO;
        count += 18;
    }else{
        baodiImage.hidden = YES;
    }
    
    if ([info.betStyle isEqualToString:@"0"]) {
        faimage.hidden = NO;
        faimage.frame = CGRectMake(count, 34+11, 15, 16);
        count += 18;
    }
    else {
        faimage.hidden = YES;
    }
    
    if (info.voiceLeng > 0) {
        miaoshuLabel.text = [NSString stringWithFormat:@"%ld\"", (long)info.voiceLeng];
        NSString * str22 = miaoshuLabel.text;
        UIFont * font22 = [UIFont systemFontOfSize:12];
        CGSize  size22 = CGSizeMake(40, 15);
        CGSize labelSize22 = [str22 sizeWithFont:font22 constrainedToSize:size22 lineBreakMode:UILineBreakModeWordWrap];
        
        
        shengyinimage.frame = CGRectMake(count, 34, 15+labelSize22.width, 16);
        shengyinimage.hidden = NO;
        miaoshuLabel.frame = CGRectMake(15, 0, labelSize22.width, 15);
        miaoshuLabel.hidden = NO;
        
    }else{
        miaoshuLabel.hidden = YES;
        miaoshuLabel.text = @"";
        shengyinimage.hidden = YES;
    }
    
    
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndex:(NSIndexPath *)lotteryIndex withCellCount:(NSInteger)countCell
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // self.selectedBackgroundView = UITableViewCellSelectionStyleNone;
        
        
        // cell里面的图片
        UIImageView * cellbgimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 76)];
        cellbgimage.backgroundColor = [UIColor whiteColor];
        cellbgimage.userInteractionEnabled = YES;
        //  cellbgimage.image = [UIImageGetImageFromName(@"LBT960.png") stretchableImageWithLeftCapWidth:160 topCapHeight:6];
        [self.contentView addSubview:cellbgimage];
        [cellbgimage release];
        
        
        
        //彩票名
        lotteryName = [[UILabel alloc] initWithFrame:CGRectMake(15, 0+2, 0, 0)];
        lotteryName.font = [UIFont systemFontOfSize:14];
        lotteryName.textAlignment = NSTextAlignmentLeft;
        lotteryName.backgroundColor = [UIColor clearColor];
        [cellbgimage addSubview:lotteryName];
        [lotteryName release];
        
        
        UILabel *pkLab = [[UILabel alloc]init];
        pkLab.frame = CGRectMake(10, 45, 100, 20);
        pkLab.backgroundColor = [UIColor clearColor];
        pkLab.font = [UIFont systemFontOfSize:12];
        pkLab.text = @"PK赛胜平负";
        [cellbgimage addSubview:pkLab];
        [pkLab release];
        
        
        //彩票的分种名
        minName = [[UILabel alloc] initWithFrame:CGRectMake(0, 15+1+2, 60, 22)];
        minName.font = [UIFont systemFontOfSize:11];
        minName.textAlignment = NSTextAlignmentLeft;
        minName.backgroundColor = [UIColor clearColor];
        minName.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [cellbgimage addSubview:minName];
        [minName release];
        
        
        //投入的钱数
        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 15+2, 0, 0)];
        moneyLabel.font = [UIFont systemFontOfSize:14];
        moneyLabel.textAlignment = NSTextAlignmentRight;
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textColor = [UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1];
        [cellbgimage addSubview:moneyLabel];
        [moneyLabel release];
        
        xuniLab = [[UILabel alloc]init];
        xuniLab.frame = CGRectMake(140, 15+2, 0, 0);
        xuniLab.backgroundColor = [UIColor clearColor];
        xuniLab.textAlignment = NSTextAlignmentRight;
        xuniLab.font = [UIFont systemFontOfSize:14];
        xuniLab.text = @"虚拟花费";
        xuniLab.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [moneyLabel addSubview:xuniLab];
        [xuniLab release];
        
        
        yuanLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 15+2, 0, 0)];
        yuanLabel.font = [UIFont systemFontOfSize:12];
        yuanLabel.textAlignment = NSTextAlignmentRight;
        yuanLabel.backgroundColor = [UIColor clearColor];
        yuanLabel.text = @"元";
        yuanLabel.textColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
        [cellbgimage addSubview:yuanLabel];
        [yuanLabel release];
        
        
        
        //彩票的状态
        lotteryState = [[UILabel alloc] initWithFrame:CGRectMake(180, 15-5, 90, 20)];
        lotteryState.font = [UIFont systemFontOfSize:14];
        lotteryState.textAlignment = NSTextAlignmentRight;
        lotteryState.backgroundColor = [UIColor clearColor];
        lotteryState.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
        [cellbgimage addSubview:lotteryState];
        [lotteryState release];
        
        
        
        //中奖钱数
        zhongMoney = [[UILabel alloc] initWithFrame:CGRectMake(180-10, 15, 0, 0)];
        zhongMoney.font = [UIFont systemFontOfSize:12];
        zhongMoney.textAlignment = NSTextAlignmentRight;
        zhongMoney.textColor = [UIColor colorWithRed:255.0/255.0 green:59.0/255.0 blue:48.0/255.0 alpha:1];
        zhongMoney.backgroundColor = [UIColor clearColor];
        zhongMoney.textColor = [UIColor redColor];
        [cellbgimage addSubview:zhongMoney];
        [zhongMoney release];
        
        zhongYuan = [[UILabel alloc] initWithFrame:CGRectMake(180-10, 6, 0, 0)];
        zhongYuan.font = [UIFont systemFontOfSize:12];
        zhongYuan.textAlignment = NSTextAlignmentLeft;
        zhongYuan.backgroundColor = [UIColor clearColor];
        zhongYuan.text = @"元";
        zhongYuan.textColor = [UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
//        zhongYuan.textColor = [UIColor colorWithRed:181.0/255.0 green:181.0/255.0 blue:181.0/255.0 alpha:1];
        
        [cellbgimage addSubview:zhongYuan];
        [zhongYuan release];
        
        
        
        
        //期号的label
        issueLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 45, 90, 20)];
        issueLabel.font = [UIFont systemFontOfSize: 12];
        issueLabel.textAlignment = NSTextAlignmentRight;
        issueLabel.backgroundColor = [UIColor clearColor];
        issueLabel.textColor = [UIColor colorWithRed:124.0/255.0 green:124.0/255.0 blue:124.0/255.0 alpha:1];
        [cellbgimage addSubview:issueLabel];
        [issueLabel release];
        
        
        
        //中奖image  ILX-960.png
        zhongjiangIamge = [[UIImageView alloc] initWithFrame:CGRectMake(80, 47, 15, 16)];
        zhongjiangIamge.image = UIImageGetImageFromName(@"jiang_1.png");
        zhongjiangIamge.backgroundColor = [UIColor clearColor];
        zhongjiangIamge.hidden = YES;
        [cellbgimage addSubview:zhongjiangIamge];
        [zhongjiangIamge release];
        
        
        
        //锁   ILS-960.png
        suoImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 45+10+1, 15, 16)];
        //        suoImage.image = UIImageGetImageFromName(@"suo_1.png");
        suoImage.backgroundColor = [UIColor clearColor];
        suoImage.hidden = YES;
        [cellbgimage addSubview:suoImage];
        [suoImage release];
        
        
        
        
        //发   ILF-960.png
        faimage = [[UIImageView alloc] initWithFrame:CGRectMake(53, 45+10, 15, 16)];
        //        faimage.image = UIImageGetImageFromName(@"fa_1.png");
        faimage.backgroundColor = [UIColor clearColor];
        faimage.hidden = YES;
        [cellbgimage addSubview:faimage];
        [faimage release];
        
        
        //合   ILH-960.png (71, 45+10, 15, 16)
        heimage = [[UIImageView alloc] initWithFrame:CGRectMake(78/2, 45+10, 15, 16)];
        //        heimage.image = UIImageGetImageFromName(@"he_1.png");
        heimage.backgroundColor = [UIColor clearColor];
        heimage.hidden = YES;
        [cellbgimage addSubview:heimage];
        [heimage release];
        
        //奖 JLicon960
        JLimage = [[UIImageView alloc] initWithFrame:CGRectMake(78/2, 45+10, 15, 16)];
        //        JLimage.image = UIImageGetImageFromName(@"jiang_2.png");
        JLimage.backgroundColor = [UIColor clearColor];
        JLimage.hidden = YES;
        [cellbgimage addSubview:JLimage];
        [JLimage release];
        
        //追 CGRectMake(71, 45+10, 15, 16)
        zhuiImge = [[UIImageView alloc] initWithFrame:CGRectMake(78/2, 45+10, 15, 16)];
        //        zhuiImge.image = UIImageGetImageFromName(@"zhui_1.png");
        zhuiImge.backgroundColor = [UIColor clearColor];
        zhuiImge.hidden = YES;
        [cellbgimage addSubview:zhuiImge];
        [zhuiImge release];
        
        // 保定
        // ILB-960
        baodiImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45+12, 16, 16)];
        baodiImage.backgroundColor = [UIColor clearColor];
        baodiImage.hidden = YES;
        //        baodiImage.image = UIImageGetImageFromName(@"bao1_1.png");
        [cellbgimage addSubview:baodiImage];
        [baodiImage release];
        
        shengyinimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45+10, 0, 0)];
        //        shengyinimage.image = [UIImageGetImageFromName(@"shenghemiao.png") stretchableImageWithLeftCapWidth:15 topCapHeight:7];
        shengyinimage.backgroundColor = [UIColor clearColor];
        shengyinimage.hidden = YES;
        [cellbgimage addSubview:shengyinimage];
        [shengyinimage release];
        
        
        // 描述
        miaoshuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 45+10, 0, 0)];
        miaoshuLabel.hidden = YES;
        miaoshuLabel.textAlignment = NSTextAlignmentLeft;
        miaoshuLabel.backgroundColor= [UIColor clearColor];
        miaoshuLabel.textColor = [UIColor whiteColor];
        miaoshuLabel.font = [UIFont systemFontOfSize:12];
        [shengyinimage addSubview:miaoshuLabel];
        [miaoshuLabel release];
        
        
        //箭头
        UIImageView * jiantou = [[UIImageView alloc] initWithFrame:CGRectMake(280, 31, 8, 13)];
        // JTD960
        jiantou.image = UIImageGetImageFromName(@"jiantou_1.png");
        jiantou.backgroundColor = [UIColor clearColor];
        [cellbgimage addSubview:jiantou];
        [jiantou release];
        
        
        percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 30, 64, 22)];
        percentageLabel.frame  = CGRectMake(172, 40+1, 40, 22);
        percentageLabel.backgroundColor = [UIColor clearColor];
        percentageLabel.textAlignment = NSTextAlignmentLeft;
        percentageLabel.font = [UIFont systemFontOfSize:10];
        percentageLabel.hidden = YES;
        percentageLabel.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
        [cellbgimage addSubview:percentageLabel];
        [percentageLabel release];
        
        
        //
        scheduleImage = [[UIImageView alloc] initWithFrame:CGRectMake(80, 48+4, 90, 4)];
        scheduleImage.backgroundColor = [UIColor clearColor];
        scheduleImage.image = UIImageGetImageFromName(@"scheduleImagedi.png");
        scheduleImage.hidden = YES;
        [cellbgimage addSubview:scheduleImage];
        [scheduleImage release];
        
        shengyinimageUp = [[UIImageView alloc] initWithFrame:CGRectMake(80, 48+4, 0, 4)];
        shengyinimageUp.backgroundColor = [UIColor clearColor];
        shengyinimageUp.image = [UIImageGetImageFromName(@"jindutiaoup.png") stretchableImageWithLeftCapWidth:2 topCapHeight:1];
        shengyinimageUp.hidden = YES;
        [cellbgimage addSubview:shengyinimageUp];
        [shengyinimageUp release];
        
        
        
        // WithFrame:CGRectMake(13, 76, 320, 0.5)
        cellXian = [[[UIView alloc] init] autorelease];
        cellXian.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        [cellbgimage addSubview:cellXian];
        
        
        
        // 线
        //        if (lotteryIndex.row == 0) {
        //
        //            UIView *cellXian1 = [[[UIView alloc] init] autorelease];
        //            cellXian1.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:1];
        //            [cellbgimage addSubview:cellXian1];
        //            // cellXian.frame = CGRectMake(15, 0, 305, 0.5);
        //            cellXian.frame = CGRectMake(13, 75, 320, 0.5);
        //        }
        //        else if (lotteryIndex.row == countCell - 1) {
        //
        //            cellXian.frame = CGRectMake(0, 75, 320, 0.5);
        //
        //        }else
        //        {
        //            cellXian.frame = CGRectMake(13, 75, 305, 0.5);
        //        }
        
        
        if (lotteryIndex.row ==countCell -1) {
            cellXian.frame = CGRectMake(0, 75, 320, 0.5);
            
        }else{
            cellXian.frame = CGRectMake(13, 75, 305, 0.5);
            
            
        }
        
        
        
        
    }
    return self;
}
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//        self.backgroundColor = [UIColor whiteColor];
//
//        caizhongLab = [[UILabel alloc]init];
//        caizhongLab.frame = CGRectMake(15, 10, 80, 28);
//        caizhongLab.backgroundColor = [UIColor clearColor];
//        caizhongLab.font = [UIFont systemFontOfSize:16];
//        caizhongLab.textColor = [UIColor blackColor];
//        [self.contentView addSubview:caizhongLab];
//        [caizhongLab release];
////        payLab = [[ColorView alloc]init];
////        payLab.frame = CGRectMake(100, 10, 110, 28);
//        payLab = [[ColorView alloc]initWithFrame:CGRectMake(100, 17, 110, 14)];
//        payLab.backgroundColor = [UIColor clearColor];
//        payLab.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
//        payLab.changeColor = [UIColor colorWithRed:25/255.0 green:122/255.0 blue:228/255.0 alpha:1];
//        payLab.font = [UIFont systemFontOfSize:13];
//        [self.contentView addSubview:payLab];
//        [payLab release];
//        moneyLab = [[UILabel alloc]init];
//        moneyLab.frame = CGRectMake(210, 10, 55, 28);
//        moneyLab.backgroundColor = [UIColor clearColor];
//        moneyLab.textColor = [UIColor redColor];
//        moneyLab.font = [UIFont systemFontOfSize:13];
//        moneyLab.textAlignment = NSTextAlignmentRight;
//        [self.contentView addSubview:moneyLab];
//        [moneyLab release];
//        statueLab = [[UILabel alloc]init];
//        statueLab.frame = CGRectMake(210, 10, 70, 28);
//        statueLab.backgroundColor = [UIColor clearColor];
//        statueLab.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
//        statueLab.textAlignment = NSTextAlignmentRight;
//        statueLab.font = [UIFont systemFontOfSize:13];
//        [self.contentView addSubview:statueLab];
//        [statueLab release];
//        wanfaLab = [[UILabel alloc]init];
//        wanfaLab.frame = CGRectMake(15, 40, 100, 28);
//        wanfaLab.backgroundColor = [UIColor clearColor];
//        wanfaLab.font = [UIFont systemFontOfSize:13];
//        wanfaLab.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
//        [self.contentView addSubview:wanfaLab];
//        [wanfaLab release];
//        zhongjiangIma = [[UIImageView alloc]init];
//        zhongjiangIma.frame = CGRectMake(90, 46.5, 15, 15);
//        zhongjiangIma.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:zhongjiangIma];
//        [zhongjiangIma release];
//        qihaoLab = [[UILabel alloc]init];
//        qihaoLab.frame = CGRectMake(160, 40, 120, 28);
//        qihaoLab.backgroundColor = [UIColor clearColor];
//        qihaoLab.textAlignment = NSTextAlignmentRight;
//        qihaoLab.textColor = [UIColor colorWithRed:124/255.0 green:124/255.0 blue:124/255.0 alpha:1];
//        qihaoLab.font = [UIFont systemFontOfSize:13];
//        [self.contentView addSubview:qihaoLab];
//        [qihaoLab release];
//
//        UIImageView *lineIma = [[UIImageView alloc]init];
//        lineIma.frame = CGRectMake(0, 75.5, self.contentView.frame.size.width, 0.5);
//        lineIma.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
//        [self.contentView addSubview:lineIma];
//        [lineIma release];
//
//        UIImageView *jiantouIma = [[UIImageView alloc]init];
//        jiantouIma.frame = CGRectMake(self.contentView.frame.size.width - 15 - 12.5, 31.5, 8, 12.5);
//        jiantouIma.image = [UIImage imageNamed:@"chongzhijian.png"];
//        jiantouIma.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:jiantouIma];
//        [jiantouIma release];
//
//
//    }
//    return self;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    