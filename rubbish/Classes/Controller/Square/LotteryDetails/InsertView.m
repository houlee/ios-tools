//
//  InsertView.m
//  caibo
//
//  Created by user on 11-10-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InsertView.h"
#import "LotteryDetail.h"

#define TYPERED @"red"
#define TYPEBLUE @"blue"

@implementation InsertView


//设置开奖详情顶部视图
+ (UIImageView *)insertLottery:(NSString *)lotteryName issue:(NSString *)issue
{
	UIImageView *topView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 70)] autorelease];
	
	//彩种名
	if (lotteryName != nil) {NSLog(@"lotteryName = %@\n", lotteryName);
		UILabel *lotteryNameLabel = [self initLableWithFrame: CGRectMake(88, 16, 200, 24) fontSize:22];
		lotteryNameLabel.text = lotteryName;
		[topView addSubview:lotteryNameLabel];
	}
	
	//彩期
	if (issue != nil) {NSLog(@"issue = %@\n", issue);
		UILabel *issueLabel = [self initLableWithFrame:CGRectMake(88, 40, 200, 20) fontSize:15];
		issueLabel.text = [NSString stringWithFormat:@"第%@期",issue];
		[topView addSubview:issueLabel];
	}
	
	return topView;
}


//设置开奖详情号码、时间、销量、滚存等视图
+ (UIImageView *)insertdate:(LotteryDetail *)detail
{
	NSInteger yOffset = 0;
	NSInteger height = 0;
	
	if ([detail.lotteryName isEqualToString:@"胜负任九"]
		|| [detail.lotteryName isEqualToString:@"进球彩"] 
		|| [detail.lotteryName isEqualToString:@"半全场"])
	{
		if ([detail.lotteryName isEqualToString:@"胜负任九"])
		{
			height = ([detail.sales_rx9 isEqualToString:@""]) ? 110 :136;
		}
		else {
			height = (detail.buyamont != nil) ? 110 : 84;
		}
	}
	else {
		height = (detail.buyamont != nil) ? 84 : 62;
	}
	
	UIImageView *timeView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, height)] autorelease];
	
	//开奖时间
	if (detail.ernie_date != nil){NSLog(@"ernie_date = %@\n", detail.ernie_date);
		UILabel *ernie_dateLabel = [self initLableWithFrame: CGRectMake(6, 6, 290, 20) fontSize:14];
		ernie_dateLabel.text = [NSString stringWithFormat:@"开奖时间 : %@",detail.ernie_date];
		[timeView addSubview:ernie_dateLabel];
	}
	
	//开奖号码
	if (detail.lotteryNumber != nil){
		UILabel *lotteryNumberLabel = [self initLableWithFrame: CGRectMake(6, 31, 64, 20) fontSize:14];
		lotteryNumberLabel.text = @"开奖号码 :";
		[timeView addSubview:lotteryNumberLabel];
		
		NSLog(@"lotteryNumber = %@\n", detail.lotteryNumber);
		if ([detail.lotteryName isEqualToString:@"胜负任九"] 
			|| [detail.lotteryName isEqualToString:@"进球彩"] 
			|| [detail.lotteryName isEqualToString:@"半全场"])
		{
			yOffset = 26;
			
			NSArray *nArray = [detail.lotteryNumber componentsSeparatedByString:@","]; 
			NSMutableString *fMutableString = [[NSMutableString alloc] init];
			NSMutableString *lMutableString = [[NSMutableString alloc] init];
			
			for (int i=0; i<[nArray count]/2; i++) {
				
				[fMutableString appendString:[nArray objectAtIndex:i]];
				
				if (i != [nArray count]/2-1) {
					[fMutableString appendString:@","];
				}
			}
			
			UIImageView *fView = [self numViewWithLottery:(NSString *)fMutableString];//前串号码
			fView.frame = CGRectMake(74, 30, 80, 24);
			[timeView addSubview:fView];
			[fMutableString release];
			
			for (int j=(int)[nArray count]/2; j<(int)[nArray count]; j++) {
				
				[lMutableString appendString:[nArray objectAtIndex:j]];
				if (j != [nArray count]-1) {
					[lMutableString appendString:@","];
				}
			}
			
			UIImageView *lView = [self numViewWithLottery:(NSString *)lMutableString];//后串
			lView.frame = CGRectMake(74, 30+yOffset, 80, 24);
			[timeView addSubview:lView];
			[lMutableString release];
		}
		else {
			UIImageView *numView = [self numViewWithLottery:detail.lotteryNumber];
			numView.frame = CGRectMake(74, 30, 80, 24);
			[timeView addSubview:numView];
		}
		
	}
	
	//奖池金额
	NSLog(@"buyamont = %@\n", detail.buyamont);
	if (detail.buyamont != nil) {
		
		UILabel *buyamontLabel = [self initLableWithFrame: CGRectMake(6, 56+yOffset, 290, 20) fontSize:14];
		buyamontLabel.text = [NSString stringWithFormat:@"本期销量 : %@",detail.buyamont];
		[timeView addSubview:buyamontLabel];
	}
	NSLog(@"sales_sfc = %@\n", detail.sales_sfc);
	if ([detail.sales_sfc isEqualToString:@""] || detail.sales_sfc == nil) {
	}
	else {
		UILabel *buyamontLabel = [self initLableWithFrame: CGRectMake(6, 56+yOffset+2, 290, 20) fontSize:14];
		buyamontLabel.text = [NSString stringWithFormat:@"胜负彩销量 : %@",detail.sales_sfc];
		[timeView addSubview:buyamontLabel];
		
		yOffset += 26;
	}
	
	NSLog(@"sales_rx9 = %@\n", detail.sales_rx9);
	if ([detail.sales_rx9 isEqualToString:@""] || detail.sales_rx9 == nil) {
		
	}
	else {
		UILabel *buyamontLabel = [self initLableWithFrame: CGRectMake(6, 56+yOffset, 290, 20) fontSize:14];
		buyamontLabel.text = [NSString stringWithFormat:@"任九销量 : %@",detail.sales_rx9];
		[timeView addSubview:buyamontLabel];
	}

	return timeView;
}


//设置开奖详情奖项视图
+ (UIImageView *)insertAwards:(NSArray *)array
{
	NSInteger h = 0;
	NSInteger num = [array count];
	if (num > 7) {
		h = (26+num*24);
	}
	
	UIImageView *timeView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, h)] autorelease];
	
	if (array != nil)
	{
		UIImageView *tImage = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"tiao.png")];
		tImage.frame = CGRectMake(0, 0, 294, 23);
		
		NSString *space = @" ";
		NSMutableString *mStr1 = [[[NSMutableString alloc] init] autorelease];
		for (int k=0; k<18; k++) {
			[mStr1 appendString:space];
		}
		NSMutableString *mStr2 = [[[NSMutableString alloc] init] autorelease];
		for (int n=0; n<15; n++) {
			[mStr2 appendString:space];
		}
		UILabel *awardsLabel = [self initLableWithFrame: CGRectMake(16, 3, 274, 16) fontSize:13];
		awardsLabel.text = [NSString stringWithFormat:@"奖项%@中奖注数%@单注奖金", mStr1, mStr2];
		[tImage addSubview:awardsLabel];
		
		[timeView addSubview:tImage];
		[tImage release];
		
		for (int i=0; i<[array count]; i++)
		{
			LotteryDetail *lDetail = [array objectAtIndex:i];
			
			UILabel *awardsLabel = [self initLableWithFrame: CGRectMake(16, 26+i*24, 64, 16) fontSize:13];
			awardsLabel.text = lDetail.awards;
			[timeView addSubview:awardsLabel];
			
			UILabel *winningNoteLabel = [self initLableWithFrame: CGRectMake(80, 26+i*24, 80, 16) fontSize:13];
			winningNoteLabel.text = [NSString stringWithFormat:@"%@ 注", lDetail.winningNote];
			winningNoteLabel.textAlignment = NSTextAlignmentRight;
			[timeView addSubview:winningNoteLabel];
			
			UILabel *singleNoteBonusLabel = [self initLableWithFrame: CGRectMake(160, 26+i*24, 120, 16) fontSize:13];
			singleNoteBonusLabel.text = [NSString stringWithFormat:@"%@ 元", lDetail.single_Note_Bonus];
			singleNoteBonusLabel.textAlignment = NSTextAlignmentRight;
			[timeView addSubview:singleNoteBonusLabel];
		}
	}
	
	return timeView;
}


//添加本期对阵表标签
+ (UIImageView *)insertAgainstName:(NSString *)againstName
{
	UIImageView *againstNameView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 30)] autorelease];
	
	UILabel *againstNameLabel = [self initLableWithFrame: CGRectMake(0, 0, 294, 30) fontSize:15];
	againstNameLabel.text = againstName;
	againstNameLabel.textAlignment = NSTextAlignmentCenter;
	[againstNameView addSubview:againstNameLabel];
	
	return againstNameView;
}


//设置本期对阵表视图
+ (UIImageView *)insertAgainstNamesList:(NSArray *)againstNamesList againstList:(NSArray *)reAgainstList
{
	NSLog(@"againstNamesList = %@\n", againstNamesList);
	NSLog(@"reAgainstList = %@\n", reAgainstList);
	
	UIImageView *againstListView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 294, 200)] autorelease];
	
	if (againstNamesList != nil)
	{
		UIImageView *tImage = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"tiao.png")];
		tImage.frame = CGRectMake(0, 0, 294, 23);
		
		NSString *space = @" ";
		NSMutableString *mStr1 = [[[NSMutableString alloc] init] autorelease];
		for (int k=0; k<14; k++) {
			[mStr1 appendString:space];
		}
		NSMutableString *mStr2 = [[[NSMutableString alloc] init] autorelease];
		for (int n=0; n<16; n++) {
			[mStr2 appendString:space];
		}
		
		NSString *name1 = [againstNamesList objectAtIndex:0];
		NSString *name2 = [againstNamesList objectAtIndex:1];
		NSString *name3 = [againstNamesList objectAtIndex:2];
		NSString *name4 = nil;
		if ([againstNamesList count] > 3) {
			name4 = [againstNamesList objectAtIndex:3];
		}
		
		if (name4 != nil) {
			
			UILabel *name1Label = [self initLableWithFrame: CGRectMake(8, 3, 50, 16) fontSize:13];
			name1Label.text = name1;
			[tImage addSubview:name1Label];
			
			UILabel *name2Label = [self initLableWithFrame: CGRectMake(58, 3, 84, 16) fontSize:13];
			name2Label.textAlignment = NSTextAlignmentCenter;
			name2Label.text = name2;
			[tImage addSubview:name2Label];
			
			UILabel *name3Label = [self initLableWithFrame: CGRectMake(156, 3, 70, 16) fontSize:13];
			name3Label.textAlignment = NSTextAlignmentCenter;
			name3Label.text = name3;
			[tImage addSubview:name3Label];
			
			UILabel *name4Label = [self initLableWithFrame: CGRectMake(222, 3, 64, 16) fontSize:13];
			name4Label.textAlignment = NSTextAlignmentRight;
			name4Label.text = name4;
			[tImage addSubview:name4Label];
			
			//againstNamesListLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",name1,mStr1,name2,mStr2,name3,mStr3,name4];
		}
		else {
			UILabel *againstNamesListLabel = [self initLableWithFrame: CGRectMake(8, 3, 286, 16) fontSize:13];
			againstNamesListLabel.text = [NSString stringWithFormat:@"%@        %@%@%@    %@",name1,mStr1,name2,mStr2,name3];
			[tImage addSubview:againstNamesListLabel];
		}
		
		[againstListView addSubview:tImage];
		[tImage release];
		
	}

	if (reAgainstList != nil)
	{
		for (int j=0; j<[reAgainstList count]; j++)
		{
			LotteryDetail *lDetail = [reAgainstList objectAtIndex:j];
			
			if ([againstNamesList count] >3) {
				UILabel *screeningLabel = [self initLableWithFrame: CGRectMake(8, 26+j*24, 24, 16) fontSize:13];
				screeningLabel.text = [NSString stringWithFormat:@"%@.", lDetail.screening];
				[againstListView addSubview:screeningLabel];
				
				UILabel *teamsLabel = [self initLableWithFrame: CGRectMake(32, 26+j*24, 130, 16) fontSize:13];
				teamsLabel.text = [NSString stringWithFormat:@"%@", lDetail.teams];
				teamsLabel.textAlignment = NSTextAlignmentCenter;
				[againstListView addSubview:teamsLabel];
				
				UILabel *scoreLabel = [self initLableWithFrame: CGRectMake(172, 26+j*24, 40, 16) fontSize:13];
				scoreLabel.text = [NSString stringWithFormat:@"%@", lDetail.score];
				scoreLabel.textAlignment = NSTextAlignmentCenter;
				[againstListView addSubview:scoreLabel];
				
				UILabel *resultsLabel = [self initLableWithFrame: CGRectMake(256, 26+j*24, 24, 16) fontSize:13];
				resultsLabel.text = [NSString stringWithFormat:@"%@", lDetail.results];
				resultsLabel.textAlignment = NSTextAlignmentCenter;
				[againstListView addSubview:resultsLabel];
			}
			else {
				UILabel *screeningLabel = [self initLableWithFrame: CGRectMake(8, 26+j*24, 24, 16) fontSize:13];
				screeningLabel.text = [NSString stringWithFormat:@"%@.", lDetail.screening];
				[againstListView addSubview:screeningLabel];
				
				UILabel *teamsLabel = [self initLableWithFrame: CGRectMake(60, 26+j*24, 130, 16) fontSize:13];
				teamsLabel.text = [NSString stringWithFormat:@"%@", lDetail.teams];
				teamsLabel.textAlignment = NSTextAlignmentCenter;
				[againstListView addSubview:teamsLabel];

				UILabel *resultsLabel = [self initLableWithFrame: CGRectMake(223, 26+j*24, 40, 16) fontSize:13];
				resultsLabel.text = [NSString stringWithFormat:@"%@", lDetail.results];
				resultsLabel.textAlignment = NSTextAlignmentCenter;
				[againstListView addSubview:resultsLabel];
			}
		}		
	}

	return againstListView;
}


//初始化标签
+ (UILabel *)initLableWithFrame:(CGRect)rect fontSize:(NSInteger)size
{
	UILabel *label = [[[UILabel alloc] initWithFrame:rect] autorelease];
	label.font = [UIFont fontWithName: @"Helvetica" size: size];
	label.textAlignment = NSTextAlignmentLeft;
	label.backgroundColor = [UIColor clearColor];
	
	return label;
}


//返回开奖号码单个图片
+ (UIImageView *)numViewWithStr:(NSString *)str type:(NSString *)typeStr
{
	NSMutableString *mStr = [[[NSMutableString alloc] init] autorelease];
	NSString *string = [[[NSString alloc ] init] autorelease];
	
	if ([str length] > 0)
	{
		NSRange rang;
		rang.location = 0;
		rang.length = 1;
		
		for (int i = 0; i < [str length]; i++)
		{
			NSString *temp = [str substringWithRange:rang];
			if ([temp isEqualToString:@" "])
			{
				[mStr appendString:@""];
			}
			else {
				[mStr appendString:[NSString stringWithString: temp]];
			}

			rang.location += 1;
		}
	
		string = (NSString *)mStr;
	}
	
//	NSString *iName = nil;
//	if ([typeStr isEqualToString:TYPERED]) {
//		iName = @"ball_red.png";
//	}
//	else if ([typeStr isEqualToString:TYPEBLUE]){
//		iName = @"ball_blue.png";
//	}
	UIImageView *iView = [[[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"tiao.png")] autorelease];
	iView.frame = CGRectMake(0, 0, 22, 22);
	UILabel *nLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
	[nLabel setText:string];
	
	NSInteger size = 0;
	if ([string length] == 1) {
		size = 15;
	}
	else if ([string length] == 2){
		size = 13;
	}
	else {
		size = 0;
	}
	nLabel.font = [UIFont fontWithName:@"Helvetica" size:size];
	nLabel.textAlignment = NSTextAlignmentCenter;
	nLabel.highlightedTextColor = [UIColor whiteColor];
	nLabel.highlighted = YES;
	nLabel.backgroundColor = [UIColor clearColor];
	[iView addSubview:nLabel];
	[nLabel release];
		
	return iView;
}


//返回开奖号码视图
+ (UIImageView *)numViewWithLottery:(NSString *)lotteryNumber
{
	NSArray *numArray = [lotteryNumber componentsSeparatedByString:@","]; 

	NSLog(@"numArray = %@\n",numArray);
	NSLog(@"numArray length = %d\n",(int)[numArray count]);
	
	NSInteger count = 0; //球数
	
	UIImageView *numView = nil;
	NSInteger wOffset = 0;
	UIImageView *nView = nil;
	NSInteger xOffset = 0;
	NSString *type = TYPERED;
	NSArray *endArray = nil;
	NSInteger i = 0;
	
	NSString *endStr = @"";
    if ([numArray count] > [numArray count]-1) {
        endStr = [numArray objectAtIndex:[numArray count]-1];
    }
	if ([endStr length] > 2) {
		count = [numArray count] + 1;
	}
	else {
		count = [numArray count];
	}
	
	wOffset = 22*count +4*(count-1);
	
	numView = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0+wOffset, 30)] autorelease];
	
	while (i < [numArray count])
	{
		if ([[numArray objectAtIndex:i] length] > 2)
		{
			endArray = [[numArray objectAtIndex:i] componentsSeparatedByString:@"+"];
			if (endArray != nil) {
                if ([endArray count] > 1) {
                    nView = [self numViewWithStr:[endArray objectAtIndex:0] type:type];
                    nView.frame = CGRectMake(0+xOffset, 0, 22, 22);
                    [numView addSubview:nView];
                    xOffset += 26;
                    type = TYPEBLUE;
                    
                    nView = [self numViewWithStr:[endArray objectAtIndex:1] type:type];
                    nView.frame = CGRectMake(0+xOffset, 0, 22, 22);
                    [numView addSubview:nView];
                }
				
			}
		}
		else
		{
			nView = [self numViewWithStr:[numArray objectAtIndex:i] type:type];
			nView.frame = CGRectMake(0+xOffset, 0, 22, 22);
			[numView addSubview:nView];
		}
		
		xOffset += 26;
		i ++;
	}

	return numView;
}


@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    