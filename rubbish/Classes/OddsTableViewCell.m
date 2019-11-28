//
//  OddsTableViewCell.m
//  caibo
//
//  Created by houchenguang on 14-5-23.
//
//

#import "OddsTableViewCell.h"
#import "OddInfoTableViewCell.h"

@implementation OddsTableViewCell

@synthesize delegate, indexOdds, oddsInteger;

- (NSMutableDictionary *)oddsDictionary{

    return oddsDictionary;
}

- (void)setOddsDictionary:(NSMutableDictionary *)_oddsDictionary{
    if (oddsDictionary != _oddsDictionary) {
        [oddsDictionary release];
        oddsDictionary = [_oddsDictionary retain];
    }

    NSArray * dataArray = nil;
    
    if (oddsInteger == 1) {
        oneLabel.text = @"胜";
        twoLabel.text = @"平";
        threeLabel.text = @"负";
        dataArray = [oddsDictionary objectForKey:@"euro"];
    }else if (oddsInteger == 2){
        oneLabel.text = @"主";
        twoLabel.text = @"盘";
        threeLabel.text = @"客";
        dataArray = [oddsDictionary objectForKey:@"asia"];
    }else if (oddsInteger == 3){
        oneLabel.text = @"大";
        twoLabel.text = @"盘";
        threeLabel.text = @"小";
        dataArray = [oddsDictionary objectForKey:@"ball"];
    }
    
    NSDictionary * daDict = [dataArray objectAtIndex:indexOdds.row];
    
    macthLabel.text = [daDict objectForKey:@"name"];
    oneShengLable.text = [daDict objectForKey:@"firstwin"];
    onePingLable.text = [daDict objectForKey:@"firstsame"];
    oneFuLable.text = [daDict objectForKey:@"firstlost"];
    twoShengLable.text = [daDict objectForKey:@"win"];
    twoPingLable.text = [daDict objectForKey:@"same"];
    twoFuLable.text = [daDict objectForKey:@"lost"];
    
    
    twoShengLable.textColor = [UIColor blackColor];
    twoPingLable.textColor = [UIColor blackColor];
    twoFuLable.textColor = [UIColor blackColor];
    
    
    
    CGSize oneSize = [twoShengLable.text sizeWithFont:twoShengLable.font constrainedToSize:CGSizeMake(50, 49.5) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize twoSize = [twoPingLable.text sizeWithFont:twoShengLable.font constrainedToSize:CGSizeMake(98, 49.5) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize threeSize = [twoFuLable.text sizeWithFont:twoShengLable.font constrainedToSize:CGSizeMake(320 - 258, 49.5) lineBreakMode:NSLineBreakByWordWrapping];
    
    twoShengLable.frame = CGRectMake(109 + (50 - oneSize.width - 9)/2, 0, oneSize.width, 49.5);
    jianImageOne.frame = CGRectMake(twoShengLable.frame.origin.x+twoShengLable.frame.size.width+2, (49.5 - 7)/2, 7, 7);
    
    if ([twoShengLable.text floatValue] > [oneShengLable.text floatValue]) {//比较第一个
        twoShengLable.textColor = [UIColor colorWithRed:246/255.0 green:0 blue:7/255.0 alpha:1];
        jianImageOne.image = UIImageGetImageFromName(@"jianshang.png");
    }else if ([twoShengLable.text floatValue] < [oneShengLable.text floatValue]){
        twoShengLable.textColor = [UIColor colorWithRed:0 green:38/255.0 blue:175/255.0 alpha:1];
        jianImageOne.image = UIImageGetImageFromName(@"jianxia.png");
    }else{
        twoShengLable.textColor = [UIColor blackColor];
        jianImageOne.image = UIImageGetImageFromName(@"jianyou.png");
    }
    if (oddsInteger == 1) {
        jianImageTwo.hidden = NO;
        
        twoPingLable.frame = CGRectMake(159 + (98 - twoSize.width - 9)/2, 0, twoSize.width, 49.5);
        jianImageTwo.frame = CGRectMake(twoPingLable.frame.origin.x+twoPingLable.frame.size.width+2, (49.5 - 7)/2, 7, 7);
        
        if ([twoPingLable.text floatValue] > [onePingLable.text floatValue]) {//比较第二个
            twoPingLable.textColor = [UIColor colorWithRed:246/255.0 green:0 blue:7/255.0 alpha:1];
            jianImageTwo.image = UIImageGetImageFromName(@"jianshang.png");
        }else if ([twoPingLable.text floatValue] < [onePingLable.text floatValue]){
            twoPingLable.textColor = [UIColor colorWithRed:0 green:38/255.0 blue:175/255.0 alpha:1];
             jianImageTwo.image = UIImageGetImageFromName(@"jianxia.png");
        }else{
            twoPingLable.textColor = [UIColor blackColor];
             jianImageTwo.image = UIImageGetImageFromName(@"jianyou.png");
        }
    }else{
        twoPingLable.frame = CGRectMake(159, 0, 98, 49.5);
        jianImageTwo.hidden = YES;
    }
    
   
    
    twoFuLable.frame = CGRectMake(258+(320 - 258 - threeSize.width - 9)/2, 0, threeSize.width, 49.5);
    jianImageThree.frame = CGRectMake(twoFuLable.frame.origin.x+twoFuLable.frame.size.width+2, (49.5 - 7)/2, 7, 7);
    
    if ([twoFuLable.text floatValue] > [oneFuLable.text floatValue]) {//比较第三个
        twoFuLable.textColor = [UIColor colorWithRed:246/255.0 green:0 blue:7/255.0 alpha:1];
        jianImageThree.image = UIImageGetImageFromName(@"jianshang.png");
    }else if ([twoFuLable.text floatValue] < [oneFuLable.text floatValue]){
        twoFuLable.textColor = [UIColor colorWithRed:0 green:38/255.0 blue:175/255.0 alpha:1];
         jianImageThree.image = UIImageGetImageFromName(@"jianxia.png");
    }else{
        twoFuLable.textColor = [UIColor blackColor];
         jianImageThree.image = UIImageGetImageFromName(@"jianyou.png");
    }
    
    [myTabelView reloadData];
    
    
    NSArray * odddaDict = [daDict objectForKey:@"change"];
   
        if ([odddaDict count] > 0) {
            openButton.hidden = NO;
        }else{
            openButton.hidden = YES;
        }
    
  
    
}


- (void)setOpencellBool:(BOOL)_opencellBool{
    opencellBool = _opencellBool;
    if (opencellBool) {
        openButton.tag = 2;
        openImage.image = UIImageGetImageFromName(@"bdheaddakai.png");
        openImage.frame = CGRectMake(75, (49.5 - 12.5)/2, 9, 12.5);
        NSArray * dataArray = nil;
        
        if (oddsInteger == 1) {
            dataArray = [oddsDictionary objectForKey:@"euro"];
        }else if (oddsInteger == 2){
            
            dataArray = [oddsDictionary objectForKey:@"asia"];
        }else if (oddsInteger == 3){
            
            dataArray = [oddsDictionary objectForKey:@"ball"];
        }
        
        NSDictionary * daDict = [dataArray objectAtIndex:indexOdds.row];
        
        NSArray *  countArray = [daDict objectForKey:@"change"];
        openView.frame = CGRectMake(0, 129, 320, [countArray count] * 50);
        myTabelView.frame = CGRectMake(0, 0, 320, [countArray count] * 50);
    }else{
        openButton.tag = 1;
         openImage.frame = CGRectMake(75, (49.5 - 9)/2, 12.5, 9);
        openImage.image = UIImageGetImageFromName(@"bdheadguanbi2.png");//bdheadguanbi2
        openView.frame = CGRectMake(0, 129 , 320, 0);
        myTabelView.frame = CGRectMake(0, 0, 320, 0);
        
        
    }
}
- (BOOL)opencellBool{
    return opencellBool;
}

- (void)dealloc{
    [indexOdds release];
    [super dealloc];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * dataArray = nil;
    if (oddsInteger == 1) {
        
        dataArray = [oddsDictionary objectForKey:@"euro"];
    }else if (oddsInteger == 2){
        
        dataArray = [oddsDictionary objectForKey:@"asia"];
    }else if (oddsInteger == 3){
        
        dataArray = [oddsDictionary objectForKey:@"ball"];
    }
    if (dataArray && [dataArray count] > indexOdds.row) {
         NSDictionary * daDict = [dataArray objectAtIndex:indexOdds.row];
        if ([daDict objectForKey:@"change"]) {
            return [[daDict objectForKey:@"change"] count];
        }
    }
   
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"SCell";
    
    OddInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[[OddInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSArray * dataArray = nil;
    cell.oddIndexPath = indexPath;
    cell.oddsInteger = oddsInteger;
    if (oddsInteger == 1) {
       
        dataArray = [oddsDictionary objectForKey:@"euro"];
    }else if (oddsInteger == 2){
        
        dataArray = [oddsDictionary objectForKey:@"asia"];
    }else if (oddsInteger == 3){
        
        dataArray = [oddsDictionary objectForKey:@"ball"];
    }
    NSDictionary * daDict = [dataArray objectAtIndex:indexOdds.row];
    cell.oddsDictionary = daDict;
    
    return cell;
    
}


- (void)tableViewCellShow{

    openView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 129, 320, 0)];
    [openView.layer setMasksToBounds:YES];
    openView.backgroundColor = [UIColor clearColor];
    openView.image = [UIImageGetImageFromName(@"oddsinfoimage.png") stretchableImageWithLeftCapWidth:100 topCapHeight:30];
    [self.contentView addSubview:openView];
    [openView release];
    
    myTabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 0) style:UITableViewStylePlain];
    myTabelView.delegate = self;
    myTabelView.dataSource = self;
    myTabelView.backgroundColor = [UIColor clearColor];
    myTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTabelView.showsVerticalScrollIndicator = NO;
    myTabelView.scrollEnabled = NO;
    [openView addSubview:myTabelView];
    [myTabelView release];
    
    
    UIImageView * titleBGImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 29)];
    titleBGImage.backgroundColor = [UIColor colorWithRed:253/255.0 green:252/255.0 blue:249/255.0 alpha:1];
    [self.contentView addSubview:titleBGImage];
    [titleBGImage release];
    
    macthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 109, titleBGImage.frame.size.height)];
    macthLabel.backgroundColor = [UIColor clearColor];
    macthLabel.textAlignment = NSTextAlignmentCenter;
    macthLabel.font = [UIFont systemFontOfSize:15];
//    macthLabel.text = @"伟德(直布罗陀)";
    [titleBGImage addSubview:macthLabel];
    [macthLabel release];
    
//    UIImageView * oneLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(109, 9, 0.5, 11)];
//    oneLineImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
//    [titleBGImage addSubview:oneLineImage];
//    [oneLineImage release];
    
    oneLabel = [[UILabel alloc] initWithFrame:CGRectMake(109, 0, 50, titleBGImage.frame.size.height)];
    oneLabel.backgroundColor = [UIColor clearColor];
    oneLabel.textAlignment = NSTextAlignmentCenter;
    oneLabel.font = [UIFont systemFontOfSize:15];
    oneLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
//    oneLabel.text = @"大";
    [titleBGImage addSubview:oneLabel];
    [oneLabel release];

//    UIImageView * twoLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(158.5, 9, 0.5, 11)];
//    twoLineImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
//    [titleBGImage addSubview:twoLineImage];
//    [twoLineImage release];
    
    twoLabel = [[UILabel alloc] initWithFrame:CGRectMake(159, 0, 98, titleBGImage.frame.size.height)];
    twoLabel.backgroundColor = [UIColor clearColor];
    twoLabel.textAlignment = NSTextAlignmentCenter;
    twoLabel.font = [UIFont systemFontOfSize:15];
    twoLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
//    twoLabel.text = @"盘";
    [titleBGImage addSubview:twoLabel];
    [twoLabel release];
    
//    UIImageView * threeLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(257.5, 9, 0.5, 11)];
//    threeLineImage.backgroundColor = [UIColor colorWithRed:214/255.0 green:215/255.0 blue:215/255.0 alpha:1];
//    [titleBGImage addSubview:threeLineImage];
//    [threeLineImage release];
    
    threeLabel = [[UILabel alloc] initWithFrame:CGRectMake(258, 0, 320 - 258, titleBGImage.frame.size.height)];
    threeLabel.backgroundColor = [UIColor clearColor];
    threeLabel.textAlignment = NSTextAlignmentCenter;
    threeLabel.font = [UIFont systemFontOfSize:15];
    threeLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
//    threeLabel.text = @"小";
    [titleBGImage addSubview:threeLabel];
    [threeLabel release];
    
    UIImageView * lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29, 320, 0.5)];
    lineImage.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self.contentView addSubview:lineImage];
    [lineImage release];
    
    UIImageView * oneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29.5, 320, 49.5)];
    oneImageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:245/255.0 alpha:1];
    [self.contentView addSubview:oneImageView];
    [oneImageView release];
    
    UIImageView * lineImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29.5 + 49.5, 320, 0.5)];
    lineImage2.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
    [self.contentView addSubview:lineImage2];
    [lineImage2 release];
    
    UILabel * chupanLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 109, oneImageView.frame.size.height)];
    chupanLabel.backgroundColor = [UIColor clearColor];
    chupanLabel.textAlignment = NSTextAlignmentCenter;
    chupanLabel.font = [UIFont systemFontOfSize:14];
    chupanLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    chupanLabel.text = @"初盘";
    [oneImageView addSubview:chupanLabel];
    [chupanLabel release];
    
    oneShengLable = [[UILabel alloc] initWithFrame:CGRectMake(109, 0, 50, oneImageView.frame.size.height)];
    oneShengLable.backgroundColor = [UIColor clearColor];
    oneShengLable.textAlignment = NSTextAlignmentCenter;
    oneShengLable.font = [UIFont systemFontOfSize:14];
    oneShengLable.textColor = [UIColor blackColor];
//    oneShengLable.text = @"6.7";
    [oneImageView addSubview:oneShengLable];
    [oneShengLable release];
    
    onePingLable = [[UILabel alloc] initWithFrame:CGRectMake(159, 0, 98, oneImageView.frame.size.height)];
    onePingLable.backgroundColor = [UIColor clearColor];
    onePingLable.textAlignment = NSTextAlignmentCenter;
    onePingLable.font = [UIFont systemFontOfSize:14];
    onePingLable.textColor = [UIColor blackColor];
//    onePingLable.text = @"3/3.5球";
    [oneImageView addSubview:onePingLable];
    [onePingLable release];
    
    
    oneFuLable = [[UILabel alloc] initWithFrame:CGRectMake(258, 0, 320 - 258, oneImageView.frame.size.height)];
    oneFuLable.backgroundColor = [UIColor clearColor];
    oneFuLable.textAlignment = NSTextAlignmentCenter;
    oneFuLable.font = [UIFont systemFontOfSize:14];
    oneFuLable.textColor = [UIColor blackColor];
//    oneFuLable.text = @"1.44";
    [oneImageView addSubview:oneFuLable];
    [oneFuLable release];
    
    
    
    UIImageView * twoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30+49.5, 320, 49.5)];
    twoImageView.backgroundColor = [UIColor colorWithRed:255/255.0 green:253/255.0 blue:245/255.0 alpha:1];
    twoImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:twoImageView];
    [twoImageView release];
    
    UILabel * jishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 109, twoImageView.frame.size.height)];
    jishiLabel.backgroundColor = [UIColor clearColor];
    jishiLabel.textAlignment = NSTextAlignmentCenter;
    jishiLabel.font = [UIFont systemFontOfSize:14];
    jishiLabel.textColor = [UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1];
    jishiLabel.text = @"即时";
    [twoImageView addSubview:jishiLabel];
    [jishiLabel release];
    
    twoShengLable = [[UILabel alloc] initWithFrame:CGRectMake(109, 0, 50, 49.5)];
    twoShengLable.backgroundColor = [UIColor clearColor];
    twoShengLable.textAlignment = NSTextAlignmentCenter;
    twoShengLable.font = [UIFont systemFontOfSize:14];
    twoShengLable.textColor = [UIColor blackColor];
//    twoShengLable.text = @"6.7";
    [twoImageView addSubview:twoShengLable];
    [twoShengLable release];
    
    jianImageOne = [[UIImageView alloc] initWithFrame:CGRectMake(159 - 7, (49.5 - 7)/2, 7, 7)];
    jianImageOne.backgroundColor = [UIColor clearColor];
    [twoImageView addSubview:jianImageOne];
    [jianImageOne release];
    
    twoPingLable = [[UILabel alloc] initWithFrame:CGRectMake(159, 0, 98, twoImageView.frame.size.height)];
    twoPingLable.backgroundColor = [UIColor clearColor];
    twoPingLable.textAlignment = NSTextAlignmentCenter;
    twoPingLable.font = [UIFont systemFontOfSize:14];
    twoPingLable.textColor = [UIColor blackColor];
//    twoPingLable.text = @"3/3.5球";
    [twoImageView addSubview:twoPingLable];
    [twoPingLable release];
    
    jianImageTwo = [[UIImageView alloc] initWithFrame:CGRectMake(159+98 - 7, (49.5 - 7)/2, 7, 7)];
    jianImageTwo.backgroundColor = [UIColor clearColor];
    [twoImageView addSubview:jianImageTwo];
    [jianImageTwo release];
    
    
    twoFuLable = [[UILabel alloc] initWithFrame:CGRectMake(258, 0, 320 - 258, twoImageView.frame.size.height)];
    twoFuLable.backgroundColor = [UIColor clearColor];
    twoFuLable.textAlignment = NSTextAlignmentCenter;
    twoFuLable.font = [UIFont systemFontOfSize:14];
    twoFuLable.textColor = [UIColor blackColor];
    
    jianImageThree = [[UIImageView alloc] initWithFrame:CGRectMake(258+320 - 258 - 7, (49.5 - 7)/2, 7, 7)];
    jianImageThree.backgroundColor = [UIColor clearColor];
    [twoImageView addSubview:jianImageThree];
    [jianImageThree release];
    
//    twoFuLable.text = @"1.44";
    [twoImageView addSubview:twoFuLable];
    [twoFuLable release];
    
     openButton = [UIButton buttonWithType:UIButtonTypeCustom];
    openButton.frame = CGRectMake(0, 0, 108, twoImageView.frame.size.height);
    openButton.tag = 1;
    [openButton addTarget:self action:@selector(pressOpenButton:) forControlEvents:UIControlEventTouchUpInside];
    [twoImageView addSubview:openButton];
    
    openImage = [[UIImageView alloc] initWithFrame:CGRectMake(75, (twoImageView.frame.size.height - 12.5)/2, 9, 12.5)];
    openImage.backgroundColor = [UIColor clearColor];
    openImage.image = UIImageGetImageFromName(@"bdheadguanbi2.png");//bdheaddakai.png
    [openButton addSubview:openImage];
    [openImage release];
    
    
    
    
    
}

- (void)pressOpenButton:(UIButton *)sender{

    if (sender.tag == 1) {
        sender.tag = 2;
        openImage.image = UIImageGetImageFromName(@"bdheaddakai.png");
        openImage.frame = CGRectMake(75, (49.5 - 12.5)/2, 9, 12.5);
        NSArray * dataArray = nil;
        
        if (oddsInteger == 1) {
            dataArray = [oddsDictionary objectForKey:@"euro"];
        }else if (oddsInteger == 2){
            
            dataArray = [oddsDictionary objectForKey:@"asia"];
        }else if (oddsInteger == 3){
           
            dataArray = [oddsDictionary objectForKey:@"ball"];
        }
        
        if (dataArray) {
            
            NSDictionary * daDict = [dataArray objectAtIndex:indexOdds.row];
            
            NSArray *  countArray = [daDict objectForKey:@"change"];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.2f];
            [UIView setAnimationDelegate:self];
            openView.frame = CGRectMake(0, 129, 320, [countArray count] * 50);
            myTabelView.frame = CGRectMake(0, 0, 320, [countArray count] * 50);
            [UIView commitAnimations];
            
        }
        
//        [myTabelView reloadData];
    }else{
        sender.tag = 1;
        openImage.image = UIImageGetImageFromName(@"bdheadguanbi2.png");//bdheadguanbi2
        openImage.frame = CGRectMake(75, (49.5 - 9)/2, 12.5, 9);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2f];
        [UIView setAnimationDelegate:self];
        openView.frame = CGRectMake(0, 129, 320, 0);
        myTabelView.frame = CGRectMake(0, 0, 320, 0);
        [UIView commitAnimations];
        
        

    }
    
    if (delegate && [delegate respondsToSelector:@selector(OddsTableViewCellDelegateButtonTag:indexPath:)]) {
        [delegate OddsTableViewCellDelegateButtonTag:sender.tag indexPath:indexOdds];
    }
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self tableViewCellShow];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    