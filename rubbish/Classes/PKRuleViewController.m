//
//  PKRuleViewController.m
//  caibo
//
//  Created by cp365dev6 on 15/1/30.
//
//

#import "PKRuleViewController.h"

@interface PKRuleViewController ()

@end

@implementation PKRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self loadIphoneView];
    [self loadIphoneView2];
    
}
-(void)loadIphoneView2
{
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    self.CP_navigation.title = @"规则说明";
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    bgimage.userInteractionEnabled = YES;
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    UIImageView *headerIma = [[UIImageView alloc]init];
    headerIma.frame = CGRectMake(0, 0, bgimage.frame.size.width, 125);
    headerIma.backgroundColor = [UIColor clearColor];
    headerIma.image = [UIImage imageNamed:@"PKRankListBanner.png"];
    [bgimage addSubview:headerIma];
    [headerIma release];
    
    UILabel *ruleLab1 = [[UILabel alloc]init];
    ruleLab1.frame = CGRectMake(15, headerIma.frame.size.height + 17, bgimage.frame.size.width - 30, 17);
    ruleLab1.backgroundColor = [UIColor clearColor];
    ruleLab1.text = @"1、报名成功后即可参与竞彩PK赛。";
    ruleLab1.font = [UIFont systemFontOfSize:15];
    ruleLab1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab1];
    [ruleLab1 release];
    
    UILabel *ruleLab21 = [[UILabel alloc]init];
    ruleLab21.frame = CGRectMake(15, ruleLab1.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab21.backgroundColor = [UIColor clearColor];
    ruleLab21.text = @"2、每期每个用户只能投注一个方案，过关";
    ruleLab21.font = [UIFont systemFontOfSize:15];
    ruleLab21.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab21];
    [ruleLab21 release];
    
    UILabel *ruleLab22 = [[UILabel alloc]init];
    ruleLab22.frame = CGRectMake(15, ruleLab21.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab22.backgroundColor = [UIColor clearColor];
    ruleLab22.text = @"方式仅限2串1、3串1、4串1；";
    ruleLab22.font = [UIFont systemFontOfSize:15];
    ruleLab22.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab22];
    [ruleLab22 release];
    
    UILabel *ruleLab31 = [[UILabel alloc]init];
    ruleLab31.frame = CGRectMake(15, ruleLab22.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab31.backgroundColor = [UIColor clearColor];
    ruleLab31.text = @"3、每期奖池10000积分，每期的虚拟盈利";
    ruleLab31.font = [UIFont systemFontOfSize:15];
    ruleLab31.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab31];
    [ruleLab31 release];
    
    UILabel *ruleLab32 = [[UILabel alloc]init];
    ruleLab32.frame = CGRectMake(15, ruleLab31.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab32.backgroundColor = [UIColor clearColor];
    ruleLab32.text = @"排行前三名获得相应奖励。虚拟盈利=虚拟";
    ruleLab32.font = [UIFont systemFontOfSize:15];
    ruleLab32.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab32];
    [ruleLab32 release];
    
    UILabel *ruleLab322 = [[UILabel alloc]init];
    ruleLab322.frame = CGRectMake(15, ruleLab32.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab322.backgroundColor = [UIColor clearColor];
    ruleLab322.text = @"中奖金额－虚拟投入金额。";
    ruleLab322.font = [UIFont systemFontOfSize:15];
    ruleLab322.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab322];
    [ruleLab322 release];
    
    UILabel *ruleLab33 = [[UILabel alloc]init];
    ruleLab33.frame = CGRectMake(15, ruleLab322.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab33.backgroundColor = [UIColor clearColor];
    ruleLab33.text = @"1）第一名奖励5000积分；";
    ruleLab33.font = [UIFont systemFontOfSize:15];
    ruleLab33.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab33];
    [ruleLab33 release];
    
    UILabel *ruleLab34 = [[UILabel alloc]init];
    ruleLab34.frame = CGRectMake(15, ruleLab33.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab34.backgroundColor = [UIColor clearColor];
    ruleLab34.text = @"2）第二名奖励3000积分；";
    ruleLab34.font = [UIFont systemFontOfSize:15];
    ruleLab34.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab34];
    [ruleLab34 release];
    
    UILabel *ruleLab35 = [[UILabel alloc]init];
    ruleLab35.frame = CGRectMake(15, ruleLab34.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab35.backgroundColor = [UIColor clearColor];
    ruleLab35.text = @"3）第三名奖励2000积分；";
    ruleLab35.font = [UIFont systemFontOfSize:15];
    ruleLab35.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab35];
    [ruleLab35 release];
    
    UILabel *ruleLab41 = [[UILabel alloc]init];
    ruleLab41.frame = CGRectMake(15, ruleLab35.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab41.backgroundColor = [UIColor clearColor];
    ruleLab41.text = @"4、出现并列情况按投注时间先后顺序排名,";
    ruleLab41.font = [UIFont systemFontOfSize:15];
    ruleLab41.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab41];
    [ruleLab41 release];
    
    UILabel *ruleLab42 = [[UILabel alloc]init];
    ruleLab42.frame = CGRectMake(15, ruleLab41.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab42.backgroundColor = [UIColor clearColor];
    ruleLab42.text = @"若该期无人中奖，奖池自动清零。奖励积分";
    ruleLab42.font = [UIFont systemFontOfSize:15];
    ruleLab42.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab42];
    [ruleLab42 release];
    
    UILabel *ruleLab43 = [[UILabel alloc]init];
    ruleLab43.frame = CGRectMake(15, ruleLab42.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab43.backgroundColor = [UIColor clearColor];
    ruleLab43.text = @"在每期结束后统一派发。";
    ruleLab43.font = [UIFont systemFontOfSize:15];
    ruleLab43.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab43];
    [ruleLab43 release];
    
    UILabel *ruleLab5 = [[UILabel alloc]init];
    ruleLab5.frame = CGRectMake(15, ruleLab43.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab5.backgroundColor = [UIColor clearColor];
    ruleLab5.text = @"5、投注站拥有此次活动的最终解释权。";
    ruleLab5.font = [UIFont systemFontOfSize:15];
    ruleLab5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab5];
    [ruleLab5 release];
}
-(void)loadIphoneView
{
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = leftItem;
    self.CP_navigation.title = @"规则说明";
    UIImageView * bgimage = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgimage.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    bgimage.userInteractionEnabled = YES;
    [self.mainView addSubview:bgimage];
    [bgimage release];
    
    UIImageView *headerIma = [[UIImageView alloc]init];
    headerIma.frame = CGRectMake(0, 0, bgimage.frame.size.width, 125);
    headerIma.backgroundColor = [UIColor clearColor];
    headerIma.image = [UIImage imageNamed:@"PKRankListBanner.png"];
    [bgimage addSubview:headerIma];
    [headerIma release];
    
    UILabel *ruleLab1 = [[UILabel alloc]init];
    ruleLab1.frame = CGRectMake(15, headerIma.frame.size.height + 17, bgimage.frame.size.width - 30, 17);
    ruleLab1.backgroundColor = [UIColor clearColor];
    ruleLab1.text = @"1、游戏为模拟投注竞彩足球胜平负(过关)从竞彩足球每";
    ruleLab1.font = [UIFont systemFontOfSize:12];
    ruleLab1.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab1];
    [ruleLab1 release];
    
    UILabel *ruleLab12 = [[UILabel alloc]init];
    ruleLab12.frame = CGRectMake(15, ruleLab1.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab12.backgroundColor = [UIColor clearColor];
    ruleLab12.text = @"天的对阵中选取四场进行模拟投注。";
    ruleLab12.font = [UIFont systemFontOfSize:12];
    ruleLab12.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab12];
    [ruleLab12 release];
    
    UILabel *ruleLab13 = [[UILabel alloc]init];
    ruleLab13.frame = CGRectMake(15, ruleLab12.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab13.backgroundColor = [UIColor clearColor];
    ruleLab13.text = @"     竞猜完全免费,每期可参加1次。";
    ruleLab13.font = [UIFont systemFontOfSize:12];
    ruleLab13.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab13];
    [ruleLab13 release];
    
    UILabel *ruleLab2 = [[UILabel alloc]init];
    ruleLab2.frame = CGRectMake(15, ruleLab13.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab2.backgroundColor = [UIColor clearColor];
    ruleLab2.text = @"2、竞猜正确显示的模拟中奖金额,并非真实中奖。";
    ruleLab2.font = [UIFont systemFontOfSize:12];
    ruleLab2.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab2];
    [ruleLab2 release];
    
    UILabel *ruleLab3 = [[UILabel alloc]init];
    ruleLab3.frame = CGRectMake(15, ruleLab2.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab3.backgroundColor = [UIColor clearColor];
    ruleLab3.text = @"3、收益=模拟奖金 – 虚拟购彩金额。";
    ruleLab3.font = [UIFont systemFontOfSize:12];
    ruleLab3.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab3];
    [ruleLab3 release];
    
    UILabel *ruleLab4 = [[UILabel alloc]init];
    ruleLab4.frame = CGRectMake(15, ruleLab3.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab4.backgroundColor = [UIColor clearColor];
    ruleLab4.text = @"4、竞彩足球只竞猜比赛全场90分钟(含伤停补时)的赛";
    ruleLab4.font = [UIFont systemFontOfSize:12];
    ruleLab4.numberOfLines = 0;
    ruleLab4.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab4];
    [ruleLab4 release];
    
    UILabel *ruleLab42 = [[UILabel alloc]init];
    ruleLab42.frame = CGRectMake(15, ruleLab4.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab42.backgroundColor = [UIColor clearColor];
    ruleLab42.text = @"果,不包括加时赛和点球。";
    ruleLab42.font = [UIFont systemFontOfSize:12];
    ruleLab42.numberOfLines = 0;
    ruleLab42.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab42];
    [ruleLab42 release];//
    
    UILabel *ruleLab5 = [[UILabel alloc]init];
    ruleLab5.frame = CGRectMake(15, ruleLab42.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab5.backgroundColor = [UIColor clearColor];
    ruleLab5.text = @"5、排行榜每周更新1次,周榜前3名有积分奖励：";
    ruleLab5.font = [UIFont systemFontOfSize:12];
    ruleLab5.numberOfLines = 0;
    ruleLab5.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab5];
    [ruleLab5 release];
    
    UILabel *ruleLab51 = [[UILabel alloc]init];
    ruleLab51.frame = CGRectMake(15, ruleLab5.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab51.backgroundColor = [UIColor clearColor];
    ruleLab51.text = @"     第一名：5000积分";
    ruleLab51.font = [UIFont systemFontOfSize:12];
    ruleLab51.numberOfLines = 0;
    ruleLab51.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab51];
    [ruleLab51 release];
    
    UILabel *ruleLab52 = [[UILabel alloc]init];
    ruleLab52.frame = CGRectMake(15, ruleLab51.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab52.backgroundColor = [UIColor clearColor];
    ruleLab52.text = @"     第二名：3000积分";
    ruleLab52.font = [UIFont systemFontOfSize:12];
    ruleLab52.numberOfLines = 0;
    ruleLab52.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab52];
    [ruleLab52 release];
    
    UILabel *ruleLab53 = [[UILabel alloc]init];
    ruleLab53.frame = CGRectMake(15, ruleLab52.frame.origin.y + 17, bgimage.frame.size.width - 30, 17);
    ruleLab53.backgroundColor = [UIColor clearColor];
    ruleLab53.text = @"     第三名：2000积分";
    ruleLab53.font = [UIFont systemFontOfSize:12];
    ruleLab53.numberOfLines = 0;
    ruleLab53.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab53];
    [ruleLab53 release];
    
    UILabel *ruleLab6 = [[UILabel alloc]init];
    ruleLab6.frame = CGRectMake(15, ruleLab53.frame.origin.y + 17 + 10, bgimage.frame.size.width - 30, 17);
    ruleLab6.backgroundColor = [UIColor clearColor];
    ruleLab6.text = @"* 若排名相同,会按照时间先后顺序决定获奖用户。";
    ruleLab6.font = [UIFont systemFontOfSize:12];
    ruleLab6.numberOfLines = 0;
    ruleLab6.textColor = [UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [bgimage addSubview:ruleLab6];
    [ruleLab6 release];
    
    
}
- (void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    