//
//  CJBHelpViewController.m
//  caibo
//
//  Created by houchenguang on 14-5-13.
//
//

#import "CJBHelpViewController.h"
#import "Info.h"

@interface CJBHelpViewController ()

@end

@implementation CJBHelpViewController

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
    self.CP_navigation.title = @"常见问题";
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	[self.CP_navigation setLeftBarButtonItem:leftItem];
 
    UIWebView * myWebView = [[UIWebView alloc] initWithFrame:self.mainView.bounds];
	[self.mainView addSubview:myWebView];
	myWebView.delegate = self;
	[myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.dingdingcai.com/caijinintro.jsp"]]];
    [myWebView release];
    
//	UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//	loading.center = myWebView.center;
//	[myWebView addSubview:loading];
//	loading.tag = 1001;
//	[loading startAnimating];
//	[loading release];
	
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