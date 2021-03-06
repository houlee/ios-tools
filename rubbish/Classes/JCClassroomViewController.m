//
//  JCClassroomViewController.m
//  caibo
//
//  Created by houchenguang on 14-8-27.
//
//

#import "JCClassroomViewController.h"
#import "Info.h"
#import "MyWebViewController.h"

@interface JCClassroomViewController ()

@end

@implementation JCClassroomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)doBack{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)pressUrlButton:(UIButton *)sender{

    NSString * strUrl = @"";
    if(sender.tag == 1){
    
        strUrl = @"http://www.caipiao365.com/help/tushuo/wlycczsm.html";
    }
    else if (sender.tag == 2) {
        strUrl = @"http://www.caipiao365.com/help/tushuo/jczqgl.html";
        
    }else if (sender.tag == 3){
        strUrl = @"http://www.caipiao365.com/help/tushuo/smspl.html";
        
    }else if (sender.tag == 4){
        strUrl = @"http://www.caipiao365.com/help/tushuo/jczq.html";
    }else if (sender.tag == 5){
        strUrl = @"http://www.caipiao365.com/help/tushuo/jjzms.html";
    }
    
    MyWebViewController *myWeb=[[MyWebViewController alloc]init];
    myWeb.webTitle=@"竞彩课堂";
    [myWeb LoadRequst:[NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]]];
    [self.navigationController pushViewController:myWeb animated:YES];
    [myWeb release];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.CP_navigation.title =  @"竞彩课堂";
    // Do any additional setup after loading the view.
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    self.mainView.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    UIView *v1 = [[UIView alloc] init];
    [self.mainView addSubview:v1];
    [v1 release];
    
    NSArray * titleArray = [NSArray arrayWithObjects:@"我来预测_您不知道怎么发布自己的预测?其实很简单!",@"竞彩足球攻略_中奖其实很简单,一起学习吧!", @"赔率是神马?_赔率乃竞彩投注必备神器,对于他你真的了解吗?", @"玩法知多少?_投注竞彩不了解玩法怎么行?快点一起学习吧!", @"奖金怎么计算?_中奖多少,要你早知道!", nil];
    NSArray * iconArray = [NSArray arrayWithObjects:@"jcclassroom1.png",@"jcclassroom2.png",@"jcclassroom3.png",@"jcclassroom4.png",@"jcclassroom5.png",  nil];
    
      NSArray * bgArray = [NSArray arrayWithObjects:@"gljcroom1.png",@"gljcroom2.png",@"gljcroom3.png",@"gljcroom4.png",@"gljcroom5.png", nil];
    
    NSInteger hight = 10;
    
    UIScrollView * myscrollView = [[UIScrollView alloc] initWithFrame:self.mainView.bounds];
    myscrollView.backgroundColor = [UIColor clearColor];
//    myscrollView.bounces = NO;
    myscrollView.contentSize = CGSizeMake(self.mainView.frame.size.width, 600);
    
    if (IS_IPHONE_5) {
        hight = 30;
//        myscrollView.scrollEnabled = NO;
    }else{
        hight = 10;
//        myscrollView.scrollEnabled = YES;

    }
    
    [self.mainView addSubview:myscrollView];
    [myscrollView release];
    
    for (int i = 0; i < [titleArray count]; i++) {
        
        UIButton * urlButton = [UIButton buttonWithType:UIButtonTypeCustom];
        urlButton.tag = i+1;
        urlButton.enabled = NO;
        urlButton.frame = CGRectMake(320, hight+ (90*i) + (10* i), 300, 90);
        [urlButton setBackgroundImage:UIImageGetImageFromName([bgArray objectAtIndex:i]) forState:UIControlStateNormal];
        [urlButton addTarget:self action:@selector(pressUrlButton:) forControlEvents:UIControlEventTouchUpInside];
        [myscrollView addSubview:urlButton];
        
        UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(31, (urlButton.frame.size.height - 51)/2, 51, 51)];
        iconImageView.backgroundColor = [UIColor clearColor];
        iconImageView.image = UIImageGetImageFromName([iconArray objectAtIndex:i]);
        [urlButton addSubview:iconImageView];
        [iconImageView release];
        
         NSArray * comArr = [[titleArray objectAtIndex:i] componentsSeparatedByString:@"_"];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(82+18, 19, 169, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        if ([comArr count] > 0) {
            titleLabel.text = [comArr objectAtIndex:0];
        }else{
            titleLabel.text = @"";
        }
        
        titleLabel.textColor = [UIColor whiteColor];
        [urlButton addSubview:titleLabel];
        [titleLabel release];
        
        UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(82+18, 42, 169, 20)];
        infoLabel.backgroundColor = [UIColor clearColor];
        infoLabel.font = [UIFont systemFontOfSize:12];
        infoLabel.textAlignment = NSTextAlignmentLeft;
        if ([comArr count] > 1) {
            infoLabel.text = [comArr objectAtIndex:1];
        }else{
            infoLabel.text = @"";
        }
        
        infoLabel.textColor = [UIColor whiteColor];
        if (i == 0 || i == 2 || i == 3) {
            infoLabel.frame = CGRectMake(82+18, 39, 169, 40);
            infoLabel.lineBreakMode = NSLineBreakByWordWrapping;
            infoLabel.numberOfLines = 0;
        }
       
        [urlButton addSubview:infoLabel];
        [infoLabel release];

        
        [UIView animateWithDuration:0.25 delay:i*0.15 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            urlButton.frame = CGRectMake(10, hight+ (90*i) + (10* i), 300, 90);

        } completion:^(BOOL finish){
            urlButton.enabled = YES;

        }];
        
        
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