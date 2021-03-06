//
//  PWInfoViewController.m
//  caibo
//
//  Created by houchenguang on 14-2-28.
//
//

#import "PWInfoViewController.h"
#import "Info.h"
#import "TestViewController.h"

@interface PWInfoViewController ()

@end

@implementation PWInfoViewController

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
    
    self.CP_navigation.title = @"手势密码";
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
    // bgview.image = [UIImage imageNamed:@"login_bgn.png"];
    bgview.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgview];
    [bgview release];
    
    UIBarButtonItem *leftItem = [Info backItemTarget:self action:@selector(doBack)];
	self.CP_navigation.leftBarButtonItem = leftItem;
    
    // WithFrame:CGRectMake(4, 5, self.mainView.frame.size.width - 8, 331)
    UIImageView * lockBgImage = [[UIImageView alloc] init];
    lockBgImage.frame = self.mainView.bounds;
    lockBgImage.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    lockBgImage.userInteractionEnabled = YES;
    // lockBgImage.image = [UIImageGetImageFromName(@"lockbgimage.png") stretchableImageWithLeftCapWidth:95 topCapHeight:95];
    [self.mainView addSubview:lockBgImage];
    [lockBgImage release];
    
    
    
    // 手机解锁图片
    UIImageView * phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake((lockBgImage.frame.size.width - 134)/2, 57, 134, 241)];
    phoneImage.backgroundColor = [UIColor clearColor];
    phoneImage.image = UIImageGetImageFromName(@"shoushishuoming.png");
    [lockBgImage addSubview:phoneImage];
    [phoneImage release];
    
    UILabel * infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 23, lockBgImage.frame.size.width, 20)];
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.textColor = [UIColor colorWithRed:187.0/255.0 green:187.0/255.0 blue:187.0/255.0 alpha:1];
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.text = @"创建一个解锁图案,替代之前的密码输入方式";
    [lockBgImage addSubview:infoLabel];
    [infoLabel release];
    
    
    
    
    
    // 取消
    UIButton * btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.frame = CGRectMake(15, self.mainView.frame.size.height-42.5-30, 137.5, 30);
    btnRegister.tag = 1;
    [btnRegister addTarget:self action:@selector(doRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btnRegister];
    [btnRegister setBackgroundImage:[[UIImage imageNamed:@"tongyonglan.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10]forState:UIControlStateNormal];
    [btnRegister setTitle:@"取消" forState:UIControlStateNormal];
    [btnRegister setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];
    btnRegister.titleLabel.font = [UIFont systemFontOfSize:13];
    
   
    // 立即创建
    UIButton * btnRegister2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister2.frame = CGRectMake(166, self.mainView.frame.size.height-42.5-30, 137.5, 30);
    btnRegister2.tag = 2;
    [btnRegister2 addTarget:self action:@selector(doRegister:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView addSubview:btnRegister2];
    // Login
    [btnRegister2 setBackgroundImage:[[UIImage imageNamed:@"tongyonglan.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [btnRegister2 setTitle:@"立即创建" forState:UIControlStateNormal];
    [btnRegister2 setTitleColor:[UIColor colorWithRed:19.0/255.0 green:163.0/255.0 blue:255.0/255.0 alpha:1] forState:UIControlStateNormal];

    btnRegister2.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    
  
    
    if (IS_IPHONE_5) {
        lockBgImage.frame = CGRectMake(4, 5, self.mainView.frame.size.width - 8, 331+50);
        phoneImage.frame = CGRectMake((lockBgImage.frame.size.width - 134)/2, 57+30, 134, 241);
        infoLabel.frame = CGRectMake(0, 23+10, lockBgImage.frame.size.width, 20);
//        btnRegister2.frame = CGRectMake((320 - 120)/2, 357+50, 120, 35);

    }
    
    
}

- (void)doRegister:(UIButton *)sender{

    if (sender.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 2){
    
        TestViewController * test = [[TestViewController alloc] init];
        [self.navigationController pushViewController:test animated:YES];
        [test release];
    
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