//
//  ManagerSayCell.m
//  店长说Cell
//
//  Created by hb on 16/9/5.
//  Copyright © 2016年 com.bm.hb. All rights reserved.
//

#import "ManagerSayCell.h"
#import "ManagerImageCLVCell.h"//图片
#import "CommonUtils.h"

@interface ManagerSayCell()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>{
    NSMutableArray *maImages;
    NSMutableArray *maComments;
    
    NSInteger rowNumber;//默认每行3个
    CGFloat cellSpace;//cell之间的间距
    CGFloat cellHeight;//cell内容的高度
    CGFloat cellWidth;//cell内容的宽度
    CGFloat screenWidth;//屏幕宽度
    CGFloat perWidth;//屏幕宽度/每行个数
}


/**
 *  UI
 */
@property (weak, nonatomic) IBOutlet UIImageView      *ivHeader;
@property (weak, nonatomic) IBOutlet UILabel          *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel          *lblName;
@property (weak, nonatomic) IBOutlet UILabel          *lblTime;
@property (weak, nonatomic) IBOutlet UILabel          *lblBrief;
@property (weak, nonatomic) IBOutlet UICollectionView *clv;
@property (weak, nonatomic) IBOutlet UIImageView      *ivAddress;
@property (weak, nonatomic) IBOutlet UILabel          *lblAddress;

@property (weak, nonatomic) IBOutlet UILabel          *lblComment;
@property (weak, nonatomic) IBOutlet UIButton         *btnShowComment;

@property (weak, nonatomic) IBOutlet UIView           *viewBottom;
@property (weak, nonatomic) IBOutlet UIImageView      *ivFavorite;
@property (weak, nonatomic) IBOutlet UILabel          *lblFavoriteNum;
@property (weak, nonatomic) IBOutlet UIButton         *btnFavorite;
@property (weak, nonatomic) IBOutlet UIImageView      *ivComment;
@property (weak, nonatomic) IBOutlet UILabel          *lblCommentNum;
@property (weak, nonatomic) IBOutlet UIButton         *btnComment;
@property (weak, nonatomic) IBOutlet UIImageView      *ivPriase;
@property (weak, nonatomic) IBOutlet UILabel          *lblPraiseNum;
@property (weak, nonatomic) IBOutlet UIButton         *btnPraise;

/**
 *  cons
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBriefHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consCLVWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consCLVHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consShowMoreTopHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consShowMoreBottomHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consShowMoreHeight;

@end

@implementation ManagerSayCell

#pragma mark - 生命周期

- (void)awakeFromNib
{
    rowNumber = 3;
    cellSpace = 4;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    perWidth = screenWidth/rowNumber;
    cellWidth = (screenWidth - (rowNumber-1)*cellSpace)/rowNumber;
    cellHeight = cellWidth;
    
    maImages = [NSMutableArray array];
    maComments = [NSMutableArray array];
    _consCLVWidth.constant = screenWidth;
    
    [_clv registerNib:[UINib nibWithNibName:@"ManagerImageCLVCell" bundle:nil] forCellWithReuseIdentifier:@"ManagerImageCLVCell"];
    _clv.scrollEnabled = NO;
    _clv.backgroundColor = [UIColor whiteColor];
    _clv.dataSource = self;
    _clv.delegate = self;
    
    int num = arc4random()%9 + 1;
    for (int i = 0; i< num; i++) {
        [maImages addObject:[UIImage imageNamed:@"icon"]];
    }
    [maComments addObject:@"1  这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息."];
    [maComments addObject:@"2  这是一个测试信息."];
    [maComments addObject:@"3  这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息,这是一个测试信息."];
    
    if (maImages.count == 1) {
        _consCLVHeight.constant = perWidth;
        _consCLVWidth.constant = perWidth;
    } else if (maImages.count == 2) {
        _consCLVHeight.constant = perWidth;
        _consCLVWidth.constant = 2 * perWidth;
    } else if (maImages.count == 3) {
        _consCLVHeight.constant = perWidth;
        _consCLVWidth.constant = screenWidth;
    } else if (maImages.count == 4) {
        _consCLVHeight.constant = 2 * perWidth;
        _consCLVWidth.constant = 2 * perWidth;
    } else {
        if (maImages.count%rowNumber == 0) {
            _consCLVHeight.constant = (maImages.count/rowNumber) * perWidth;
            _consCLVWidth.constant = screenWidth;
        } else {
            _consCLVHeight.constant = (1 + (maImages.count/rowNumber)) * perWidth;
            _consCLVWidth.constant = screenWidth;
        }
    }
    
    [self.btnShowComment addTarget:self action:@selector(showMoreCommentAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnFavorite addTarget:self action:@selector(favoriteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnComment addTarget:self action:@selector(commentAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btnPraise addTarget:self action:@selector(priaseAction) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - Custom Functions

/**
 *  查看更多评论点击
 */
- (void)showMoreCommentAction
{
    if (self.onShowMoreCommentClickBlock) {
        self.onShowMoreCommentClickBlock(self.model);
    }
}

/**
 *  喜欢点击
 */
- (void)favoriteAction
{
    if (self.onFavouriteClickBlock) {
        self.onFavouriteClickBlock(self.model);
    }
}

/**
 *  评论点击
 */
- (void)commentAction
{
    if (self.onCommentClickBlock) {
        self.onCommentClickBlock(self.model);
    }
}

/**
 *  赞点击
 */
- (void)priaseAction
{
    if (self.onPraiseClickBlock) {
        self.onPraiseClickBlock(self.model);
    }
}

/**
 *  显示查看更多评论那妞
 */
- (void)showMoreButton
{
    [_btnShowComment setTitle:@" 查看更多评价" forState:UIControlStateNormal];
    _consShowMoreHeight.constant = 25;
    _consShowMoreTopHeight.constant = 8;
    _consShowMoreBottomHeight.constant = 8;
    [self setNeedsLayout];
}

/**
 *  隐藏查看更多评论那妞
 */
- (void)hiddenMoreButton
{
    [_btnShowComment setTitle:nil forState:UIControlStateNormal];
    _consShowMoreHeight.constant = 0;
    _consShowMoreTopHeight.constant = 0;
    _consShowMoreBottomHeight.constant = 0;
    [self setNeedsLayout];
}

/**
 *  根据对象返回 遍历完成的带有属性的字符串
 *
 *  @param models of models
 *
 *  @return 属性字符串
 */
- (NSMutableAttributedString *)attributeStringWithModels:(NSArray *)models
{
    //存放用户名的range
    NSMutableArray *ranges = [NSMutableArray array];
    //整个拼接完成的字符串
    NSMutableString *mergedString = [NSMutableString string];
    
    //1.循环 -> 拼接  小明: 商品不错啊 \n  最后一个\n去掉
    //2.记录  小明: Range   (用数组)
    NSInteger mergedStrLength = 0;//记录当前字符串的长度
    
    for (int i = 0; i < models.count; i ++) {
        NSString *username = @"观阴大湿";
        NSString *commentStr = models[i];
        NSString *mergedStr = [NSString stringWithFormat:@"%@: %@\n",username,commentStr];
        if (i == models.count - 1) {
            mergedStr = [mergedStr substringToIndex:mergedStr.length - 2];
        }
        [mergedString appendString:mergedStr];
        
        NSRange usernameRange = NSMakeRange(mergedStrLength, username.length + 1);
        NSDictionary *rangeDic = @{
                                   @"location":[NSString stringWithFormat:@"%ld",usernameRange.location],
                                   @"length":[NSString stringWithFormat:@"%ld",usernameRange.length]
                                   };
        [ranges addObject:rangeDic];
        
        mergedStrLength = mergedString.length;
    }
    
    //3.创建整个属性字符串
    NSMutableAttributedString *attributes = [[NSMutableAttributedString alloc] initWithString:mergedString];
    //4.循环 -> 根据 数组中存储的Range -> 添加属性
    for (NSDictionary *rangeDic in ranges) {
        NSRange range = NSMakeRange([rangeDic[@"location"] integerValue], [rangeDic[@"length"] integerValue]);
        [attributes addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    }
    return attributes;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Public Method

- (NSArray *)images
{
    return maImages.copy;
}

#pragma mark - Setter

- (void)setModel:(NSString *)model
{
    _model = model;
    self.lblBrief.text = model;
    
    NSMutableArray *maCommentForDisplay = [NSMutableArray array];
    if (maComments.count > 2) {
        maCommentForDisplay = [maComments subarrayWithRange:NSMakeRange(0, 2)].mutableCopy;
        [self showMoreButton];
    } else {
        maCommentForDisplay = maComments;
        [self hiddenMoreButton];
    }
    _lblComment.attributedText = [self attributeStringWithModels:maCommentForDisplay];
    _consBriefHeight.constant = [CommonUtils heightForLabel:_lblBrief WithText:model width:screenWidth - 16];
    
    [self setNeedsLayout];
}

#pragma mark - CollectionView Datasource & Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return maImages.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellHeight, cellWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return cellSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return cellSpace;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ManagerImageCLVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ManagerImageCLVCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ManagerImageCLVCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.onItemClikcBlock) {
        self.onItemClikcBlock(indexPath);
    }
}



@end
