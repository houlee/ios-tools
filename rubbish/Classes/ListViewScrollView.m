//
//  ListViewScrollView.m
//  caibo
//
//  Created by houchenguang on 14-5-22.
//
//

#import "ListViewScrollView.h"
#import "ColorView.h"

@implementation ListViewScrollView
@synthesize listType;
@synthesize delegateList, titleImageView, keyString;

- (NSMutableDictionary *)analyzeDictionary{

    return analyzeDictionary;
}



- (void)setAnalyzeDictionary:(NSMutableDictionary *)_analyzeDictionary{
    if (analyzeDictionary != _analyzeDictionary) {
        [analyzeDictionary release];
        analyzeDictionary = [_analyzeDictionary retain];
    }

   
    if (analyzeDictionary) {
        NSDictionary * dict = [analyzeDictionary objectForKey:self.keyString];
        NSDictionary * dictTwo = [analyzeDictionary objectForKey:@"1"];
        NSDictionary * infodict = [dictTwo objectForKey:@"playinfo"];
        
        if (listType == homeTeamListViewType) {
            if ([[dict objectForKey:@"hostRecentPlay"] count] == 0) {
               
                teamTableView.frame = CGRectMake(0, 66.5+31.5, self.frame.size.width*2, 0);
                 zwImageView.hidden = NO;
            }else{
                 teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2, [[dict objectForKey:@"hostRecentPlay"] count] * 48);
                 zwImageView.hidden = YES;
              
            }
            
            teamLable.text = [infodict objectForKey:@"HostTeamName"];
            
            NSDictionary * hostRecentPlaywin = [dict objectForKey:@"hostRecentPlaywin"];
            
            if (hostRecentPlaywin) {
                titleLabel.text = [NSString stringWithFormat:@"近%@场  %@胜%@平%@负    胜率%@", [hostRecentPlaywin objectForKey:@"sum"] ,[hostRecentPlaywin objectForKey:@"win"] ,[hostRecentPlaywin objectForKey:@"same"] ,[hostRecentPlaywin objectForKey:@"lost"] ,[hostRecentPlaywin objectForKey:@"odds"]];
            }else{
            
                titleLabel.text = @"";
            }
            
           
        }else if (listType == guestTeamListViewType){
            if ([[dict objectForKey:@"guestRecentPlay"] count] == 0) {
                 zwImageView.hidden = NO;
               teamTableView.frame = CGRectMake(0, 66.5+31.5, self.frame.size.width*2, 0);
            }else{
                teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2, [[dict objectForKey:@"guestRecentPlay"] count] * 48);
                 zwImageView.hidden = YES;
               
            }
            
            NSDictionary * hostRecentPlaywin = [dict objectForKey:@"guestRecentPlaywin"];
            teamLable.text = [infodict objectForKey:@"GuestTeamName"];
            if (hostRecentPlaywin) {
                titleLabel.text = [NSString stringWithFormat:@"近%@场  %@胜%@平%@负    胜率%@", [hostRecentPlaywin objectForKey:@"sum"] ,[hostRecentPlaywin objectForKey:@"win"] ,[hostRecentPlaywin objectForKey:@"same"] ,[hostRecentPlaywin objectForKey:@"lost"] ,[hostRecentPlaywin objectForKey:@"odds"]];
            }else{
                
                titleLabel.text = @"";
            }
          
        }else if (listType == historyListViewType){
            if ([[dict objectForKey:@"playvs"] count] == 0) {
               teamTableView.frame = CGRectMake(0, 66.5+31.5, self.frame.size.width*2, 0);
                 zwImageView.hidden = NO;
            }else{
                teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2, [[dict objectForKey:@"playvs"] count] * 48);
                 zwImageView.hidden = YES;
            }
            teamLable.text = @"历史交锋";
             titleLabel.text = @"";
        }else{
           teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2, 0);
             zwImageView.hidden = YES;
            teamLable.text = @"";
             titleLabel.text = @"";
        }
       
        
         [teamTableView reloadData];
        
        if (zwImageView.hidden == NO) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 98)
            ;
           
           teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2,  0);
            self.contentSize = CGSizeMake(self.contentSize.width, 98 );
        }else{
        
            if (listType == homeTeamListViewType) {
                teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2, [[dict objectForKey:@"hostRecentPlay"] count] * 48);
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [[dict objectForKey:@"hostRecentPlay"] count]*48+66.5)
                ;
                self.contentSize = CGSizeMake(self.contentSize.width, [[dict objectForKey:@"hostRecentPlay"] count]*48+66.5 );
                
            }else if (listType == guestTeamListViewType){
                 teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2, [[dict objectForKey:@"guestRecentPlay"] count] * 48);
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [[dict objectForKey:@"guestRecentPlay"] count]*48+66.5)
                ;
                self.contentSize = CGSizeMake(self.contentSize.width, [[dict objectForKey:@"guestRecentPlay"] count]*48+66.5 );
                
            }else if (listType == historyListViewType){
                               
                teamTableView.frame = CGRectMake(0, 66.5, self.frame.size.width*2, [[dict objectForKey:@"playvs"] count] * 48);
                self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, [[dict objectForKey:@"playvs"] count]*48+66.5)
                ;
                self.contentSize = CGSizeMake(self.contentSize.width, [[dict objectForKey:@"playvs"] count]*48+66.5 );
                               
                
                
            }
        }
        NSLog(@"mytableview = %f", teamTableView.contentSize.height);
        NSLog(@"ddd = %f", self.frame.size.height);
       
        
    }
}


- (void)dealloc{
    [keyString release];
    [analyzeDictionary release];
    [super dealloc];
}

- (void)setListType:(ListViewType)_listType{
    listType = _listType;

    
    if (listType == homeTeamListViewType) {
//        teamLable.text = @"曼联";
        teamLable.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        titleLabel.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        lineImageView.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
        leftLineImage.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
    }else if (listType == guestTeamListViewType){
//        teamLable.text = @"切尔西";
        teamLable.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];//[UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        titleLabel.textColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];//[UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        lineImageView.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];//[UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
        leftLineImage.backgroundColor = [UIColor colorWithRed:249/255.0 green:135/255.0 blue:14/255.0 alpha:1];//[UIColor colorWithRed:66/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    }else if (listType == historyListViewType){
//        teamLable.text = @"历史交锋";
        teamLable.textColor = [UIColor colorWithRed:4/255.0 green:75/255.0 blue:175/255.0 alpha:1];
        titleLabel.textColor = [UIColor colorWithRed:4/255.0 green:75/255.0 blue:175/255.0 alpha:1];
        lineImageView.backgroundColor = [UIColor colorWithRed:4/255.0 green:75/255.0 blue:175/255.0 alpha:1];
        leftLineImage.backgroundColor = [UIColor colorWithRed:4/255.0 green:75/255.0 blue:175/255.0 alpha:1];
    }else{
        teamLable.text = @"";
    }
}

- (ListViewType)listType{
    return listType;
}

- (void)showAllViewFunc{
    
    titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 31.5)];
    titleImageView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self addSubview:titleImageView];
    [titleImageView release];
    
    lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 320, 1.5)];
    lineImageView.backgroundColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
    [titleImageView addSubview:lineImageView];
    [lineImageView release];
    
    
    teamLable = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 100, 30)];
    teamLable.textAlignment = NSTextAlignmentLeft;
    teamLable.font = [UIFont systemFontOfSize:16];
    teamLable.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
    teamLable.backgroundColor = [UIColor clearColor];
    [titleImageView addSubview:teamLable];
    [teamLable release];

    
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(121, 0, 179, 30)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor colorWithRed:6/255.0 green:96/255.0 blue:211/255.0 alpha:1];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleImageView addSubview:titleLabel];
    [titleLabel release];
    
    ColorView * leftMatchLable = [[ColorView alloc] initWithFrame:CGRectMake(341+111+59, 41.5, 150, 35)];
    leftMatchLable.textAlignment = NSTextAlignmentCenter;
    leftMatchLable.font = [UIFont systemFontOfSize:13];
    leftMatchLable.textColor = [UIColor blackColor];
    leftMatchLable.backgroundColor = [UIColor clearColor];
    leftMatchLable.changeColor =[UIColor colorWithRed:28/255.0 green:139/255.0 blue:252/255.0 alpha:1];
    leftMatchLable.text = @"竞彩赔率/<欧赔>";
    [self  addSubview:leftMatchLable];
    [leftMatchLable release];
    
    UIImageView * leftOneshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(311+59+111, 43.5, 0.5, 11)];
    leftOneshuImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [self addSubview:leftOneshuImage];
    [leftOneshuImage release];
    
    UILabel * leftbanLable = [[UILabel alloc] initWithFrame:CGRectMake(311+111, 31.5, 58, 35)];
    leftbanLable.textAlignment = NSTextAlignmentCenter;
    leftbanLable.font = [UIFont systemFontOfSize:13];
    leftbanLable.textColor = [UIColor blackColor];
    leftbanLable.backgroundColor = [UIColor clearColor];
    leftbanLable.text = @"半场";
    [self  addSubview:leftbanLable];
    [leftbanLable release];
    
    UIImageView * leftTwoshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(311+111, 43.5, 0.5, 11)];
    leftTwoshuImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [self addSubview:leftTwoshuImage];
    [leftTwoshuImage release];
    
    UILabel * lefttimeLable = [[UILabel alloc] initWithFrame:CGRectMake(311, 31.5, 320-209, 35)];
    lefttimeLable.textAlignment = NSTextAlignmentCenter;
    lefttimeLable.font = [UIFont systemFontOfSize:13];
    lefttimeLable.textColor = [UIColor blackColor];
    lefttimeLable.backgroundColor = [UIColor clearColor];
    lefttimeLable.text = @"比赛时间";
    [self  addSubview:lefttimeLable];
    [lefttimeLable release];
    
    leftLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(311, 31.5+34.5, 320, 0.5)];
    [self addSubview:leftLineImage];
    [leftLineImage release];
    
    
    UILabel * matchLable = [[UILabel alloc] initWithFrame:CGRectMake( 9, 31.5, 52.5, 35)];
    matchLable.textAlignment = NSTextAlignmentCenter;
    matchLable.font = [UIFont systemFontOfSize:13];
    matchLable.textColor = [UIColor blackColor];
    matchLable.backgroundColor = [UIColor clearColor];
    matchLable.text = @"赛事";
    [self  addSubview:matchLable];
    [matchLable release];

    UIImageView * oneshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(62.5, 43.5, 0.5, 11)];
    oneshuImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [self addSubview:oneshuImage];
    [oneshuImage release];
    
    UILabel * homeLable = [[UILabel alloc] initWithFrame:CGRectMake(79.5 + 15, 31.5, 52.5, 35)];
    homeLable.textAlignment = NSTextAlignmentCenter;
    homeLable.font = [UIFont systemFontOfSize:13];
    homeLable.textColor = [UIColor blackColor];
    homeLable.backgroundColor = [UIColor clearColor];
    homeLable.text = @"主队";
    [self  addSubview:homeLable];
    [homeLable release];

    
    UIImageView * twoshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(148 + 15, 43.5, 0.5, 11)];
    twoshuImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [self addSubview:twoshuImage];
    [twoshuImage release];
    
    UILabel * bfLable = [[UILabel alloc] initWithFrame:CGRectMake( 148.5 + 15, 31.5, 46, 35)];
    bfLable.textAlignment = NSTextAlignmentCenter;
    bfLable.font = [UIFont systemFontOfSize:13];
    bfLable.textColor = [UIColor blackColor];
    bfLable.backgroundColor = [UIColor clearColor];
    bfLable.text = @"比分";
    [self  addSubview:bfLable];
    [bfLable release];
    
    UIImageView * threeshuImage = [[UIImageView alloc] initWithFrame:CGRectMake(194.5 + 15, 43.5, 0.5, 11)];
    threeshuImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    [self addSubview:threeshuImage];
    [threeshuImage release];
    
    UILabel * kdLable = [[UILabel alloc] initWithFrame:CGRectMake(198 + 7, 31.5, 88, 35)];
    kdLable.textAlignment = NSTextAlignmentCenter;
    kdLable.font = [UIFont systemFontOfSize:13];
    kdLable.textColor = [UIColor blackColor];
    kdLable.backgroundColor = [UIColor clearColor];
    kdLable.text = @"客队";
    [self  addSubview:kdLable];
    [kdLable release];
    
    
    teamTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 66.5, self.frame.size.width*2, 0) style:UITableViewStylePlain];
    teamTableView.delegate = self;
    teamTableView.dataSource = self;
    teamTableView.backgroundColor = [UIColor clearColor];
    teamTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    teamTableView.showsVerticalScrollIndicator = NO;
    teamTableView.scrollEnabled = NO;
    [self addSubview:teamTableView];
    [teamTableView release];
    
    
    
    
    zwImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 66.5, 320, 31.5)];
    zwImageView.backgroundColor = [UIColor whiteColor];
    zwImageView.hidden = NO;
    [titleImageView addSubview:zwImageView];
    [zwImageView release];
    UILabel * zwLabel = [[UILabel alloc] initWithFrame:zwImageView.bounds];
    zwLabel.textAlignment = NSTextAlignmentCenter;
    zwLabel.font = [UIFont systemFontOfSize:13];
    kdLable.textColor = [UIColor blackColor];
    zwLabel.backgroundColor = [UIColor clearColor];
    zwLabel.text = @"暂无";
    [zwImageView  addSubview:zwLabel];
    [zwLabel release];

    
    
    self.contentSize = CGSizeMake(self.frame.size.width*2 - 7,0);
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 10 * 48 + 66.5);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (listType == homeTeamListViewType) {
        NSDictionary * dict = [analyzeDictionary objectForKey:self.keyString];
        return [[dict objectForKey:@"hostRecentPlay"] count];
    }else if (listType == guestTeamListViewType){
        NSDictionary * dict = [analyzeDictionary objectForKey:self.keyString];
        return [[dict objectForKey:@"guestRecentPlay"] count];
    }else if (listType == historyListViewType){
        NSDictionary * dict = [analyzeDictionary objectForKey:self.keyString];
        return [[dict objectForKey:@"playvs"] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellIdentifier = @"SCell";
    
    FootListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[FootListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.footIndexPath = indexPath;
    cell.delegate = self;
    cell.listType = listType;
    cell.keyString = self.keyString;
    if (listType == homeTeamListViewType) {
        NSDictionary * dict = [analyzeDictionary objectForKey:@"1"];
        NSDictionary * teamdict = [dict objectForKey:@"playinfo"];
        cell.teamID = [teamdict objectForKey:@"HostTeamId"];
       
    }else if (listType == guestTeamListViewType){
        NSDictionary * dict = [analyzeDictionary objectForKey:@"1"];
        NSDictionary * teamdict = [dict objectForKey:@"playinfo"];
        cell.teamID = [teamdict objectForKey:@"GuestTeamId"];
    }else if (listType == historyListViewType){
        NSDictionary * dict = [analyzeDictionary objectForKey:@"1"];
        NSDictionary * teamdict = [dict objectForKey:@"playinfo"];
        cell.teamID = [teamdict objectForKey:@"HostTeamId"];
    }
        cell.analyzeDictionary = analyzeDictionary;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    if (delegateList && [delegateList respondsToSelector:@selector(listViewScrollView:selectIndexPatch:viewType:withNum:)]) {
//        [delegateList listViewScrollView:self selectIndexPatch:indexPath viewType:listType withNum:keyString];
//    }
}

- (void)FootListTableViewCell:(FootListTableViewCell *)cell macthTouch:(BOOL)macthBool teamButtonTouch:(BOOL)teamBool indexPath:(NSIndexPath *)indexPath dict:(NSDictionary *)dataDict{

    
    if (macthBool == YES && teamBool == NO) {
        if (delegateList && [delegateList respondsToSelector:@selector(listViewScrollView:macthTouch:teamButtonTouch:name:dict:)]) {
            [delegateList listViewScrollView:self macthTouch:macthBool teamButtonTouch:teamBool name:cell.macthLabel.text dict:dataDict];
        }
    }else{
        if (delegateList && [delegateList respondsToSelector:@selector(listViewScrollView:selectIndexPatch:viewType:withNum:)]) {
            [delegateList listViewScrollView:self selectIndexPatch:indexPath viewType:listType withNum:keyString];
        }
    }
    
    
   
    

}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceVertical = YES;
        self.alwaysBounceHorizontal = YES;
        self.bounces = NO;
//        self.delegate = self;
        self.backgroundColor = [UIColor colorWithRed:243/255.0 green:240/255.0 blue:232/255.0 alpha:1];//[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
        [self showAllViewFunc];
        
        self.contentOffset = CGPointMake(0, 0);
    }
    return self;
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