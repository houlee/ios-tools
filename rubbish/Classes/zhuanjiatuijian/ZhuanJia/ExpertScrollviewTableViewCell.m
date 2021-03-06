//
//  ExpertScrollviewTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/22.
//
//

#import "ExpertScrollviewTableViewCell.h"
#import "ExpertMainCollectionViewCell.h"
#import "MJRefresh.h"

@implementation ExpertScrollviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withHeight:(CGFloat)height
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        size.height = height;
        dataArym = [[NSMutableArray alloc]initWithCapacity:0];
        
        [self loadCollectionView];
    }
    return self;
}
-(void)loadCollectionView{
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为水平流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为100*100
//    layout.itemSize = CGSizeMake(70, 90);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    //创建collectionView 通过一个布局策略layout来创建
    _listCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height) collectionViewLayout:layout];
    _listCollection.backgroundColor = [UIColor clearColor];
    _listCollection.showsHorizontalScrollIndicator = NO;
    //代理设置
    _listCollection.delegate=self;
    _listCollection.dataSource=self;
    _listCollection.pagingEnabled = YES;
    //注册item类型 这里使用系统的类型
    [_listCollection registerClass:[ExpertMainCollectionViewCell class] forCellWithReuseIdentifier:@"ExpertMainCollectionViewCell"];
    [self.contentView addSubview:_listCollection];
}
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return dataArym.count;
//}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return dataArym.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"ExpertMainCollectionViewCell";
    ExpertMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"-----------------");
    }
    cell.myTableView.scrollEnabled = NO;
    if(indexPath.row < dataArym.count){
        [cell loadAppointInfo:[dataArym objectAtIndex:indexPath.row]];
    }
    __block ExpertScrollviewTableViewCell * newSelf = self;
    cell.didSelectRow = ^(UITableView * tableView, NSIndexPath * index) {
        if(newSelf.didSelectRow){
            newSelf.didSelectRow(tableView,index,indexPath);
        }
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(size.width, size.height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //    if(section == dataArym.count-1){
    //        return UIEdgeInsetsMake(0, 0, 0, 0);
    //    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"123123123");
}
-(void)loadAppointInfo:(NSArray *)ary{
    
    [dataArym removeAllObjects];
    [dataArym addObjectsFromArray:ary];
    [self.listCollection reloadData];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    if(self.collectionScrollEnd){
//        self.collectionScrollEnd(scrollView.contentOffset.x);
//    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.collectionScrollEnd){
        self.collectionScrollEnd(scrollView.contentOffset.x);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

int aaaaab,bbbbbc,cccccd,ddddde,eeeeef,fffffg;

int abcdefe,dddafef11111;
int aefegvefef,feifegeg=0;

    