//
//  FocusEventsView.m
//  caibo
//
//  Created by GongHe on 2016/10/11.
//
//

#import "FocusEventsView.h"
#import "GC_JingCaiDuizhenResult.h"
#import "SharedMethod.h"

@implementation FocusEventsView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((MyWidth - 306)/2.0, 0, 306, 145)];
        _bgImageView.image = [UIImage imageNamed:@"FocusEventsBG.png"];
        [self addSubview:_bgImageView];
        
        _titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake((_bgImageView.frame.size.width - 75.5)/2.0, 10, 75.5, 20)];
        _titleImageView.image = [UIImage imageNamed:@"FocusEventsTitle.png"];
        [_bgImageView addSubview:_titleImageView];
        
        _pageControl = [[YH_PageControl alloc] init];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.dotWidth = 5;
        _pageControl.dotHeight = 5;
        _pageControl.spacing = 5;
        _pageControl.dotNormalImage = @"FocusLunboDot.png";
        _pageControl.dotSelectImage = @"FocusLunboDot1.png";
        [_bgImageView addSubview:_pageControl];
        
        _moneySelectArray = [[NSArray alloc] initWithObjects:@"10元", @"50元", @"100元", @"200元", @"500元", nil];
    }
    return self;
}

-(NSMutableArray *)dataArray{
    return _dataArray;
}

-(void)setDataArray:(NSMutableArray *)dataArray
{
    if(_dataArray != dataArray){
        _dataArray = dataArray;
    }
    
    if (_mainScrollView) {
        [_mainScrollView removeFromSuperview];
        self.mainScrollView = nil;
    }
    
    if (dataArray.count == 1) {
        _pageControl.hidden = YES;
    }else{
        _pageControl.hidden = NO;
    }
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_bgImageView.frame.origin.x, _bgImageView.frame.origin.y, _bgImageView.frame.size.width, self.frame.size.height)];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.delegate = self;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:_mainScrollView];
    
    [self creatEventsViewByDataArray:dataArray];
    
    _mainScrollView.contentSize = CGSizeMake(_dataArray.count * _bgImageView.frame.size.width, 0);
    
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = _dataArray.count;
    _pageControl.frame = CGRectMake(((_bgImageView.frame.size.width - (_dataArray.count * 10 - 5)))/2.0, _bgImageView.frame.size.height - 12, _dataArray.count * 10 - 5, 10);
    _pageControl.backgroundColor = [UIColor clearColor];
}

-(void)creatEventsViewByDataArray:(NSArray *)dataArray
{
    for (int i = 0; i < dataArray.count; i++) {
        GC_JingCaiDuizhenResult *result = [dataArray objectAtIndex:i];
        
        UIView * eventBGView = [[UIView alloc] initWithFrame:CGRectMake(i * _bgImageView.frame.size.width, 0, _bgImageView.frame.size.width, _bgImageView.frame.size.height)];
        eventBGView.backgroundColor = [UIColor clearColor];
        eventBGView.tag = 10000 + i;
        [_mainScrollView addSubview:eventBGView];
        _curEventView = eventBGView;
        
        float width = 10;
        
        UIButton * selectedButton;
        
        for (int i = 0; i < 3; i++) {
            int type = 1;
            float buttonWidth = 100;
            if (i == 1) {
                type = 0;
                buttonWidth = 76;
            }
            UIButton * teamButton = [self creatTeamButtonByType:type Frame:CGRectMake(width, ORIGIN_Y(_titleImageView) + 10, buttonWidth, 45) result:result];
            [eventBGView addSubview:teamButton];
            [teamButton addTarget:self action:@selector(touchTeamButton:) forControlEvents:UIControlEventTouchUpInside];
            teamButton.tag = 1000 + i;
            width += teamButton.frame.size.width + 5;
            
            UILabel * nameLabel = [teamButton viewWithTag:100];
            UILabel * oddsLabel = [teamButton viewWithTag:200];

            NSArray * oddsArray = [result.odds componentsSeparatedByString:@" "];
            
            NSArray * sortedArray = [SharedMethod getSortedArrayByArray:oddsArray];
            
            if (i == 0) {
                NSString * temeName = [result.homeTeam stringByReplacingOccurrencesOfString:@"　" withString:@""];
                nameLabel.text = [NSString stringWithFormat:@"%@ 胜",temeName];
            }
            else if (i == 1) {
                nameLabel.text = @"平";
            }
            else if (i == 2) {
                NSString * temeName = [result.vistorTeam stringByReplacingOccurrencesOfString:@"　" withString:@""];
                nameLabel.text = [NSString stringWithFormat:@"%@ 胜",temeName];
            }
            oddsLabel.text = [oddsArray objectAtIndex:i];

            if ([[sortedArray objectAtIndex:0] isEqualToString:oddsLabel.text]) {
                selectedButton = teamButton;
            }
        }
        
        UIButton * moneyButton = [[UIButton alloc] initWithFrame:CGRectMake(10, ORIGIN_Y(selectedButton) + 10, 75, 30)];
        [moneyButton setBackgroundImage:[UIImage imageNamed:@"FocusEventsMoneyButton.png"] forState:UIControlStateNormal];
        moneyButton.tag = 300;
        [eventBGView addSubview:moneyButton];
        [moneyButton addTarget:self action:@selector(touchMoneyButton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView * arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(moneyButton.frame.size.width - 14 - 10.5, (moneyButton.frame.size.height - 6)/2.0, 10.5, 6)];
        arrowImageView.image = [UIImage imageNamed:@"FocusEventsArrow.png"];
        [moneyButton addSubview:arrowImageView];
        
        UILabel * moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, arrowImageView.frame.origin.x - 10, moneyButton.frame.size.height)];
        moneyLabel.textColor = DEFAULT_TEXTBLACKCOLOR;
        moneyLabel.font = [UIFont systemFontOfSize:12];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.text = @"50元";
        moneyLabel.textAlignment = 2;
        moneyLabel.tag = 310;
        [moneyButton addSubview:moneyLabel];
        
        UIImageView * moneySelectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(moneyButton.frame.origin.x, ORIGIN_Y(moneyButton), 285, 30)];
        moneySelectImageView.image = [UIImage imageNamed:@"FocusEventsMoneySelect"];
        [eventBGView addSubview:moneySelectImageView];
        moneySelectImageView.userInteractionEnabled = YES;
        moneySelectImageView.hidden = YES;
        moneySelectImageView.tag = 320;
        
        for (int i = 0; i < 5; i++) {
            UIButton * moneySelectButton = [[UIButton alloc] initWithFrame:CGRectMake(i * (moneySelectImageView.frame.size.width/5.0), 0, moneySelectImageView.frame.size.width/5.0, moneySelectImageView.frame.size.height)];
            [moneySelectButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7] forState:UIControlStateNormal];
            moneySelectButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [moneySelectButton setTitle:[_moneySelectArray objectAtIndex:i] forState:UIControlStateNormal];
            [moneySelectImageView addSubview:moneySelectButton];
            [moneySelectButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            [moneySelectButton setBackgroundImage:[UIImage imageNamed:@"FocusMoneySelectButton1.png"] forState:UIControlStateSelected];
            moneySelectButton.tag = 321 + i;
            [moneySelectButton addTarget:self action:@selector(touchMoneySelect:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(moneySelectButton.frame.size.width - 0.5, 6, 0.5, moneySelectButton.frame.size.height - 12)];
            lineView.backgroundColor = [SharedMethod getColorByHexString:@"cccccc"];
            [moneySelectButton addSubview:lineView];
        }
        
        UIButton * buyButton = [[UIButton alloc] initWithFrame:CGRectMake(ORIGIN_X(moneyButton) + 7, ORIGIN_Y(selectedButton) + 10, 203, 30)];
        [buyButton setBackgroundImage:[UIImage imageNamed:@"FocusEventsBuyButton.png"] forState:UIControlStateNormal];
        buyButton.tag = 400;
        [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyButton addTarget:self action:@selector(toBuy:) forControlEvents:UIControlEventTouchUpInside];
        [eventBGView addSubview:buyButton];
        
        [self touchTeamButton:selectedButton];

    }
    if (dataArray && dataArray.count) {
        _curEventView = [_mainScrollView viewWithTag:10000];
    }
}

-(UIButton *)creatTeamButtonByType:(int)type Frame:(CGRect)frame result:(GC_JingCaiDuizhenResult *)result//type 0 短 1 长
{
    UIButton * teamButton = [[UIButton alloc] initWithFrame:frame];
    if (type) {
        [teamButton setBackgroundImage:[UIImage imageNamed:@"FocusEventsTeamButton_L.png"] forState:UIControlStateNormal];
        [teamButton setBackgroundImage:[UIImage imageNamed:@"FocusEventsTeamButton_L1.png"] forState:UIControlStateSelected];
    }else{
        [teamButton setBackgroundImage:[UIImage imageNamed:@"FocusEventsTeamButton_S.png"] forState:UIControlStateNormal];
        [teamButton setBackgroundImage:[UIImage imageNamed:@"FocusEventsTeamButton_S1.png"] forState:UIControlStateSelected];
    }

    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, teamButton.frame.size.width, 13)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont systemFontOfSize:13];
    nameLabel.textColor = [SharedMethod getColorByHexString:@"1588da"];
    nameLabel.textAlignment = 1;
    nameLabel.tag = 100;
    [teamButton addSubview:nameLabel];
    
    UILabel * oddsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ORIGIN_Y(nameLabel) + 5, teamButton.frame.size.width, 11)];
    oddsLabel.backgroundColor = [UIColor clearColor];
    oddsLabel.font = [UIFont systemFontOfSize:11];
    oddsLabel.textColor = [SharedMethod getColorByHexString:@"59b1f0"];
    oddsLabel.textAlignment = 1;
    oddsLabel.tag = 200;
    [teamButton addSubview:oddsLabel];

    return teamButton;
}

-(void)touchTeamButton:(UIButton *)button
{
    for (int i = 0; i < 3; i ++) {
        UIButton * teamButton = [_curEventView viewWithTag:1000 + i];
        
        UILabel * nameLabel = [teamButton viewWithTag:100];
        UILabel * oddsLabel = [teamButton viewWithTag:200];
        
        if (button == teamButton) {
            teamButton.selected = YES;
            nameLabel.textColor = [UIColor whiteColor];
            oddsLabel.textColor = [SharedMethod getColorByHexString:@"d4edff"];
        }else{
            teamButton.selected = NO;
            nameLabel.textColor = [SharedMethod getColorByHexString:@"1588da"];
            oddsLabel.textColor = [SharedMethod getColorByHexString:@"59b1f0"];
        }
    }
    [self getExpectedBonus];
}

-(void)getExpectedBonus
{
    NSString * selectedOdds = @"";
    
    for (int i = 0; i < 3; i ++) {
        UIButton * teamButton = [_curEventView viewWithTag:1000 + i];
        UILabel * oddsLabel = [teamButton viewWithTag:200];
        if (teamButton.selected) {
            selectedOdds = oddsLabel.text;
        }
    }
    
    UILabel * moneyLabel = [_curEventView viewWithTag:310];
    UIButton * buyButton = [_curEventView viewWithTag:400];
    
    NSString * buyString = [NSString stringWithFormat:@"确认购买（预计奖金%.2f元）",[moneyLabel.text intValue] *  [selectedOdds floatValue]];
    NSMutableAttributedString * buyAString = [[NSMutableAttributedString alloc] initWithString:buyString];
    [buyAString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, buyString.length)];
    [buyAString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor whiteColor]} range:[buyString rangeOfString:@"确认购买"]];
    
    [buyButton setAttributedTitle:buyAString forState:UIControlStateNormal];
}

-(void)touchMoneyButton:(UIButton *)button
{
    button.selected = !button.selected;
    UIImageView * moneySelectImageView = [_curEventView viewWithTag:320];

    UILabel * moneyLabel = [_curEventView viewWithTag:310];

    if (button.selected) {
        moneySelectImageView.hidden = NO;
        for (int i = 0; i < _moneySelectArray.count; i++) {
            UIButton * selectButton = [moneySelectImageView viewWithTag:321 + i];
            if ([selectButton.titleLabel.text isEqualToString:moneyLabel.text]) {
                selectButton.selected = YES;
            }else{
                selectButton.selected = NO;
            }
        }
    }else{
        moneySelectImageView.hidden = YES;
        [self getExpectedBonus];
    }
}

-(void)touchMoneySelect:(UIButton *)button
{
    UIButton * moneyButton = [_curEventView viewWithTag:300];
    UILabel * moneyLabel = [_curEventView viewWithTag:310];
    
    moneyLabel.text = button.titleLabel.text;
    [self touchMoneyButton:moneyButton];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = (scrollView.contentOffset.x + scrollView.frame.size.width/2)/scrollView.frame.size.width;
    _pageControl.currentPage = page;
    _curEventView = [self viewWithTag:10000 + _pageControl.currentPage];
}

-(void)toBuy:(UIButton *)button
{
    if (_delegate && [_delegate respondsToSelector:@selector(focusEventsView:)]) {
        for (int i = 0; i < 3; i ++) {
            UIButton * teamButton = [_curEventView viewWithTag:1000 + i];
            if (teamButton.selected) {
                UILabel * oddsLabel = [teamButton viewWithTag:200];

                self.curSelectedOdds = oddsLabel.text;
                self.curSelectedTag = i;
            }
        }
        UILabel * moneyLabel = [_curEventView viewWithTag:310];
        self.payMoney = moneyLabel.text;
        [_delegate focusEventsView:self];
    }
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    