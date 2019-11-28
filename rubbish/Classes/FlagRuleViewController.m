//
//  FlagRuleViewController.m
//  caibo
//
//  Created by cp365dev on 14-5-28.
//
//

#import "FlagRuleViewController.h"
#import "ColorView.h"
#import "Info.h"
@interface FlagRuleViewController ()

@end

@implementation FlagRuleViewController

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
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    self.CP_navigation.titleLabel.text = @"活动规则";
    
    
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImage.image = UIImageGetImageFromName(@"login_bgn.png");
    backImage.frame = CGRectMake(0, 44, backImage.frame.size.width, backImage.frame.size.height);
    backImage.userInteractionEnabled = YES;
    backImage.backgroundColor = [UIColor clearColor];
	[self.view insertSubview:backImage atIndex:0];
    self.mainView.backgroundColor = [UIColor clearColor];
    [backImage release];
    
    
    UIImageView *hdImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 108)];
    [hdImage setImage:[UIImage imageNamed:@"flag_rule.png"]];
    [self.mainView addSubview:hdImage];
    [hdImage release];
    
    UIScrollView *myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(hdImage)+15, 320, self.mainView.frame.size.height-108-15)];
    myScrollView.userInteractionEnabled = YES;
    myScrollView.showsVerticalScrollIndicator = NO;
    myScrollView.contentSize = CGSizeMake(320, 450);
    [self.mainView addSubview:myScrollView];
    [myScrollView release];
    
    ColorView *colorview = [[ColorView alloc] initWithFrame:CGRectMake(16, 0, 320-34, 450)];
    colorview.backgroundColor = [UIColor clearColor];
    colorview.textColor = [UIColor colorWithRed:69.0/255.0 green:69.0/255.0 blue:69.0/255.0 alpha:1];
    colorview.changeColor = [UIColor colorWithRed:244.0/255.0 green:85.0/255.0 blue:45.0/255.0 alpha:1];
    colorview.font = [UIFont systemFontOfSize:14];
    colorview.colorfont = [UIFont systemFontOfSize:14];
    colorview.isN = YES;
    colorview.jianjuHeight = 12;
    colorview.text = @"1. 成功投注竞彩足球世界杯比赛并中奖的用户    ,可获 得该方案对阵中的所有国旗(不会重复    收集)。<每天一个用户最多>可收集到<8面国旗>    。(当日获得的国旗, 次日才会点亮)。\n2. 集满<10枚>国旗可获得<“大力铜杯”>\n    集满<17枚>国旗可获得<“大力银杯”>\n    集满<32枚>国旗可获得<“大力金杯”>\n3. 活动期间,得到“大力神杯”徽章的用户可参与   整点抢彩金活动,我们将在<6月18日至7月13     日>的<每周 一 、三 、五 、日18点>开放抢彩金   通道。用户需先进行短息验证方式报名。铜    杯、银杯、金杯徽章用户皆可参与整点秒杀    活动,秒杀成功即可获得相应彩金。\n4. 本活动最终解释权归投注站所有,如有疑问   请拨打客服电话:QQ：3254056760。";
    [myScrollView addSubview:colorview];
    [colorview release];
    
}
-(void)doBack
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}
-(BOOL)shouldAutorotate
{
    return NO;
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