//
//  CP_ThreeLevelNavigationView.m
//  kongjiantabbat
//
//  Created by houchenguang on 12-11-30.
//
//

#import "CP_ThreeLevelNavigationView.h"
#import <QuartzCore/QuartzCore.h>
#import "caiboAppDelegate.h"
#import "ImageUtils.h"

@implementation CP_ThreeLevelNavigationView
@synthesize delegate;
@synthesize titleArr, gsimage;


- (void)dealloc{
    [myTableView release];
    [imageArr release];
    [titleArr release];
     [super dealloc];
}
- (void)returnSelectIndex:(NSInteger)index{
    if ([delegate respondsToSelector:@selector(returnSelectIndex:)]) {
        [delegate returnSelectIndex:index];
        
    }
    if (self) {
        [self removeFromSuperview];
        self = nil;
    }

}
- (void)returnSelectButton:(UIButton *)sender{
    if ([delegate respondsToSelector:@selector(returnSelectButton:)]) {
        [delegate returnSelectButton:sender];
        
    }

}
- (void)threeLevelSelectButton:(UIButton *)sender{
    [self returnSelectButton:sender];
}
- (void)threeLevelSelectIndex:(NSInteger)index{

    [self returnSelectIndex:index];
//    if (self) {
//        [self removeFromSuperview];
//        self = nil;
//    }
    
}

- (NSMutableArray *)titleArr{
    return titleArr;
}

- (void)setTitleArr:(NSMutableArray *)_titleArr{

    if (titleArr != _titleArr) {
        [titleArr release];
        titleArr = [_titleArr retain];
    }

    [myTableView reloadData];
}

- (id)initWithFrame:(CGRect)frame AllImageName:(NSMutableArray *)allImage setAllTitle:(NSMutableArray *)allTitle bgName:(NSString *)bgName
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
            self.frame = CGRectMake(frame.origin.x, frame.origin.y+20, frame.size.width, frame.size.height);
        }else{
            self.frame = frame;
        }
        
        
        if (!imageArr) {
            imageArr = [[NSMutableArray alloc] initWithCapacity:0];
        }
        [imageArr removeAllObjects];
        [imageArr addObjectsFromArray:allImage];
        
        
        if (!titleArr) {
            titleArr = [[NSMutableArray alloc] initWithCapacity:0];
        }
        [titleArr removeAllObjects];
        [titleArr addObjectsFromArray:allTitle];
        
        
        
        bgimage = [[UIImageView alloc] initWithFrame:CGRectMake(164, 66, 150, [titleArr count]*45 + 10.5)];
#ifdef isCaiPiaoForIPad
        self.frame = CGRectMake(0, 0, 390, 1024);
        bgimage.frame = CGRectMake(142+70, 39, 176, [titleArr count]*35+16);
#endif
        bgimage.userInteractionEnabled = YES;
//        bgimage.image = [[UIImage imageNamed:bgName] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        bgtwoImage = [[UIImageView alloc] initWithFrame:bgimage.bounds];
        bgtwoImage.userInteractionEnabled = YES;
        bgtwoImage.hidden = YES;
        bgtwoImage.image = [[UIImage imageNamed:bgName] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        [bgimage addSubview:bgtwoImage];
        [bgtwoImage release];
        
        
        myTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, bgimage.frame.size.width, [titleArr count]*45)];
        myTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleWidth;
        myTableView.scrollEnabled = NO;
        myTableView.dataSource = self;
        myTableView.delegate = self;
        myTableView.backgroundColor = [UIColor clearColor];
        [myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [bgimage addSubview:myTableView];
        
       
        
        
        //
        [self addSubview:bgimage];
        [bgimage release];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame AllImageName:(NSMutableArray *)allImage setAllTitle:(NSMutableArray *)allTitle type:(MenuType)type
{
    menuType = type;
    
    NSString * bgName = @"";
    if (type == commonMenu) {
        bgName = @"TCCD960.png";
    }
    else if (type == KuaiSanMenu) {
        bgName = @"kuaiSanMenuBG.png";
    }
    else if (type == PuKeMenu) {
        bgName = @"PukeMenuBG.png";
    }
    
    return [self initWithFrame:frame AllImageName:allImage setAllTitle:allTitle bgName:bgName];
}


- (id)initWithFrame:(CGRect)frame AllImageName:(NSMutableArray *)allImage setAllTitle:(NSMutableArray *)allTitle{
    return [self initWithFrame:frame AllImageName:allImage setAllTitle:allTitle type:commonMenu];
}


-(void)show
{
    bgimage.alpha = 0;
    
    bgimage.transform = CGAffineTransformScale(bgimage.transform, 0.5, 0.5);
    bgimage.frame = CGRectMake(bgimage.frame.origin.x + bgimage.frame.size.width/2 - 10, bgimage.frame.origin.y - bgimage.frame.size.height/2, bgimage.frame.size.width, bgimage.frame.size.height);
    
    
//    backImageV.backgroundColor = [UIColor whiteColor];
    
   

    bgtwoImage.hidden = NO;
    
    
    
    [UIView animateWithDuration:0.2 animations:^{
        bgimage.transform = CGAffineTransformMake(1.1, 0, 0, 1.1, 0, 0);
        
        bgimage.alpha = 1;
        bgimage.frame = CGRectMake(164 - 13, 66, 150*1.1, ([titleArr count]*45 + 10.5)*1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            bgimage.transform = CGAffineTransformIdentity;
            
            bgimage.frame = CGRectMake(164, 66, 150, [titleArr count]*45 + 10.5);
        } completion:^(BOOL finished) {
            
        }];
    }];
    
    [self performSelector:@selector(sleepBgImageFunc) withObject:nil afterDelay:0.3];

}

- (void)sleepBgImageFunc{
    
     bgtwoImage.hidden = YES;
    
    CGRect rect = CGRectMake(164, 66, 150, [titleArr count]*45 + 10.5);
    UIImage *image1 = [[[caiboAppDelegate getAppDelegate] JiePing] gaussianBlur];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6) {
        bgimage.image = [image1 imageFromImage:image1  inRect:CGRectMake(bgimage.frame.origin.x, rect.origin.y , rect.size.width/2, bgimage.bounds.size.height/2)];
    }
    else {
        bgimage.image = [image1 imageFromImage:image1 inRect:CGRectMake(bgimage.frame.origin.x*2, rect.origin.y *2 , rect.size.width, rect.size.height)];
    }
    bgtwoImage.hidden = NO;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [titleArr count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        NSString * cellid = @"cellid";
    CP_ThreeLevCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[CP_ThreeLevCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid type:menuType] autorelease];
    }
    
    cell.row = indexPath.row;
    
    cell.headImage.image =  [UIImage imageNamed:[imageArr objectAtIndex:indexPath.row]];
    cell.titleLabel.text = [titleArr objectAtIndex:indexPath.row];
    cell.delegate = self;
    
    if (indexPath.row == [titleArr count]-1) {
        cell.line.hidden = YES;
    }else{
        cell.line.hidden = NO;
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
       
        
    }
    return self;
}


#pragma mark 按下触发事件
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"press view button!!!!!");
    
    if (self) {
        [self removeFromSuperview];
        self = nil;
    }

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    