//
//  ExpertMainCollectionViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import "ExpertMainCollectionViewCell.h"
#import "MJRefresh.h"
#import "SharedMethod.h"
#import "ExpertMainListModel.h"

@implementation ExpertMainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        dataArym = [[NSMutableArray alloc]initWithCapacity:0];
        _myTableView = [[UITableView alloc] initWithFrame:self.bounds];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        [self addSubview:_myTableView];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor clearColor];
        
//        __block ExpertMainCollectionViewCell * newSelf = self;
//
//        _myTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            
//            newSelf.refreshHeader(_myTableView);
//        }];
//        
//        _myTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//            
//            newSelf.refreshFooter(_myTableView);
//        }];
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArym.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpertMainListModel *model = [dataArym objectAtIndex:indexPath.row];
    if([model.LOTTEY_CLASS_CODE isEqualToString:@"201"]){
        return 135;
    }else{
        return 95;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellID = @"ExpertMainListTableViewCell";
    ExpertMainListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[ExpertMainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ExpertMainListModel *model = [dataArym objectAtIndex:indexPath.row];
    cell.isZhuanjia = YES;
    __block ExpertMainCollectionViewCell * newSelf = self;
    cell.buttonAction = ^(UIButton *button) {
        if(newSelf.buttonAction){
            newSelf.buttonAction(indexPath);
        }
    };
//    if(!_isZhuanjia){
//        if(indexPath.row == 0){
//            cell.rankingIma.hidden = NO;
//            cell.rankingIma.image = [UIImage imageNamed:@"expert_first.png"];
//        }else if (indexPath.row == 1){
//            cell.rankingIma.hidden = NO;
//            cell.rankingIma.image = [UIImage imageNamed:@"expert_second.png"];
//        }else if (indexPath.row == 2){
//            cell.rankingIma.hidden = NO;
//            cell.rankingIma.image = [UIImage imageNamed:@"expert_third.png"];
//        }else{
//            cell.rankingIma.hidden = YES;
//        }
//    }else{
//        cell.rankingIma.hidden = YES;
//    }
    [cell loadAppointInfo:model];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.didSelectRow){
        self.didSelectRow(tableView,indexPath);
    }
}
-(void)loadAppointInfo:(NSArray *)ary{
    
    [dataArym removeAllObjects];
    [dataArym addObjectsFromArray:ary];
    
    [_myTableView reloadData];
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    