//
//  PointInfoViewController.m
//  caibo
//
//  Created by cp365dev on 14-5-9.
//
//

#import "PointInfoViewController.h"
#import "Info.h"
#import "SharedMethod.h"
#import "ColorView.h"
@interface PointInfoViewController ()

@end

@implementation PointInfoViewController

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
    
    self.CP_navigation.leftBarButtonItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.title = @"积分说明";
	// Do any additional setup after loading the view.
    
    UIImageView *backImageV = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    backImageV.backgroundColor = [UIColor colorWithRed:240/255.0 green:239/255.0 blue:232/255.0 alpha:1];
	backImageV.frame = self.mainView.bounds;
	[self.mainView addSubview:backImageV];
	[backImageV release];

    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(17, 26, 200, 14)];
    label1.backgroundColor = [UIColor clearColor];
    label1.textColor = [SharedMethod getColorByHexString:@"454545"];
    label1.font = [UIFont boldSystemFontOfSize:14];
    label1.text = @"一、什么是积分";
    [self.mainView addSubview:label1];
    [label1 release];
    
    
    ColorView *label11 = [[ColorView alloc] initWithFrame:CGRectMake(17, ORIGIN_Y(label1)+2, 292, 91)];
    label11.text = @"   积分是投注站对用户的回馈奖励，只要日常消费就可以获得积分。购彩越多，获得的积分越多，也可以通过某些活动获得积分。";
    label11.font = [UIFont systemFontOfSize:13];
    label11.textColor = [SharedMethod getColorByHexString:@"454545"];
    label11.backgroundColor = [UIColor clearColor];
    label11.jianjuHeight = 13;
    [self.mainView addSubview:label11];
    [label11 release];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(17, ORIGIN_Y(label11)+14, 200, 14)];
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [SharedMethod getColorByHexString:@"454545"];
    label2.font = [UIFont boldSystemFontOfSize:14];
    label2.text = @"二、积分有什么用";
    [self.mainView addSubview:label2];
    [label2 release];
    
    ColorView *label21 = [[ColorView alloc] initWithFrame:CGRectMake(17, ORIGIN_Y(label2)+2, 292, 65)];
    label21.text = @"   积分可以参与多种活动，换取奖励、参与摇奖以及享有特权。";
    label21.font = [UIFont systemFontOfSize:13];
    label21.textColor = [SharedMethod getColorByHexString:@"454545"];
    label21.backgroundColor = [UIColor clearColor];
    label21.jianjuHeight = 13;
    [self.mainView addSubview:label21];
    [label21 release];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(17, ORIGIN_Y(label21)+14, 200, 14)];
    label3.backgroundColor = [UIColor clearColor];
    label3.textColor = [SharedMethod getColorByHexString:@"454545"];
    label3.font = [UIFont boldSystemFontOfSize:14];
    label3.text = @"三、积分的抽奖规则";
    [self.mainView addSubview:label3];
    [label3 release];
    
    ColorView *label31 = [[ColorView alloc] initWithFrame:CGRectMake(17, ORIGIN_Y(label3)+2, 292, 91)];
    label31.text = [NSString stringWithFormat:@"   用户可以消耗%@积分参加\"积分摇奖\"小游戏，最高奖为iPhone6。\"积分摇奖\"获得的彩金只可用于购彩，不能提现。",[[Info getInstance] choujiangXiaohao]];
    label31.font = [UIFont systemFontOfSize:13];
    label31.textColor = [SharedMethod getColorByHexString:@"454545"];
    label31.backgroundColor = [UIColor clearColor];
    label31.jianjuHeight = 13;
    [self.mainView addSubview:label31];
    [label31 release];
    
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(17, ORIGIN_Y(label31)+14, 286, 13)];
    label4.text = @"最终解释权归投注站所有";
    label4.textColor = [SharedMethod getColorByHexString:@"454545"];
    label4.backgroundColor = [UIColor clearColor];
    label4.font = [UIFont systemFontOfSize:13];
    [self.mainView addSubview:label4];
    [label4 release];

}

-(void)doBack
{
    [self.navigationController popViewControllerAnimated:YES];
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