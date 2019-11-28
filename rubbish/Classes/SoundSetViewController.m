//
//  SoundSetViewController.m
//  caibo
//
//  Created by cp365dev on 14/10/29.
//
//

#import "SoundSetViewController.h"
#import "Info.h"
@interface SoundSetViewController ()

@end

@implementation SoundSetViewController

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
    self.CP_navigation.title =@"声音提醒";
    
    UIBarButtonItem *left = [Info backItemTarget:self action:@selector(doBack)];
    self.CP_navigation.leftBarButtonItem = left;
    
    UIImageView * bgview = [[UIImageView alloc] initWithFrame:self.mainView.bounds];
    bgview.backgroundColor = [UIColor clearColor];
    bgview.backgroundColor = [UIColor colorWithRed:250.0/255.0 green:249.0/255.0 blue:243.0/255.0 alpha:1];
    [self.mainView addSubview:bgview];
    [bgview release];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 12)];
    label1.text = @"私信声音、幸运选号";
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor colorWithRed:114/255.0 green:114/255.0 blue:114/255.0 alpha:1];
    label1.backgroundColor = [UIColor clearColor];
    [self.mainView addSubview:label1];
    [label1 release];
    
    UIImageView *xian1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(label1)+5, 320, 1)];
    xian1.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    [self.mainView addSubview:xian1];
    [xian1 release];
    
    UIView *whiteview = [[UIView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(xian1), 320, 45)];
    whiteview.backgroundColor = [UIColor whiteColor];
    whiteview.userInteractionEnabled = YES;
    [self.mainView addSubview:whiteview];
    [whiteview release];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 45)];
    label2.text = @"声音提醒";
    label2.backgroundColor = [UIColor clearColor];
    label2.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
    label2.font = [UIFont systemFontOfSize:16];
    [whiteview addSubview:label2];
    [label2 release];
    
    
    switchBtn = [[CP_SWButton alloc] initWithFrame:CGRectMake(235, 7, 70, 31)];
    switchBtn.onImageName = @"heji2-640_10.png";
    switchBtn.offImageName = @"heji2-640_11.png";
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"SoundSetPage_setSound"] integerValue] == 1){
        switchBtn.on = YES;

    }else{
    
        switchBtn.on = NO;
    }
    [switchBtn addTarget:self action:@selector(pressSwitchYN:) forControlEvents:UIControlEventValueChanged];
    switchBtn.backgroundColor = [UIColor clearColor];
    [whiteview addSubview:switchBtn];
    [switchBtn release];
    
    
    UIImageView *xian2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(xian1)+45, 320, 1)];
    xian2.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
    [self.mainView addSubview:xian2];
    [xian2 release];
    
    
    
    
}
-(void)pressSwitchYN:(CP_SWButton *)sender{

//    switchBtn.on = !switchBtn.on;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if(sender.on){
    
        NSLog(@"开开开开开开开开开开开开");
        [userDefaults setValue:@"1" forKey:@"SoundSetPage_setSound"];
    }else{
    
        NSLog(@"关关关关关关关关关关");
        [userDefaults setValue:@"0" forKey:@"SoundSetPage_setSound"];
    
    }
    
    [userDefaults synchronize];


}
-(void)doBack{
    
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