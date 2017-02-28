//
//  HomeViewController.m
//  nen
//
//  Created by nenios101 on 2017/2/27.
//
//

#import "HomeViewController.h"
#import "JZLCycleView.h"
#import "OptionModel.h"
#import "OptionView.h"
#import "YFRollingLabel.h"
#import "DeliciousFoodCell.h"
#import "CurrencyView.h"
#import "BrandView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define Height 200

@interface HomeViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UIScrollView *scrollView;
// 图片轮播器
@property (nonatomic, weak) JZLCycleView *headPictureCarouselView;
// 模型数组
@property (nonatomic, strong) NSArray *appList;
// 选项区
@property(nonatomic,strong) UIView *opctionview;

// 跑马灯文本
@property (nonatomic, strong) YFRollingLabel *horseRaceLampLabel;

@property(nonatomic,strong) UICollectionView *colletionView;

//品推荐
@property(nonatomic,strong) UIView *brandView;


@end

@implementation HomeViewController


#pragma mark 模拟数据数组
- (NSArray *)arraysList
{
    if (_appList == nil) {
        NSMutableArray *mutArray = [NSMutableArray array];
        NSArray * array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app.plist" ofType:nil]];
        for (NSDictionary *dict in array) {
            [mutArray addObject:[OptionModel modelWithDict:dict]];
        }
        _appList = mutArray;
    }
    
    return _appList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 添加左边导航栏按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刚需求" style:UIBarButtonItemStylePlain target:self action:@selector(balck)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    // 添加导航栏搜索
    CGRect mainViewBounds = self.navigationController.view.bounds;
    UISearchBar *customSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(CGRectGetWidth(mainViewBounds)/2-((CGRectGetWidth(mainViewBounds)-120)/2), CGRectGetMinY(mainViewBounds)+22, CGRectGetWidth(mainViewBounds)-120, 40)];
    customSearchBar.delegate = self;
    customSearchBar.showsCancelButton = NO;
    customSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    [self.navigationController.view addSubview: customSearchBar];
    
    // 创建底部scrollView
    UIScrollView *scrView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,ScreenWidth,ScreenHeight)];
    scrView.contentSize = CGSizeMake(ScreenWidth,ScreenHeight *2);
    self.scrollView = scrView;
    [self.view addSubview:scrView];
    
    
    NSMutableArray *arrTemp = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%ld",@"car",(long)i]];
        [arrTemp addObject:image];
    }
    _headPictureCarouselView = [JZLCycleView cycleCollectionViewWithFrame:CGRectMake(0,0, ScreenWidth,Height) imageArray:arrTemp PlaceholderImage:[UIImage imageNamed:@"placeholderImage"]];
    [self.scrollView addSubview:_headPictureCarouselView];

    [self optionView];
    
    [self horseRaceLamp];
    
    [self Foodpictures];
    
    [self brandRecommendation];
    [self familyLife];
}


#pragma mark 导航栏返回按钮方法
- (void)balck
{
    NSLog(@"sssss");
}
#pragma mark 选项区九宫格方法
- (void)optionView{

    self.opctionview = [[UIView alloc] initWithFrame:CGRectMake(0,Height, ScreenWidth, 180)];
    [self arraysList];
    //控制总列数
    int totalColumns = 4;
    CGFloat Y = 0;
    CGFloat W = 60;
    CGFloat H = 80;
    CGFloat X = (self.view.frame.size.width - totalColumns * W) / (totalColumns + 1);
    
    for (int index = 0; index < _appList.count; index++) {
        
        OptionModel *model = _appList[index];
        int row = index / totalColumns;
        int col = index % totalColumns;
        CGFloat viewX = X + col * (W + X);
        CGFloat viewY = 20 + row * (H + Y);
        OptionView *view = [[OptionView alloc] initWithFrame:CGRectMake(viewX, viewY, W, H) Model:model];
        [self.opctionview addSubview:view];
       
    }
    [self.scrollView addSubview:self.opctionview];


}


#pragma mark 加载跑马灯文本
- (void)horseRaceLamp
{
    UIView *view = [[UIView  alloc] initWithFrame:CGRectMake(0,self.opctionview.frame.origin.y + 180,ScreenWidth  , 25)];
    view.backgroundColor = [UIColor redColor];
    
    //添加文字内容
    NSArray *textArray = @[@"THIS IS THE FIRST TEXT",
                           @"THIS IS THE FIRST TEXTYY"
                           ];
    
    self.horseRaceLampLabel = [[YFRollingLabel alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 25)  textArray:textArray font:[UIFont systemFontOfSize:15] textColor:[UIColor whiteColor]];
    [view addSubview:self.horseRaceLampLabel];
    self.horseRaceLampLabel.backgroundColor = [UIColor orangeColor];
    self.horseRaceLampLabel.speed = 2;
    [self.horseRaceLampLabel setOrientation:RollingOrientationLeft];
    [self.horseRaceLampLabel setInternalWidth:self.horseRaceLampLabel.frame.size.width / 3];;
    
    // 获取文字点击文字点击
    self.horseRaceLampLabel.labelClickBlock = ^(NSInteger index){
        NSString *text = [textArray objectAtIndex:index];
        NSLog(@"You Tapped item:%li , and the text is %@",(long)index,text);
    };
    
    
    [self.scrollView addSubview:view];

    
    
}

#pragma mark 加载美食免费推荐
- (void)Foodpictures
{
    CurrencyView *foodPicturesHeadView = [CurrencyView currencyViewWithYvalue:self.opctionview.frame.origin.y + 206 RightTitle:@"免费吃推荐"];
    
    [self.scrollView addSubview:foodPicturesHeadView];
    
    //创建一个layout布局类
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(220,150);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,self.opctionview.frame.origin.y + 226,ScreenWidth, 150) collectionViewLayout:flowLayout];
     //隐藏水平滚动条
    collectionView.showsHorizontalScrollIndicator = NO;
    //取消弹簧效果
    collectionView.bounces = NO;
    //代理设置
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //注册item类型
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DeliciousFoodCell class]) bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"foodCell"];
    
    [self.scrollView addSubview:collectionView];

    
}
#pragma mark 加载品牌推荐方法
-(void)brandRecommendation
{
    CurrencyView *headBrandView = [CurrencyView currencyViewWithYvalue:self.opctionview.frame.origin.y + 376 RightTitle:@"品牌推荐"];
    [self.scrollView addSubview:headBrandView];
    
    self.brandView = [[UIView alloc] initWithFrame:CGRectMake(0,self.opctionview.frame.origin.y + 396, ScreenWidth, 180)];
    [self arraysList];
    //控制总列数
    int totalColumns = 4;
    CGFloat Y = 0;
    CGFloat W = 80;
    CGFloat H = 70;
    CGFloat X = (self.view.frame.size.width - totalColumns * W) / (totalColumns + 1);
    
    for (int index = 0; index < _appList.count; index++) {
        
        OptionModel *model = _appList[index];
        int row = index / totalColumns;
        int col = index % totalColumns;
        CGFloat viewX = X + col * (W + X);
        CGFloat viewY = 20 + row * (H + Y);
        BrandView *view = [[BrandView alloc] initWithFrame:CGRectMake(viewX, viewY, W, H) Model:model];
        [self.brandView addSubview:view];
        
    }
    [self.scrollView addSubview:self.brandView];
    
}

#pragma mark 加载居家生活
-(void)familyLife
{
    CurrencyView *familyView = [CurrencyView currencyViewWithYvalue:self.opctionview.frame.origin.y + 546 RightTitle:@"居家生活"];
    [self.scrollView addSubview:familyView];
    
    
}


#pragma mark collection DataSource 方法
//返回item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //返回图片数组的长度
    return 9;
    
}

//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    DeliciousFoodCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"foodCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = collectionView.frame;
    
    [collectionView addSubview:imageView];
    //3. 设置数据
    cell.foodImageName = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"第%ld个被点击了",indexPath.row);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
