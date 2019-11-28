//
//  RankingListViewController.m
//  caibo
//
//  Created by houchenguang on 14-3-13.
//
//

#import "RankingListViewController.h"
#import "Info.h"
#import "RankingListTableViewCell.h"
#import "NetURL.h"
#import "JSON.h"

@interface RankingListViewController ()

@end

@implementation RankingListViewController
@synthesize httpRequest;

- (void)dealloc{
    [sortDateArray release];
    [countArray release];
    [dateDictionary release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (void)doBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rankingListDate{
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL rankingListDateRequest]];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(dateRequestFinishSelector:)];
    [httpRequest setNumberOfTimesToRetryOnTimeout:2];
    [httpRequest startAsynchronous];

}


- (void)sortFunc:(NSArray *)keys{
    NSMutableArray *dataArray=[[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i = 0; i < [keys count]; i++) {
        NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
        [dir setObject:[keys objectAtIndex:i] forKey:@"time"];
        [dataArray addObject:dir];
        [dir release];
    }
    
    
    
    NSMutableArray *myArray=[[NSMutableArray alloc]initWithCapacity:0];
    [myArray addObjectsFromArray:dataArray];
    [dataArray release];
    
    for (int i=0; i<[myArray count]; i++) {
        NSLog(@"排序前----->>%@",[[myArray objectAtIndex:i] objectForKey:@"time"]);
    }
    
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"time" ascending:YES];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[myArray sortedArrayUsingDescriptors:sortDescriptors];
    [sorter release];
//    sortDateArray = [NSMutableArray arrayWithArray:sortArray];
    for (NSDictionary * dict in sortArray) {
        [sortDateArray addObject:[dict objectForKey:@"time"]];
    }
    
    
    for (int i=0; i<[sortArray count]; i++) {
        NSLog(@"排序后----->>%@",[[sortArray objectAtIndex:i] objectForKey:@"time"]);
    }
    
    [myArray release];
    [sortDescriptors release];
}

- (void)dateRequestFinishSelector:(ASIHTTPRequest *)mrequest{
    NSString *responseString = [mrequest responseString];
    if(responseString){
        
        
        NSArray * allarr = [responseString JSONValue];
//        NSDictionary  * dict = [responseString JSONValue];
        
//        NSArray * keys = [dict allKeys];
        
//        [self sortFunc:keys];
        
        for (int n = 0; n < [allarr count]; n++) {
            NSDictionary * dict = [allarr objectAtIndex:n];
            NSArray * keys = [dict allKeys];
            for (int i = 0; i < [keys count]; i++) {
                NSArray * dataArray = [dict objectForKey:[keys objectAtIndex:i]];
                NSMutableArray * dataarr = [[NSMutableArray alloc] initWithCapacity:0];
                
                for (int j = 0; j < [dataArray count]; j++) {
                    NSDictionary * dataDict = [dataArray objectAtIndex:j];
                    AnnouncementData * ann = [[AnnouncementData alloc] init];
                    ann.money = [dataDict objectForKey:@"awardMoney"];
                    ann.userName = [dataDict objectForKey:@"userName"];
                    NSLog(@"anndata = %@",[dataDict objectForKey:@"awardMoney"]);
                    ann.level1 = [dataDict objectForKey:@"level1"];
                    ann.level2 = [dataDict objectForKey:@"level2"];
                    ann.level3 = [dataDict objectForKey:@"level3"];
                    ann.level4 = [dataDict objectForKey:@"level4"];
                    ann.level5 = [dataDict objectForKey:@"level5"];
                    ann.level6 = [dataDict objectForKey:@"level6"];
                    ann.imagestr = [dataDict objectForKey:@"midImage"];
                    NSLog(@"imagestr = %@", [dataDict objectForKey:@"midImage"]);
                    ann.user = [dataDict objectForKey:@"nickName"];
                    ann.userID = [dataDict objectForKey:@"userId"];
                    ann.lotteryname = [dataDict objectForKey:@"lotteryname"];
                    ann.orderid = [dataDict objectForKey:@"orderid"];
                    ann.privacy = [dataDict objectForKey:@"privacy"];
                    [dataarr addObject:ann];
                    [ann release];
                }
                [dateDictionary setObject:dataarr forKey:[keys objectAtIndex:i]];
                [sortDateArray addObject:[keys objectAtIndex:i]];
                [dataarr release];
            }
            
        }
       
        
        if ([[dateDictionary allKeys] count] == 3) {
            buffer[2] = 1;
        }
    }
    [myTableview reloadData];
}

- (void)rankingListCount{

    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL rankingListCountRequest]];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(countRequestFinishSelector:)];
    [httpRequest setNumberOfTimesToRetryOnTimeout:2];
    [httpRequest startAsynchronous];
}

- (void)countRequestFinishSelector:(ASIHTTPRequest *)mrequest{

    NSString *responseString = [mrequest responseString];
    if(responseString){
        NSArray * arrayAll = [responseString JSONValue];
        for (int i = 0; i < [arrayAll count]; i++) {
    
                NSDictionary * dataDict = [arrayAll objectAtIndex:i];
                AnnouncementData * ann = [[AnnouncementData alloc] init];
                ann.money = [dataDict objectForKey:@"awardMoney"];
                ann.userName = [dataDict objectForKey:@"userName"];
                NSLog(@"anndata = %@",[dataDict objectForKey:@"awardMoney"]);
                ann.level1 = [dataDict objectForKey:@"level1"];
                ann.level2 = [dataDict objectForKey:@"level2"];
                ann.level3 = [dataDict objectForKey:@"level3"];
                ann.level4 = [dataDict objectForKey:@"level4"];
                ann.level5 = [dataDict objectForKey:@"level5"];
                ann.level6 = [dataDict objectForKey:@"level6"];
                ann.imagestr = [dataDict objectForKey:@"midImage"];
                NSLog(@"imagestr = %@", [dataDict objectForKey:@"midImage"]);
                ann.user = [dataDict objectForKey:@"nickName"];
                ann.userID = [dataDict objectForKey:@"userId"];
                ann.lotteryname = [dataDict objectForKey:@"lotteryname"];
                ann.orderid = [dataDict objectForKey:@"orderid"];
                ann.privacy = [dataDict objectForKey:@"privacy"];
            NSLog(@"ann.privacy = %@", ann.privacy);
                [countArray addObject:ann];
                [ann release];

        }
    
    }
    [myTableview reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sortDateArray = [[NSMutableArray alloc] initWithCapacity:0];
    dateDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    countArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.CP_navigation.title = @"红人榜";
     self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    
    UIImageView *backImageV = [[UIImageView alloc] initWithImage:UIImageGetImageFromName(@"login_bgn.png")];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];
    
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mainView.frame.size.width, 76)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:headView];
    [headView release];
    
    
    UIButton * dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dateButton.frame = CGRectMake(15, 41, 96, 31);
    dateButton.tag = 1;
    [dateButton setBackgroundImage:UIImageGetImageFromName(@"rankingButton.png") forState:UIControlStateNormal];
    [dateButton addTarget:self action:@selector(pressRankingListButton:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:dateButton];
    
    
    UILabel * dateLabel = [[UILabel alloc] initWithFrame:dateButton.bounds];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.text = @"日 榜";
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.font = [UIFont boldSystemFontOfSize:17];
    [dateButton addSubview:dateLabel];
    [dateLabel release];
    
    dateSelectImage = [[UIImageView alloc] initWithFrame:CGRectMake(dateButton.frame.origin.x, dateButton.frame.origin.y+dateButton.frame.size.height, dateButton.frame.size.width, 4)];
    dateSelectImage.backgroundColor = [UIColor colorWithRed:151/255.0 green:40/255.0 blue:1/255.0 alpha:1];
    dateSelectImage.tag = 11;
    
    [headView addSubview:dateSelectImage];
    [dateSelectImage release];
    
    
    UIImageView * headImage = [[UIImageView alloc] initWithFrame:CGRectMake(114, 10, 93, 62.5)];
    headImage.backgroundColor = [UIColor clearColor];
    headImage.image = UIImageGetImageFromName(@"rangkingBigImage.png");
    [headView addSubview:headImage];
    [headImage release];
    
    
    UIButton * countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    countButton.frame = CGRectMake(209, 41, 96, 31);
    countButton.tag = 2;
    [countButton addTarget:self action:@selector(pressRankingListButton:) forControlEvents:UIControlEventTouchUpInside];
    [countButton setBackgroundImage:UIImageGetImageFromName(@"rankingButton.png") forState:UIControlStateNormal];
    [headView addSubview:countButton];
    
    UILabel * countLabel = [[UILabel alloc] initWithFrame:countButton.bounds];
    countLabel.backgroundColor = [UIColor clearColor];
    countLabel.text = @"总 榜";
    countLabel.textColor = [UIColor whiteColor];
    countLabel.textAlignment = NSTextAlignmentCenter;
    countLabel.font = [UIFont boldSystemFontOfSize:17];
    [countButton addSubview:countLabel];
    [countLabel release];
    
//    countSelectImage = [[UIImageView alloc] initWithFrame:CGRectMake(countButton.frame.origin.x, countButton.frame.origin.y+countButton.frame.size.height, countButton.frame.size.width, 4)];
//    countSelectImage.backgroundColor = [UIColor clearColor];
//    countSelectImage.tag = 12;
//    countSelectImage.hidden = YES;
//    countSelectImage.image = UIImageGetImageFromName(@"selectRankingImage.png");
//    [headView addSubview:countSelectImage];
//    [countSelectImage release];
    
    
    UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 75.5, self.mainView.frame.size.width, 0.5)];
    lineImage.backgroundColor = [UIColor colorWithRed:120/255.0 green:24/255.0 blue:6/255.0 alpha:1];
    [headView addSubview:lineImage];
    [lineImage release];
    
    myTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 76, self.mainView.frame.size.width,  self.mainView.frame.size.height - 76 - 49) style:UITableViewStylePlain];
    myTableview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    myTableview.delegate = self;
    myTableview.dataSource = self;
    myTableview.backgroundColor = [UIColor clearColor];
    [myTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.mainView addSubview:myTableview];
    
    [self rankingListDate];
    
}

- (void)pressRankingListButton:(UIButton *)sender{

    
    if (sender.tag == 1) {
//        dateSelectImage.hidden = NO;
//        countSelectImage.hidden = YES;
        selectButton = NO;
        if ([dateDictionary count] == 0) {
            [self rankingListDate];
        }
        
    }else{
//        dateSelectImage.hidden = YES;
//        countSelectImage.hidden = NO;
        selectButton = YES;
        if ([countArray count] == 0) {
            [self rankingListCount];
        }
    }
    
    [UIView beginAnimations:@"ndd" context:NULL];
    [UIView setAnimationDuration:.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    

    dateSelectImage.frame = CGRectMake(sender.frame.origin.x, sender.frame.origin.y+sender.frame.size.height, sender.frame.size.width, 4);

    
    [UIView commitAnimations];
    
    [myTableview reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (selectButton == NO) {
        NSArray * keys = [dateDictionary allKeys];
        return [keys count];
    }else{
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (selectButton == NO) {
        if (buffer[section] == 1) {
            
      
            NSMutableArray * dateArr = [dateDictionary objectForKey:[sortDateArray objectAtIndex:section]];
            
            return [dateArr count];
        }else{
            return 0;
        }
        
    }else{
        return [countArray count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (selectButton == NO) {
        return 44;
    }else{
        return 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIButton * bgheader = [UIButton buttonWithType:UIButtonTypeCustom];
    bgheader.tag = section;
    bgheader.frame = CGRectMake(0, 0, 320, 44);
    bgheader.backgroundColor = [UIColor clearColor];
    
    UIImageView * buttonbg = [[UIImageView alloc] initWithFrame:bgheader.bounds];
    buttonbg.backgroundColor = [UIColor clearColor];
    buttonbg.image = [UIImageGetImageFromName(@"bdheadbg.png") stretchableImageWithLeftCapWidth:8 topCapHeight:10];
    [bgheader addSubview:buttonbg];
    [buttonbg release];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(293, (44-9)/2, 12.5, 9)];
    
    if (buffer[section] == 0) {
        im.image =UIImageGetImageFromName(@"bdheadguanbi.png");
        
        //        [bgheader setImage:im.image forState:UIControlStateNormal];
    }else{
        im.image = UIImageGetImageFromName(@"bdheaddakai.png");
        //        [bgheader setImage:im.image forState:UIControlStateNormal];
    }
    [bgheader addSubview:im];
    [im release];
    [bgheader addTarget:self action:@selector(pressBgHeader:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * timelabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 294, 44)];
    timelabel.textColor = [UIColor blackColor];//[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1];
    timelabel.backgroundColor = [UIColor clearColor];
    timelabel.textAlignment = NSTextAlignmentLeft;
    timelabel.font = [UIFont boldSystemFontOfSize:11];
//    timelabel.text = @"2014年3月2日";
    [bgheader addSubview:timelabel];
    [timelabel release];
    
    if ([sortDateArray count] > section) {
        NSString * datestr = [sortDateArray objectAtIndex:section];
        NSArray * strarr = [datestr componentsSeparatedByString:@"-"];
        if ([strarr count] == 3) {
            timelabel.text = [NSString stringWithFormat:@"%@年%@月%@日", [strarr objectAtIndex:0], [strarr objectAtIndex:1], [strarr objectAtIndex:2]];
        }
    }
    
   
    
    
    return bgheader;
}
- (void)pressBgHeader:(UIButton *)sender{
    if (buffer[sender.tag] == 0) {
        buffer[sender.tag] = 1;
    }else{
        buffer[sender.tag] = 0;
    }
    
    [myTableview reloadData];
    
    if (buffer[sender.tag] == 1) {
     
        if (selectButton == NO) {
            
            NSMutableArray * dateArr = [dateDictionary objectForKey:[sortDateArray objectAtIndex:sender.tag]];
            if ([dateArr count] > 0) {
               [myTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag] atScrollPosition:UITableViewScrollPositionTop animated:YES];

            }
            
            
    
        }
        
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * cellID = @"cellid";
    RankingListTableViewCell * cell = (RankingListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[RankingListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID ] autorelease];
        
    }
    cell.indexPathCell = indexPath;
    if (selectButton == NO) {
      
        NSMutableArray * dateArr = [dateDictionary objectForKey:[sortDateArray objectAtIndex:indexPath.section]];
        cell.annou = [dateArr objectAtIndex:indexPath.row];
    }else{
    
        cell.annou = [countArray objectAtIndex:indexPath.row];
    }
    
    
    return cell;



}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * orderId = @"";
    NSString * privacy = @"";
    if (selectButton == NO) {
       
        NSMutableArray * dateArr = [dateDictionary objectForKey:[sortDateArray objectAtIndex:indexPath.section]];
        AnnouncementData * annou = [dateArr objectAtIndex:indexPath.row];
        orderId = annou.orderid;
        privacy = annou.privacy;
    }else{
        
        AnnouncementData * annou = [countArray objectAtIndex:indexPath.row];
        orderId = annou.orderid;
        privacy = annou.privacy;
    }
    NSLog(@"privacy = %@", privacy);
    if (![privacy isEqualToString:@"4"]) {
        ShuangSeQiuInfoViewController *info = [[ShuangSeQiuInfoViewController alloc] init];
        info.delegate = self;
        info.orderId = orderId;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
    }else{
    
//        CP_UIAlertView * alert = [[CP_UIAlertView alloc] initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alert show];
//        [alert release];
    [[caiboAppDelegate getAppDelegate] showMessage:@"此方案被隐藏"];
//    此方案被隐藏
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    