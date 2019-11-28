//
//  YCMatchViewController.m
//  caibo
//
//  Created by houchenguang on 14-5-24.
//
//

#import "YCMatchViewController.h"
#import "Info.h"
#import "YCMatchTableViewCell.h"
#import "NetURL.h"
#import "JSON.h"
@interface YCMatchViewController ()

@end

@implementation YCMatchViewController
@synthesize httpRequest;

- (NSDictionary *)analyzeDictionary{
    return analyzeDictionary;
}

- (void)setAnalyzeDictionary:(NSDictionary *)_analyzeDictionary{
    if (analyzeDictionary != _analyzeDictionary) {
        [analyzeDictionary release];
        analyzeDictionary = [_analyzeDictionary retain];
    }

    if (analyzeDictionary && [analyzeDictionary count] > 0) {
        
        
        [self leaguerequestWithLeague:[analyzeDictionary objectForKey:@"league_id"] season:[analyzeDictionary objectForKey:@"season"] seasonType:[analyzeDictionary objectForKey:@"season_type"] lun:@""];
    }
}

- (void)dealloc{
    [dataDictionary release];
    [buffer release];
    [httpRequest clearDelegatesAndCancel];
    [httpRequest release];
    [analyzeDictionary release];
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
- (void)leaguerequestWithLeague:(NSString *)league season:(NSString *)season seasonType:(NSString *)seasonType lun:(NSString * )lun{//赔率中心数据请求
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    loadview = [[UpLoadView alloc] init];
    caiboAppDelegate *appDelegate = (caiboAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:loadview];
    [loadview release];
    [self.httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL getBFYCLCWithleague:league season:season seasonType:seasonType lun:lun]];
    [httpRequest setTimeOutSeconds:20.0];
    [httpRequest setDidFinishSelector:@selector(leagueFinish:)];
    [httpRequest setDidFailSelector:@selector(leagueFail:)];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest startAsynchronous];
    
}
- (void)alertViewFunc{
    CP_UIAlertView *alert = [[CP_UIAlertView alloc] initWithTitle:@"提醒"
                                                          message:@"暂无相关信息"
                                                         delegate:self
                                                cancelButtonTitle:@"确定"
                                                otherButtonTitles: nil];
    
    [alert show];
    [alert release];
}

- (void)leagueFail:(ASIHTTPRequest *)request{
    
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    [self alertViewFunc];
}

- (void)leagueFinish:(ASIHTTPRequest *)request{
    if (loadview) {
        [loadview stopRemoveFromSuperview];
        loadview = nil;
    }
    NSString *responseStr = [request responseString];
    NSLog(@"leagueFinish = %@", responseStr);
     NSDictionary * dict = [responseStr JSONValue];
    if (responseStr) {
       
        [dataDictionary setValue:dict forKey:[NSString stringWithFormat:@"%d", (int)[[dict objectForKey:@"lunIndex"] integerValue]]];
        
        NSLog(@"lunSize = %@", [dict objectForKey:@"lunSize"]);
        
        if ([buffer count] == 0) {
            for (int i = 0; i < [[dict objectForKey:@"lunSize"] intValue]; i++) {
                if ([[dict objectForKey:@"lunIndex"] intValue] == i) {
                    [buffer addObject:@"1"];
                }else{
                    [buffer addObject:@"0"];
                }
                
            }
        }
        
        

        
    }
    
    
    [myTableView reloadData];
    
    if (dataDictionary) {
        NSDictionary * datadict = [dataDictionary objectForKey:[NSString stringWithFormat:@"%d", [[dict objectForKey:@"lunIndex"] intValue]]];
        
        if (datadict) {
            if ([datadict objectForKey:@"lun"] && [[datadict objectForKey:@"lun"] count] > 0) {
                NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection:[[dict objectForKey:@"lunIndex"] integerValue]];
                [myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
            
        }else{
            [self alertViewFunc];
        }
        
    }
   
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
     buffer = [[NSMutableArray alloc] initWithCapacity:0];
    dataDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    myTableView = [[UITableView alloc] initWithFrame:self.mainView.bounds style:UITableViewStylePlain];
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.backgroundColor = [UIColor clearColor];
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTableView.showsVerticalScrollIndicator = NO;
    [self.mainView addSubview:myTableView];
    [myTableView release];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (buffer) {
        if ([[buffer objectAtIndex:section] integerValue] == 0) {
            return 0;
        }else{
            
            NSDictionary * dict = [dataDictionary objectForKey:[NSString stringWithFormat:@"%d", (int)section]];
            if (dict) {
                NSArray * lunarray = [dict objectForKey:@"lun"];
                if (lunarray) {
                    
                    return [lunarray count];
                    
                }
                return 0;
            }
           
        }
       
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (buffer) {
        return [buffer count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
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
    if (buffer) {
        if ([[buffer objectAtIndex:section] integerValue] == 0) {
            im.image =UIImageGetImageFromName(@"bdheaddakai.png");
            
            //        [bgheader setImage:im.image forState:UIControlStateNormal];
        }else{
            im.image = UIImageGetImageFromName(@"bdheadguanbi.png");//bdheadguanbi.png
            //        [bgheader setImage:im.image forState:UIControlStateNormal];
        }
    }
    
    [bgheader addSubview:im];
    [im release];
    [bgheader addTarget:self action:@selector(pressBgHeader:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * macthCountLabel = [[UILabel alloc] initWithFrame:bgheader.bounds];
    macthCountLabel.textColor = [UIColor blackColor];
    macthCountLabel.backgroundColor = [UIColor clearColor];
    macthCountLabel.textAlignment = NSTextAlignmentCenter;
    macthCountLabel.font = [UIFont boldSystemFontOfSize:15];
    macthCountLabel.text = [NSString stringWithFormat:@"%d轮", (int)section+1];
    [bgheader addSubview:macthCountLabel];
    [macthCountLabel release];
    

    
    return bgheader;
}

- (void)pressBgHeader:(UIButton *)sender{
    NSLog(@"tag = %d", (int)sender.tag);
    if ([[buffer objectAtIndex:sender.tag] integerValue] == 0) {
        [buffer replaceObjectAtIndex:sender.tag withObject:@"1"];
        
        if (![dataDictionary objectForKey:[NSString stringWithFormat:@"%d", (int)sender.tag]]) {
            [self leaguerequestWithLeague:[analyzeDictionary objectForKey:@"league_id"] season:[analyzeDictionary objectForKey:@"season"] seasonType:[analyzeDictionary objectForKey:@"season_type"] lun:[NSString stringWithFormat:@"%d", (int)sender.tag]];
            
        }else{
            [myTableView reloadData];
            if (dataDictionary) {
                NSDictionary * datadict = [dataDictionary objectForKey:[NSString stringWithFormat:@"%d", (int)sender.tag]];
                
                if (datadict) {
                    if ([datadict objectForKey:@"lun"] && [[datadict objectForKey:@"lun"] count] > 0) {
                        NSIndexPath *  indexPath = [NSIndexPath indexPathForRow:0 inSection: sender.tag];
                        [myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    }
                    
                }
                
            }
           
        }
       
    }else{
        [buffer replaceObjectAtIndex:sender.tag withObject:@"0"];
        [myTableView reloadData];
    }
    
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"SCell";
    
    YCMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[YCMatchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary * dict = [dataDictionary objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.section]];
    NSArray * lunArray = [dict objectForKey:@"lun"];
    if (dict) {
        if (lunArray) {
             cell.dataDictionary = [lunArray objectAtIndex:indexPath.row];
        }else{
            cell.dataDictionary = nil;
        }
        
    }else{
        cell.dataDictionary = nil;
    }

   
    
    return cell;
    
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