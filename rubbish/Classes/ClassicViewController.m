//
//  ClassicViewController.m
//  caibo
//
//  Created by cp365dev on 14-6-24.
//
//

#import "ClassicViewController.h"
#import "NetURL.h"
#import "Info.h"
#import "LotteryNewsCell.h"
#import "NewsData.h"
#import "DetailedViewController.h"
#import "JSON.h"
#import "SharedDefine.h"

@interface ClassicViewController ()

@end

@implementation ClassicViewController
@synthesize autoRequest;
//@synthesize moreCell;
@synthesize mTableView;
//@synthesize mRefreshView;
@synthesize newsRequest;
@synthesize questionType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if([self.questionType isEqualToString:@"1"])
        self.CP_navigation.title = @"经典问题";
    else
        self.CP_navigation.title = @"近期问题";
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = left;
    
    UIButton *rigthItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rigthItem.bounds = CGRectMake(0, 0, 60, 44);
    [rigthItem addTarget:self action:@selector(doPushHomeView) forControlEvents:UIControlEventTouchUpInside];
    [rigthItem setTitle:@"首页" forState:UIControlStateNormal];
    
    UIBarButtonItem *rigthItemButton = [[UIBarButtonItem alloc] initWithCustomView:rigthItem];
    self.CP_navigation.rightBarButtonItem = rigthItemButton;
    [rigthItemButton release];
    

    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];
    
    quesArray = [[NSMutableArray alloc] initWithCapacity:0];
    upArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.mainView.bounds.size.height-64) style:UITableViewStylePlain];
    mTableView.backgroundColor = [UIColor clearColor];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    [self.mainView addSubview:mTableView];
    
    
    [self getQuestionList];
}
-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)doPushHomeView{
    [[caiboAppDelegate getAppDelegate] switchToHomeView];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)getQuestionList
{
    [autoRequest clearDelegatesAndCancel];
    self.autoRequest = [ASIHTTPRequest requestWithURL:[NetURL getAutoResponseListWithType:self.questionType]];
    [autoRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [autoRequest setDelegate:self];
    [autoRequest setTimeOutSeconds:10];
    [autoRequest setDidFinishSelector:@selector(requestGetQuestionFinished:)];
    [autoRequest startAsynchronous];
}
-(void)requestGetQuestionFinished:(ASIHTTPRequest *)request
{
    NSString *result = [request responseString];
    NSLog(@"responseString : %@",result);
    if(result && ![result isEqualToString:@"fail"])
    {
        NSMutableArray *array = [result JSONValue];
        if(result){
            
            
            for (NSDictionary * dic in array) {
                NewsData * newsdata = [[NewsData alloc] init];
                newsdata.newstitle = [dic objectForKey:@"newstitle"];
                newsdata.newstime = [dic  objectForKey:@"date_created"];
                newsdata.newsid = [dic objectForKey:@"topicId"];
                newsdata.laizi = [dic objectForKey:@"date_created"];
                newsdata.content = [dic valueForKey:@"rec_content"];
                newsdata.timeformate = [dic valueForKey:@"timeformate"];
                
//                newsdata.count_zf = [dic valueForKey:@"count_zf"];
//                if (!newsdata.count_zf || [newsdata.count_zf length] <= 0) {
//                    newsdata.count_zf = @"0";
//                }
//                
//                newsdata.count_pl =  [dic valueForKey:@"count_pl"];
//                if (!newsdata.count_pl || [newsdata.count_pl length] <= 0) {
//                    newsdata.count_pl = @"0";
//                }
                
                
                newsdata.type = [NSString stringWithFormat:@"%@", [dic objectForKey:@"news_type"] ];
                
                if ([newsdata.type isEqualToString:@"3"]) {
                    newsdata.attach_small = [dic valueForKey:@"image_b"];//@"attach_small"];//
                    newsdata.attach_small = [NSString stringWithFormat:@"http://fimg.cmwb.com%@", newsdata.attach_small];
                    [upArray addObject:newsdata];
                }else{
                    newsdata.attach_small = [dic valueForKey:@"image_s"];//@"attach_small"];//
                    newsdata.attach_small = [NSString stringWithFormat:@"http://fimg.cmwb.com%@", newsdata.attach_small];
                    [quesArray addObject:newsdata];
                }
                [newsdata release];
            }
            
        }
        
        
        
        [mTableView reloadData];

    }
}
#pragma mark UITableView DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [quesArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return WEIBO_YUCE_CELL_HEIGHT;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * CellIdentifier = @"TopicCell";
    
    LotteryNewsCell *cell =(LotteryNewsCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        
        cell = [[[LotteryNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell xianHidden];
    
    if(quesArray && quesArray.count)
    {
        NewsData *pic = [quesArray objectAtIndex:indexPath.row];
        
        YtTopic *status = [[YtTopic alloc] init];
        status.content = pic.content;
        status.timeformate = pic.timeformate;
        status.attach_small = pic.attach_small;
        status.count_pl = pic.count_pl;
        status.count_zf = pic.count_zf;
        status.newstitle = pic.newstitle;
        [cell LoadData:status];
        [status release];
    }

    return cell;
        
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsData *mStatus = [quesArray objectAtIndex:indexPath.row];
    // 针对6条新闻推送先获取最新数据再跳转到微博正文页
    
    if (mStatus.newsid) {
        [newsRequest clearDelegatesAndCancel];
        self.newsRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:mStatus.newsid]];
    // self.newsRequest = [ASIHTTPRequest requestWithURL:[NetURL CBgetTopicListById:@"74259343"]];
        [newsRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
        [newsRequest setDelegate:self];
        [newsRequest setDidFinishSelector:@selector(newsInfo:)];
        [newsRequest setTimeOutSeconds:20.0];
        [newsRequest startAsynchronous];
        return;
    }
}

- (void)newsInfo:(ASIHTTPRequest *)request {
    NSString *result = [request responseString];
    YtTopic *mStatus = [[YtTopic alloc] initWithParse:result];
    
    DetailedViewController *detailed = [[DetailedViewController alloc] initWithMessage:[[mStatus arrayList] objectAtIndex:0]];//微博
    [detailed setHidesBottomBarWhenPushed:YES];
    detailed.isAutoQuestion = YES;
    [self.navigationController pushViewController:detailed animated:YES];
    [detailed release];
    
    [mStatus release];
}


-(void)dealloc
{
    [mTableView release];
    [quesArray release];
    [super dealloc];
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