//
//  BFYCIntroViewController.m
//  caibo
//
//  Created by houchenguang on 14-5-27.
//
//

#import "BFYCIntroViewController.h"
#import "Info.h"
#import "ASIHTTPRequest.h"
#import "NetURL.h"
#import "JSON.h"

@interface BFYCIntroViewController ()

@end

@implementation BFYCIntroViewController
@synthesize playid;
@synthesize httpRequest;

- (void)dealloc{
    [playid release];
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = nil;
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	[self.CP_navigation setLeftBarButtonItem:leftItem];
    
    
    [httpRequest clearDelegatesAndCancel];
    self.httpRequest = [ASIHTTPRequest requestWithURL:[NetURL BFgetDescriptionByPlayID:playid]];
    [httpRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [httpRequest setDelegate:self];
    [httpRequest setDidFinishSelector:@selector(requestFinished:)];
    [httpRequest setTimeOutSeconds:10];
    [httpRequest startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	NSString *responseStr = [request responseString];
    if ([responseStr length] && ![responseStr isEqualToString:@"fail"])
    {
        NSDictionary * descriptionDic = [responseStr JSONValue];
        if (![[descriptionDic valueForKey:@"code"] intValue]) {
            UILabel * contentLabel = [[[UILabel alloc] initWithFrame:CGRectMake(0, self.mainView.frame.size.height/2 - 7 , 320, 15)] autorelease];
            contentLabel.text = @"暂无";
            contentLabel.textAlignment = 1;
            contentLabel.backgroundColor = [UIColor clearColor];
            contentLabel.textColor = [UIColor blackColor];
            [self.mainView addSubview:contentLabel];
        }else{
            UIScrollView * scrollView = [[[UIScrollView alloc] initWithFrame:self.mainView.bounds] autorelease];
            [self.mainView addSubview:scrollView];
            
            NSArray * titleArray = @[@"赛前简报",@"赛前简析"];
            NSArray * contentKeyArray = @[@"sqjb",@"ssjx"];
            
            float newY = 0;
            
            for (int i = 0; i < 2; i++) {
                UIImageView * titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, newY + 17.5, 93, 29)];
                titleImageView.image = UIImageGetImageFromName(@"AboutUs_events.png");
                [scrollView addSubview:titleImageView];
                [titleImageView release];
                
                UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 73, 29)];
                titleLabel.text = [titleArray objectAtIndex:i];
                titleLabel.textColor = [UIColor whiteColor];
                titleLabel.backgroundColor = [UIColor clearColor];
                [titleImageView addSubview:titleLabel];
                [titleLabel release];
                
                UILabel * contentLabel = [[UILabel alloc] init];
                contentLabel.backgroundColor = [UIColor clearColor];
                contentLabel.textColor = [UIColor blackColor];
                contentLabel.font = [UIFont systemFontOfSize:15];
                contentLabel.text = [descriptionDic valueForKey:[contentKeyArray objectAtIndex:i]];
                contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
                contentLabel.numberOfLines = 0;
                CGSize textViewSize = [contentLabel.text sizeWithFont:contentLabel.font constrainedToSize:CGSizeMake(280, 10000) lineBreakMode:NSLineBreakByWordWrapping];
                contentLabel.frame = CGRectMake(20, ORIGIN_Y(titleImageView) + 16, 280, textViewSize.height);
                [scrollView addSubview:contentLabel];
                [contentLabel release];
                
                newY = ORIGIN_Y(contentLabel);
            }
            scrollView.contentSize = CGSizeMake(280, newY + 15);
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    