//
//  IntegralAlertView.m
//  caibo
//
//  Created by houchenguang on 14-5-26.
//
//

#import "IntegralAlertView.h"
#import "caiboAppDelegate.h"
#import "JFBMatchTabTableViewCell.h"
#import "JFBTeamTableViewCell.h"

@implementation IntegralAlertView
@synthesize interalString;

- (void)setDataDictionary:(NSDictionary *)_dataDictionary{

    if (dataDictionary != _dataDictionary) {
        [dataDictionary release];
        dataDictionary = [_dataDictionary retain];
    }
    
    
    NSDictionary * playDict = [dataDictionary objectForKey:@"play"];
    if (showType != 1) {
        teamLabel.text = [NSString stringWithFormat:@"%@%@  %@VS%@", [playDict objectForKey:@"league_name"], [playDict objectForKey:@"season"], [playDict objectForKey:@"host_name"], [playDict objectForKey:@"guest_name"]];//@"英超13/14  曼联VS切尔西";
    }
    UILabel * homeLabel= (UILabel *)[bgImageView viewWithTag:100];
    UILabel * guestLabel= (UILabel *)[bgImageView viewWithTag:101];
    homeLabel.text = [NSString stringWithFormat:@"%@积分榜", [playDict objectForKey:@"host_name"]];
    guestLabel.text = [NSString stringWithFormat:@"%@积分榜", [playDict objectForKey:@"guest_name"]];
    
    UILabel * lsnameLabel = (UILabel *)[bgImageView viewWithTag:80];
    UILabel * lsnameLabelTwo = (UILabel *)[bgImageView viewWithTag:81];
    lsnameLabel.text = [NSString stringWithFormat:@"%@积分榜",[playDict objectForKey:@"hostleaguename"]];
    lsnameLabelTwo.text = [NSString stringWithFormat:@"%@积分榜", [playDict objectForKey:@"guestleaguename"]];
    
    
    if (showType == 1) {
        NSInteger count = [self cellHightFunc];
        self.frame = CGRectMake(0, 0, 320, count*32+32);
        myTableView.frame = CGRectMake(0, 32, 320, count*32);
    }else{
        myTableView.frame = CGRectMake(0, 104, 300, 264);
    }
    
    [myTableView reloadData];
    
}

- (NSDictionary *)dataDictionary{
    return dataDictionary;
}


- (void)dealloc{
    [dataDictionary release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (NSInteger)cellHightFunc{

    if (dataDictionary) {
        
        if (alertType == 1) {
            
            if ([dataDictionary objectForKey:@"league"] ) {
                
                
                return [[dataDictionary objectForKey:@"league"] count];
                
                
            }else{
                return 0;
            }
            
        }else{
            if ([dataDictionary objectForKey:@"guest_league"] && [dataDictionary objectForKey:@"host_league"]) {
                
                if ([[dataDictionary objectForKey:@"guest_league"] count] >= [[dataDictionary objectForKey:@"host_league"] count]) {
                    return [[dataDictionary objectForKey:@"guest_league"] count];
                }else{
                    return [[dataDictionary objectForKey:@"host_league"] count];
                }
                
            }else{
                return 0;
            }
        }
        
    }
    return 0;
}

- (id)initWithType:(NSInteger)type showType:(NSInteger)showtype{

    self = [super init];
    if (self) {
        showType = showtype;
        alertType = type;
        if (showType == 1) {
            
//            caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
            self.frame = CGRectMake(0, 0, 320, 0);
            
            self.backgroundColor = [UIColor clearColor];
            
            bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
            bgImageView.backgroundColor = [UIColor clearColor];
            bgImageView.image = [UIImageGetImageFromName(@"jifenbangbg.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
            bgImageView.userInteractionEnabled = YES;
            [self addSubview:bgImageView];
            [bgImageView release];
            
//            bgImageView.center = app.window.center;
            
            
            
            
            if (alertType == 1) {
                
                for (int i = 0; i < 5; i++) {
                    UILabel * titleMatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(167+ (i*29), 0, 29, 32)];
                    titleMatchLabel.backgroundColor = [UIColor clearColor];
                    titleMatchLabel.textAlignment = NSTextAlignmentCenter;
                    titleMatchLabel.font = [UIFont systemFontOfSize:13];
                    titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
                    [bgImageView addSubview:titleMatchLabel];
                    [titleMatchLabel release];
                    
                    if (i == 0) {
                        titleMatchLabel.text = @"赛";
                    }else if (i == 1){
                        titleMatchLabel.text = @"胜";
                    }else if (i == 2){
                        titleMatchLabel.text = @"平";
                    }else if (i == 3){
                        titleMatchLabel.text = @"负";
                    }else if (i == 4){
                        titleMatchLabel.text = @"积分";
                    }
                }
                
            }else{
                for (int i = 0; i < 2; i++) {
                    UILabel * titleMatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*160, 0, 150, 32)];
                    titleMatchLabel.backgroundColor = [UIColor clearColor];
                    titleMatchLabel.textAlignment = NSTextAlignmentCenter;
                    titleMatchLabel.font = [UIFont systemFontOfSize:13];
                    titleMatchLabel.tag = 80+i;
                    titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
                    [bgImageView addSubview:titleMatchLabel];
                    [titleMatchLabel release];
                    
                    //                if (i == 0) {
                    //                    titleMatchLabel.text = @"乌克超积分榜";
                    //                }else if (i == 1){
                    //                    titleMatchLabel.text = @"英超积分榜";
                    //                }
                }
            }
            UIImageView * twoLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31, 320, 1)];
            twoLineView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            [bgImageView addSubview:twoLineView];
            [twoLineView release];
            
            
            NSInteger count = [self cellHightFunc];
            
            myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 32, 320, count*32) style:UITableViewStylePlain];
            myTableView.delegate = self;
            myTableView.dataSource = self;
            myTableView.backgroundColor = [UIColor clearColor];
            myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            myTableView.showsVerticalScrollIndicator = NO;
            myTableView.bounces = NO;
            [self addSubview:myTableView];
            [myTableView release];
            
        }else{
            caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
            self.frame = app.window.bounds;
            
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
           
            
            bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 441)];
            bgImageView.backgroundColor = [UIColor clearColor];
            bgImageView.image = [UIImageGetImageFromName(@"jifenbangbg.png") stretchableImageWithLeftCapWidth:15 topCapHeight:15];
            bgImageView.userInteractionEnabled = YES;
            [self addSubview:bgImageView];
            [bgImageView release];
            
            bgImageView.center = app.window.center;
            
            UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 43)];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.font = [UIFont systemFontOfSize:18];
            titleLabel.textColor = [UIColor colorWithRed:153/255.0 green:152/255.0 blue:152/255.0 alpha:1];
            titleLabel.text = @"积分榜";
            [bgImageView addSubview:titleLabel];
            [titleLabel release];
            
            UIImageView * lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, 300, 0.5)];
            lineView.backgroundColor = [UIColor colorWithRed:199/255.0 green:199/255.0 blue:199/255.0 alpha:1];
            [bgImageView addSubview:lineView];
            [lineView release];
            
            UIImageView * headbg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.5, 300, 103 - 43.5)];
            headbg.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];
            [bgImageView addSubview:headbg];
            [headbg release];
            
            teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 56, 300, 15)];
            teamLabel.backgroundColor = [UIColor clearColor];
            teamLabel.textAlignment = NSTextAlignmentCenter;
            teamLabel.font = [UIFont systemFontOfSize:14];
            teamLabel.textColor = [UIColor colorWithRed:52/255.0 green:148/255.0 blue:255/255.0 alpha:1];
            
            [bgImageView addSubview:teamLabel];
            [teamLabel release];
            
            
            
            if (alertType == 1) {
                
                for (int i = 0; i < 5; i++) {
                    UILabel * titleMatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(167+ (i*25), 86, 25, 13)];
                    titleMatchLabel.backgroundColor = [UIColor clearColor];
                    titleMatchLabel.textAlignment = NSTextAlignmentCenter;
                    titleMatchLabel.font = [UIFont systemFontOfSize:11];
                    titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
                    [bgImageView addSubview:titleMatchLabel];
                    [titleMatchLabel release];
                    
                    if (i == 0) {
                        titleMatchLabel.text = @"赛";
                    }else if (i == 1){
                        titleMatchLabel.text = @"胜";
                    }else if (i == 2){
                        titleMatchLabel.text = @"平";
                    }else if (i == 3){
                        titleMatchLabel.text = @"负";
                    }else if (i == 4){
                        titleMatchLabel.text = @"积分";
                    }
                }
                
            }else{
                for (int i = 0; i < 2; i++) {
                    UILabel * titleMatchLabel = [[UILabel alloc] initWithFrame:CGRectMake(i*150, 86, 150, 13)];
                    titleMatchLabel.backgroundColor = [UIColor clearColor];
                    titleMatchLabel.textAlignment = NSTextAlignmentCenter;
                    titleMatchLabel.font = [UIFont systemFontOfSize:11];
                    titleMatchLabel.tag = 80+i;
                    titleMatchLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1];
                    [bgImageView addSubview:titleMatchLabel];
                    [titleMatchLabel release];
                    
                    //                if (i == 0) {
                    //                    titleMatchLabel.text = @"乌克超积分榜";
                    //                }else if (i == 1){
                    //                    titleMatchLabel.text = @"英超积分榜";
                    //                }
                }
            }
            UIImageView * twoLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 103, 300, 1)];
            twoLineView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            [bgImageView addSubview:twoLineView];
            [twoLineView release];
            
            
            myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, 300, 264) style:UITableViewStylePlain];
            myTableView.delegate = self;
            myTableView.dataSource = self;
            myTableView.backgroundColor = [UIColor clearColor];
            myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            myTableView.showsVerticalScrollIndicator = NO;
            myTableView.bounces = NO;
            [bgImageView addSubview:myTableView];
            [myTableView release];
            
            UIImageView * threeLineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 368, 300, 1)];
            threeLineView.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1];
            [bgImageView addSubview:threeLineView];
            [threeLineView release];
            
            UIButton * sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
            sendButton.frame = CGRectMake((300 - 246)/2, 385, 246, 38);
            [sendButton setBackgroundImage:UIImageGetImageFromName(@"jfbsendbutton.png") forState:UIControlStateNormal];
            [sendButton setBackgroundImage:UIImageGetImageFromName(@"jfbsendbutton_1.png") forState:UIControlStateHighlighted];
            [sendButton setTitle:@"确定" forState:UIControlStateNormal];
            [sendButton setTintColor:[UIColor whiteColor]];
            [sendButton addTarget:self action:@selector(pressSendButton:) forControlEvents:UIControlEventTouchUpInside];
            [bgImageView addSubview:sendButton];
        
        }
        
        
        
    }
    return self;
}

- (void)show{

    caiboAppDelegate * app = [caiboAppDelegate getAppDelegate];
    [app.window addSubview:self];
}

- (void)pressSendButton:(UIButton *)sender{

    [UIView beginAnimations:@"nddd" context:NULL];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.alpha = 0;
    [UIView commitAnimations];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:.5];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger count = [self cellHightFunc];
    
    
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 32;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (alertType == 1) {
        static NSString *CellIdentifier = @"SCell";
        
        JFBMatchTabTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[JFBMatchTabTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:showType] autorelease];
        }
        cell.interalString= self.interalString;
        cell.jfIndexPath = indexPath;
        cell.dataDictionary = dataDictionary;
        
        return cell;
    }else{
        static NSString *CellIdentifier = @"SssCell";
        
        JFBTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[[JFBTeamTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier type:showType] autorelease];
        }
        cell.interalString= self.interalString;
        cell.jfIndexPath = indexPath;
        cell.dataDictionary = dataDictionary;
        return cell;
    }
    
    
    
    
    
    return nil;
    
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