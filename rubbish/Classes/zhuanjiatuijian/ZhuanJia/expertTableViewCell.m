//
//  expertTableViewCell.m
//  caibo
//
//  Created by cp365dev6 on 2016/11/21.
//
//

#import "expertTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation expertTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        size = [UIScreen mainScreen].bounds.size;
        
        dataArym = [[NSMutableArray alloc]initWithCapacity:0];
        
        [self loadCollectionView];
        
//        UIImageView *lineIma = [[UIImageView alloc]initWithFrame:CGRectMake(0, 89.5, size.width, 0.5)];
//        lineIma.backgroundColor = SEPARATORCOLOR;
//        [self.contentView addSubview:lineIma];
    }
    return self;
}
-(void)loadCollectionView{
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为水平流布局
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(70, 90);
    //创建collectionView 通过一个布局策略layout来创建
    _expertCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, size.width, 90) collectionViewLayout:layout];
    _expertCollection.backgroundColor = [UIColor clearColor];
    _expertCollection.showsHorizontalScrollIndicator = NO;
    //代理设置
    _expertCollection.delegate=self;
    _expertCollection.dataSource=self;
    //注册item类型 这里使用系统的类型
    [_expertCollection registerClass:[ExpertCollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.contentView addSubview:_expertCollection];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return dataArym.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"cellid";
    ExpertCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"-----------------");
    }
    ExpertJingjiModel *model = [dataArym objectAtIndex:indexPath.section];
    
    [cell.headIma sd_setImageWithURL:[NSURL URLWithString:model.headPortrait] placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageContinueInBackground|SDWebImageRetryFailed];
    cell.nameLab.text = model.expertsNickName;
    cell.desLab.text = [NSString stringWithFormat:@"近%@中%@",model.totalNum,model.hitNum];
    
    UIImage *image = cell.headIma.image;
    cell.headIma.layer.contents = (__bridge id)image.CGImage;
    cell.headIma.layer.contentsGravity = kCAGravityResizeAspectFill;
    cell.headIma.layer.contentsScale = image.scale;
    cell.headIma.layer.masksToBounds = YES;
    cell.headIma.layer.cornerRadius = 20;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 90);
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
    if(self.didSelectRow){
        self.didSelectRow(indexPath);
    }
}
-(void)loadAppointInfo:(NSArray *)ary{
    
    [dataArym removeAllObjects];
    [dataArym addObjectsFromArray:ary];
    [self.expertCollection reloadData];
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