//
//  QuestionViewController.m
//  caibo
//
//  Created by cp365dev6 on 14-8-11.
//
//

#import "QuestionViewController.h"
#import "caiboAppDelegate.h"
#import "KFMessageBoxView.h"
#import <QuartzCore/QuartzCore.h>
#import "RedactPrivLetterController.h"
#import "Info.h"
#import "LoginViewController.h"
#import "KFMessageBoxView.h"
#import "UserListMailController.h"

#define PROPOSAL_ID @"522537"
#define COMPLAINTS_ID @"433535"
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7 ? YES : NO)

@interface QuestionViewController ()

@end

@implementation QuestionViewController

@synthesize dingwei;
@synthesize question;
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
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self loadIphoneView];
    
}
-(void)loadIphoneView
{
    
//    
//    UIView *headView=[[UIView alloc]init];
//    headView.frame=CGRectMake(0, 0, 320, 44+(IOS7?20:0));
//    headView.backgroundColor=[UIColor colorWithRed:21/255.0 green:136/255.0 blue:218/255.0 alpha:1];
//    [self.mainView addSubview:headView];
//    [headView release];
//    
//    UILabel *lab=[[[UILabel alloc]initWithFrame:CGRectMake(0, headView.frame.size.height-44, 320, 44)]autorelease];
//    lab.textColor=[UIColor whiteColor];
//    lab.text=@"常见问题";
//    lab.backgroundColor=[UIColor clearColor];
//    lab.font=[UIFont systemFontOfSize:22];
//    lab.textAlignment=NSTextAlignmentCenter;
//    [headView addSubview:lab];
//    
//    UIButton *leftBtn1=[UIButton buttonWithType:UIButtonTypeCustom];
//    [leftBtn1 setImage:[UIImage imageNamed:@"wb58.png"] forState:UIControlStateNormal];
//    [leftBtn1 setImage:[UIImage imageNamed:@"wb58.png"] forState:UIControlStateHighlighted];
//    leftBtn1.frame=CGRectMake(5, headView.frame.size.height-44, 60, 44);
//    [leftBtn1 addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
//    [headView addSubview:leftBtn1];
    
    
    self.CP_navigation.title = @"常见问题";
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(backButton)];
    self.CP_navigation.leftBarButtonItem = left;
    
    
    UIView *headBaise=[[UIView alloc]init];
    headBaise.backgroundColor=[UIColor whiteColor];
    headBaise.userInteractionEnabled=YES;
    headBaise.frame=CGRectMake(0, 0, 320, 60);
    [self.mainView addSubview:headBaise];
    [headBaise release];
    
    UIButton *kbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    kbutton.frame = CGRectMake(15, 15, 137, 30);
    kbutton.backgroundColor = [UIColor clearColor];
    [kbutton setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [kbutton setTitle:@"产品改进意见" forState:UIControlStateNormal];
    [kbutton setTitleColor:[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    kbutton.tag=10;
    kbutton.titleLabel.font=[UIFont systemFontOfSize:15];
    kbutton.titleLabel.textAlignment=NSTextAlignmentCenter;
    [kbutton addTarget:self action:@selector(pressGaijinButton:) forControlEvents:UIControlEventTouchUpInside];
    [headBaise addSubview:kbutton];
    
    UIButton *faqButton = [UIButton buttonWithType:UIButtonTypeCustom];
    faqButton.frame = CGRectMake(137+31, 15, 137, 30);
    faqButton.tag=20;
    [faqButton setBackgroundImage:[UIImageGetImageFromName(@"tongyonglan.png") stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [faqButton addTarget:self action:@selector(pressGaijinButton:) forControlEvents:UIControlEventTouchUpInside];
    [headBaise addSubview:faqButton];
    UILabel *questionBtn=[[UILabel alloc]init];
    questionBtn.backgroundColor=[UIColor clearColor];
    questionBtn.frame=faqButton.bounds;
    questionBtn.text=@"服务投诉";
    questionBtn.textAlignment=NSTextAlignmentCenter;
    questionBtn.textColor=[UIColor colorWithRed:19/255.0 green:163/255.0 blue:255/255.0 alpha:1];
    questionBtn.font=[UIFont systemFontOfSize:15];
    [faqButton addSubview:questionBtn];
    [questionBtn release];
    
    UIImageView *lineIma=[[UIImageView alloc]init];
    lineIma.frame=CGRectMake(0, headBaise.frame.size.height-0.5, 320, 0.5);
    lineIma.backgroundColor=[UIColor clearColor];
    lineIma.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [headBaise addSubview:lineIma];
    [lineIma release];
    
//    UIImageView *bigIma=[[UIImageView alloc]init];
//    bigIma.backgroundColor=[UIColor cyanColor];
//    bigIma.frame=CGRectMake(0, headBaise.frame.size.height+headBaise.frame.origin.y, 320, 125);
//    [self.view addSubview:bigIma];
//    [bigIma release];
    
    isExpandedAry = [[NSMutableArray alloc]initWithCapacity:0];
    headerTextAry=[[NSArray alloc] initWithObjects:@"手机买彩票安全么？",@"如何充值？",@"充值收手续费么？",@"如何提款？提款收手续费么？",@"为什么无法参加活动？",@"中奖后，有电话通知么？",@"中奖了，如何亲自领奖？",@"中了大奖，国家征税标准是什么？",@"开奖了，为什么奖金还不到账？",@"为什么我买了彩票，还没出票？",@"在投注站买彩票，是否可以拿到纸质彩票？",@"为什么会有充值限额，或电话提醒？",@"为什么我的苹果手机不能充值？",@"为什么银联卡回拨充值，不回拨电话？",@"如何修改密码？",@"如何修改绑定的手机号？",@"为什么提款后，提款金额被冻结？",@"为什么提款失败？",@"竞彩比赛推迟如何计算奖金？",@"如何计算竞彩和单场等中奖的奖金？",@"什么是奖金优化？",@"为什么下载应用了，没有送彩金？",@"提款时，冻结资金是怎么回事？", nil];//投注站，直属于民政部中国社工协会，是中国手机彩票业内唯一国有上市公司品牌。//作为民政部中国社工协会直属单位，我们有义务承担阻止用户沉迷彩票的社会责任。投注站严格遵守国家彩票发行和管理相关政策和法规，坚决反对彩票打折、返利以及鼓励加大投入等有悖于国家政策法规的行为。买彩票做公益，每个人都需要量力而行。
    contentAry = [[NSArray alloc] initWithObjects:@"投注站是中国手机彩票业内唯一国有上市公司品牌。手机买彩票，请认准“投注站”；中大奖第一时间电话通知，安全正规有保障！",
                  @"点击“首界面”右下角 - “我的彩票”- 点击“充值”，选择支付宝、银联卡、信用卡、或移动联通电信充值卡等充值方式即可充值。",
                  @"投注站所有充值方式，均不收取任何手续费。",
                  @"点击“首界面”右下角 - “我的彩票”，点击“提款”，即可按流程提款。\n投注站提款（>10元）不收取任何手续费。",
                  @"请仔细阅读活动规则；\n参加投注站活动，请先完善个人信息并绑定手机号（手机号分为联系手机与绑定手机，绑定手机请点击“首界面”右下角 - “我的彩票”，点击“个人信息”）；同一账号、同一手机、同一身份证均视为同一用户，部分活动每用户仅参与一次。",
                  @"单注奖金超过10万元，客服会第一时间电话通知中奖用户，小奖短信通知，合买方案只通知发起人。",
                  @"您需要携带有效身份证件，到投注站公司，核实身份后，由投注站工作人员带领赴出票地领奖，但往返路费需用户个人支付。因此我们还是建议，由投注站直接派奖到您的账户，这样最方便，也是最安全的。",
                  @"根据《财政部、国家税务总局关于个人取得彩票中奖所得征免个人所得税问题的通知》（财税[1998]12号）的规定：“单注中奖奖金不超过1万元，免征收个人所得税；单注中奖奖金超过1万元，应按税法规定，中奖者需缴纳全额奖金20%的个人所得税。” ",
                  @"按照中国福利彩票和中国体育彩票派奖规则，在获得开奖号码或比赛结果后，需等待福彩中心或体彩中心正式开奖公告，然后对各奖级进行录入并派奖。一般开奖后1-3小时内到账；对于晚上22:00后比赛，一般在次日上午10:00左右派奖。",
                  @"投注站按照国家规定出票时间，做到每一张彩票严格出票！所有彩票出票时间与中国福利彩票和体育彩票官方规定出票时间完全一致，具体如下：\n双色球、福彩3D、七乐彩出票时间：22:00-19:40\n超级大乐透、七星彩、排列三、排列五、足彩胜负彩、足彩任选九出票时间：9:00-23:00\n竞彩足球、竞彩篮球出票时间：9:00-24:00（周六日9:00-次日1:00）\n北京单场出票时间：9:00-次日6:00\n时时彩：8:40-22:40，快乐十分：8:35-22:35，快3：9:35-22:00、11选5：8:55-21:55\n[特别说明]用户代购方案后，立即进入出票队列，如赔率发生变化，按照出票赔率进行兑奖。",@"如用户需要领取纸质票，可以联系客服（7*24小时客服电话：QQ：3254056760），客服验证身份和订单信息后，进行申请领取。\n注：中奖彩票因兑奖后需由中心封存备案，无法领取。",
                  @"投注站严格遵守国家彩票发行和管理相关政策和法规，我们有义务承担阻止用户沉迷彩票的社会责任，坚决反对彩票打折、返利以及鼓励加大投入等有悖于国家政策法规的行为。买彩票做公益，每个人都需要量力而行。",
                  @"一般是苹果浏览器设置问题，请到“设置”-“Safari”- 打开JavaScript\n如提款页面异常，请同时将“接受Cookie”-选择“从访问过的网页”",@"输入手机号与银行预留手机号不一致；\n开户行与手机号码所在地不一致；\n不支持建行新发行芯片卡，中国银行，以及部分新疆地区银行卡\n完善信息身份证号码及银行卡开户时身份证号码不一致（需同为一代或二代）",
                  @"进入“首界面” - 点击 “我的彩票” - 点击“忘记密码”后，按流程提示找回密码。或者拨打投注站官方客服电话QQ：3254056760，核实信息后，帮您找回密码。",@"解绑手机号码需要提供①您身份证正面照片；②您身份证反面照片；③需要解绑的手机号码；您可以通过手机拍照，再使用在线客服发送给客服人员，客服人员审核解绑之后会通知您自行绑定新的手机号码。",
                  @"提款金额被冻结是正常现象，处于等待投注站工作人员审核状态。审核通过后，将会自动解冻，并在1-2小时内到达银行账户。",
                  @"可能原因如下：\n消费金额不足充值金额的30%；\n开户行或支行信息有误；\n真实姓名有误，或真实姓名与银行开户信息不匹配；\n不支持信用卡提款。",@"按照国家体彩中心官方规定：如36小时内比赛恢复正常，则按实际比赛结果计算奖金。如超过36小时未恢复或比赛取消，则按彩果全部正确，按照赔率为1计算奖金。",
                  @"竞彩足球：\n单关：2×出票赔率×倍数\n串关：2×出票赔率连乘×倍数\n竞彩篮球：\n单关：2×出票赔率×倍数\n串关：2×出票赔率连乘×倍数\n足球单场：\n单关：2×开奖赔率×倍数×65%\n串关：2×开奖赔率之积×倍数×65%"
                  ,@"竞彩足球各玩法奖金优化是一种用户可以通过对方案注数进行调整，从而实现对方案金额及奖金进行优化的功能。您可以根据自己的需要，灵活对您的倍投复选方案进行注数调节，从而获得您满意的方案投注和方案回报。\n    1）奖金优化仅支持倍投方案，可以直接输入计划购买金额进行优化。\n    2）奖金优化最多支持5场比赛（赛果选择不超过12个），串法为2串1-5串1的单串方案。\n    3）手默认为平均优化方式。",@"可能原因如下：\n需升级至投注站最新版本\n只有完善信息用户，才能参与\n每个用户每个应用，只送1次彩金\n下载完成后，需打开下载应用超过2分钟 ",@"资金冻结是指使资金处于暂时不可用状态。在以下情况下，用户资金被冻结：发起人保底时，系统将暂时冻结保底资金。如果在合买截止前方案已经满员，系统会冻结保底资金。合买方案流产或发起人撤单，系统自动冻结保底资金。用户提款时，系统奖冻结提款资金，提款成功后转到用户提款账户，提款不成功系统", nil];
    for(int i=0;i<headerTextAry.count;i++)
    {
        NSMutableDictionary *d=[[NSMutableDictionary alloc]initWithCapacity:0];
        [isExpandedAry addObject:d];
        [d release];
    }
    
    if(!_tableView)
    {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, headBaise.frame.size.height+headBaise.frame.origin.y, 320, self.mainView.bounds.size.height-headBaise.frame.origin.y-headBaise.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.mainView addSubview:tableView];
        self.tableView=tableView;
    }
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    UIImageView *bigIma=[[UIImageView alloc]init];
    bigIma.backgroundColor=[UIColor clearColor];
    bigIma.image=[UIImage imageNamed:@"changjianwenti.png"];
    bigIma.frame=CGRectMake(0, 0, 320, 125);
    self.tableView.tableHeaderView=bigIma;
    [bigIma release];
//    isExpandedAry = [[NSMutableArray alloc]initWithCapacity:0];
//    headerTextAry=[NSArray arrayWithObjects:@"aaa",@"bbb",@"ccc",@"ddd",@"eee", nil];
//    for(int i=0;i<headerTextAry.count;i++)
//    {
//        NSMutableDictionary *d=[[NSMutableDictionary alloc]initWithCapacity:0];
//        [isExpandedAry addObject:d];
//    }
    
    if(dingwei)
    {
        UIView *sasda=[self tableView:self.tableView viewForHeaderInSection:headerTextAry.count-1];
        for(UITapGestureRecognizer *tap in sasda.gestureRecognizers)
        {
            [self expandButtonClicked:tap];
            self.tableView.contentOffset=CGPointMake(0, 994);
        }
    }

    /*
     
     Zhongjiang, //中奖如何提现
     Weichupiao,// 未出票
     Paijiangqian,//派奖
     Chongzhi,//充值
     JiangJinYouHua,//奖金优化
     JiangJinJiSuan,//奖金计算
     jiangLiHuoDong,//奖励活动
     dongJie,//冻结
     Other
     
     */
    
    int section = 0;
    
    
    switch (question) {
        case 0:
            section = 6;
            break;
        case 1:
            section = 9;
            break;
        case 2:
            section = 8;
            break;
        case 3:
            section = 12;
            break;
        case 4:
            section = 20;
            break;
        case 5:
            section = 19;
            break;
        case 6:
            section = 4;
            break;
        case 7:
            section = 16;
            break;
        case 8:
            section = 1000;
            break;
            
        default:
            break;
    }
    
    if(section == 1000){
        [self.tableView scrollsToTop];
    }
    else{
//        [self.tableView scrollRectToVisible:CGRectMake(self.tableView.frame.origin.x, 125 + 50*(section-2), self.tableView.frame.size.width, self.tableView.frame.size.height) animated:YES];
        
        [self.tableView setContentOffset:CGPointMake(self.tableView.frame.origin.x, 125 + 50*(section-2)) animated:YES];
        [self collapseOrExpand:section];
    
    }
    

}
# pragma mark tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName=@"cellName";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if(cell == nil)
    {
        cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName] autorelease];
        
        UILabel *contentLab=[[UILabel alloc]init];
        contentLab.frame=CGRectMake(15, 10, 290, 0);
        contentLab.numberOfLines=0;
        contentLab.font=[UIFont systemFontOfSize:15];
        contentLab.text=@"";
        contentLab.tag=1;
        contentLab.textColor=[UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1];
        if(indexPath.section != contentAry.count)
        {
            contentLab.text=[contentAry objectAtIndex:indexPath.section];
            
            CGSize size=[[contentAry objectAtIndex:indexPath.section] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByWordWrapping];
            contentLab.frame=CGRectMake(15, 10, 290, size.height);
        }
//        contentLab.text=[contentAry objectAtIndex:indexPath.section];
//        
//        CGSize size=[[contentAry objectAtIndex:indexPath.section] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//        contentLab.frame=CGRectMake(15, 10, 290, size.height);
        
        [cell.contentView addSubview:contentLab];
        [contentLab release];
    }
    
    UILabel *lab=(UILabel *)[cell.contentView viewWithTag:1];
    lab.text=@"";
    if(indexPath.section != contentAry.count)
    {
        lab.text=[contentAry objectAtIndex:indexPath.section];
        CGSize size=[[contentAry objectAtIndex:indexPath.section] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        lab.frame=CGRectMake(15, 10, 290, size.height);
    }
//    lab.text=[contentAry objectAtIndex:indexPath.section];
//    CGSize size=[[contentAry objectAtIndex:indexPath.section] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//    lab.frame=CGRectMake(15, 10, 290, size.height);
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=[UIColor colorWithRed:250/255.0 green:249/255.0 blue:243/255.0 alpha:1];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if([self isExpanded:section])
//        return 1;
//    else
//        return 0;
    if(section == headerTextAry.count)
    {
        return 0;
    }
    else
    {
        if([self isExpanded:section])
            return 1;
        else
            return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    return 50.0;
    CGSize size=[[contentAry objectAtIndex:indexPath.section] sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    
    return size.height+20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)] autorelease];
    headView.userInteractionEnabled=YES;
    headView.backgroundColor=[UIColor whiteColor];
    
    headView.tag=section;
    
    UILabel *customLab=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 282+6, 50)];
    customLab.backgroundColor=[UIColor clearColor];
    customLab.font=[UIFont systemFontOfSize:18];
    if(section == [headerTextAry count])
    {
        customLab.text=@"点击查看更多问题";
    }
    else
    {
        customLab.text=[NSString stringWithFormat:@"%@",[headerTextAry objectAtIndex:section]];
        if([self isExpanded:section])
            headView.backgroundColor=[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    }
//    customLab.text=[NSString stringWithFormat:@"%@",[headerTextAry objectAtIndex:section]];
    customLab.textColor=[UIColor colorWithRed:69/255.0 green:69/255.0 blue:69/255.0 alpha:1];
    [headView addSubview:customLab];
    UITapGestureRecognizer *tapLab=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(expandButtonClicked:)];
    [headView addGestureRecognizer:tapLab];
    
    UIImageView *jiantouIma=[[UIImageView alloc]init];
    jiantouIma.frame=CGRectMake(320-15-8, 18.5, 8, 13);
    jiantouIma.backgroundColor=[UIColor clearColor];
    jiantouIma.image=[UIImage imageNamed:@"jiantou.png"];
    [headView addSubview:jiantouIma];
    
    UIImageView *line1Ima=[[UIImageView alloc]init];
    line1Ima.frame=CGRectMake(0, -0.5, 320, 0.5);
    line1Ima.backgroundColor=[UIColor clearColor];
    line1Ima.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
//    line1Ima.image=[UIImage imageNamed:@"SZTG960.png"];
    [headView addSubview:line1Ima];
    
    UIImageView *line2Ima=[[UIImageView alloc]init];
    line2Ima.frame=CGRectMake(0, headView.frame.size.height-0.5, 320, 0.5);
    line2Ima.backgroundColor=[UIColor clearColor];
//    line2Ima.image=[UIImage imageNamed:@"SZTG960.png"];
    line2Ima.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [headView addSubview:line2Ima];
    
    
//    [headView addSubview:customLab];
    [customLab release];
    [tapLab release];
    [jiantouIma release];
    [line1Ima release];
    [line2Ima release];
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return [headerTextAry count]+1;
    return [headerTextAry count];
}
# pragma mark 展开收起
//=========================================
-(void)collapseOrExpand:(NSInteger)section{
    Boolean expanded = NO;
    //Boolean searched = NO;
    NSMutableDictionary* d=[isExpandedAry objectAtIndex:section];
    
    //若本节model中的“expanded”属性不为空，则取出来
    if([d objectForKey:@"expanded"]!=nil)
        expanded=[[d objectForKey:@"expanded"]intValue];
    
    //若原来是折叠的则展开，若原来是展开的则折叠
    [d setObject:[NSNumber numberWithBool:!expanded] forKey:@"expanded"];
    
}
//返回指定节的“expanded”值
-(Boolean)isExpanded:(NSInteger)section{
    Boolean expanded = NO;
    NSMutableDictionary* d=[isExpandedAry objectAtIndex:section];
    
    //若本节model中的“expanded”属性不为空，则取出来
    if([d objectForKey:@"expanded"]!=nil)
        expanded=[[d objectForKey:@"expanded"]intValue];
    
    return expanded;
}
//按钮被点击时触发
-(void)expandButtonClicked:(UITapGestureRecognizer *)sender{
    
    NSInteger section=[sender view].tag;
    
//    [self collapseOrExpand:section];
    if(section == headerTextAry.count)
    {
        NSLog(@"%ld",(long)section);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.zgzcw.com/help/for365.html"]];
    }
    else
    {
        [self collapseOrExpand:section];
    }
    
    [self.tableView reloadData];
}
# pragma mark 建议和投诉
-(void)pressGaijinButton:(UIButton *)button
{
    UINavigationController * nav = (UINavigationController *)[[[caiboAppDelegate getAppDelegate] window] rootViewController];
    //    [self.window addSubview:nav.view];
    
    if ([[[Info getInstance] userId] intValue] == 0) {
        LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        [loginVC setHidesBottomBarWhenPushed:YES];
        [loginVC setIsShowDefultAccount:YES];
        [nav pushViewController:loginVC animated:YES];
        [loginVC release];
        
//        self.hidden = YES;
        return;
    }
    UserListMailController * userListMailController = [[[UserListMailController alloc] init] autorelease];
    MailList *mList = [[[MailList alloc] init] autorelease];
    if (button.tag == 10) {
        userListMailController.senderId = PROPOSAL_ID;
//        mList.nickName = @"wjcm";
        mList.nickName = @"产品改进意见";
    }else{
        userListMailController.senderId = COMPLAINTS_ID;
//        mList.nickName = @"魏贵磊";
        mList.nickName = @"服务投诉";
    }
    userListMailController.mList = mList;
    
    [nav pushViewController:userListMailController animated:YES];
//    self.hidden = YES;
//    kFMessageBoxView.hidden = YES;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f",scrollView.contentOffset.y);
}
-(void)backButton
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