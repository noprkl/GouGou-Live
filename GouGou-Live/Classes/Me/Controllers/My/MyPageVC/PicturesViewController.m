//
//  PicturesViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

// 列数
#define kCols 3

#import "PicturesViewController.h"
#import "PicturesCell.h"
#import "SellerGoodsBottomView.h"
#import "SellerGoodsBarBtnView.h"
#import "SellerDeleDDetailView.h"

@interface PicturesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView; /**< 表格 */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) NSMutableArray *selectData; /**< 选中数据 */

@property(nonatomic, assign) BOOL isSelect; /**< 是否选中 */
@property(nonatomic, assign) BOOL isHid; /**< 是否隐藏 */

@property(nonatomic, strong) SellerGoodsBottomView *bottomView; /**< 选中按钮 */

@property(nonatomic, strong) SellerGoodsBarBtnView *barBtnView; /**< 上边按钮 */
@property(nonatomic, strong) UIButton *allBtn; /**< 全选按钮 */

@end
static NSString *cellid = @"PicturesCell";

@implementation PicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI {
    
    self.title = @"相册管理";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.barBtnView];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.bottomView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    _isSelect = NO;
    _isHid = YES;
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.bottomView];
}
- (void)choseAddPicture:(UIButton *)btn {
    btn.selected = !btn.selected;
    //    self.selectbtn.hidden = btn.selected;
    
}

#pragma mark
#pragma mark - collectionView
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        [_dataArr addObject:@0];
        [_dataArr addObject:@1];
        [_dataArr addObject:@2];
        [_dataArr addObject:@3];
        [_dataArr addObject:@4];
    }
    return _dataArr;
}
//- (NSMutableArray *)selectBtns {
//    if (!_selectBtns) {
//        _selectBtns = [NSMutableArray array];
//    }
//    return _selectBtns;
//}
//- (NSMutableArray *)cells {
//    if (!_cells) {
//        _cells = [NSMutableArray array];
//    }
//    return _cells;
//}
- (NSMutableArray *)selectData {
    if (!_selectData) {
        _selectData = [NSMutableArray array];
    }
    return _selectData;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat W = (SCREEN_WIDTH - 40) / 3;
        flowlayout.itemSize = CGSizeMake(W, W);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"PicturesCell" bundle:nil] forCellWithReuseIdentifier:cellid];
    }
    return _collectionView;
}
// 编辑
- (SellerGoodsBarBtnView *)barBtnView {
    if (!_barBtnView) {
        _barBtnView = [[SellerGoodsBarBtnView alloc] init];
        _barBtnView.bounds = CGRectMake(0, 0, 100, 44);
        __weak typeof(self) weakSelf = self;
        _barBtnView.editBlock = ^(BOOL flag){
#pragma mark - 编辑
            // 清除所有选中数据
            [weakSelf.selectData removeAllObjects];
            
            // 设置按钮显示
            _isHid = !flag;
            [weakSelf.collectionView reloadData];
            
            // 编辑时不允许跳转 底部按钮不隐藏
            weakSelf.bottomView.hidden = !flag;
            // 当底部按钮隐藏时 全选按钮为非选中状态
            if (weakSelf.bottomView.hidden) {
                weakSelf.allBtn.selected = NO;
            }
        };
        _barBtnView.addBlock = ^(){
            // 添加相片
           
        };
    }
    return _barBtnView;
}
// 底部按钮
- (SellerGoodsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerGoodsBottomView alloc] init];
        _bottomView.hidden = YES;
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        __weak typeof(self) weakSelf = self;
        _bottomView.allSelectBlock = ^(UIButton *btn){
            btn.selected = !btn.selected;
            // 全选按钮选中
            _isSelect = btn.selected;
            
            // 如果全选 把数据全添加进去
            if (btn.selected) {
                [weakSelf.selectData addObjectsFromArray:weakSelf.dataArr];
                
            }else{ // 否则 把数据全清除
                [weakSelf.selectData removeAllObjects];
            }
            
            [weakSelf.collectionView reloadData];
            weakSelf.allBtn = btn;
        };
        
        // 删除选中数据
        _bottomView.deleteBlock = ^(){
            
            __block SellerDeleDDetailView *prommit = [[SellerDeleDDetailView alloc] init];
            NSInteger count = 0;
            if (weakSelf.allBtn.selected) {
                count = self.dataArr.count;
            }else{
                count = self.selectData.count;
            }
            prommit.message = [NSString stringWithFormat:@"你将删除%ld个宝贝", count];
            prommit.sureBlock = ^(UIButton *btn){
                
                [weakSelf.dataArr removeObjectsInArray:weakSelf.selectData];
                
                [weakSelf.collectionView reloadData];
                // 清空数据
                [weakSelf.selectData removeAllObjects];
                
                prommit = nil;
                [prommit dismiss];
            };
            [prommit show];
            
        };
    }
    return _bottomView;
}
#pragma mark
#pragma mark - 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PicturesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    cell.isHid = _isHid;
    cell.isAllSelect = _isSelect;//[self.selectData containsObject:@(indexPath.row)]
    cell.selectBlock = ^(){
        if ([self.selectData containsObject:@(indexPath.row)]) {
            //如果点击的cell在deleArr中，则从deleArr中删除
            [self.selectData removeObject:@(indexPath.row)];
        }else{
            //否则添加cell到
            [self.selectData addObject:@(indexPath.row)];
        }
        
    };
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)test {
    /*
     pod 'UMengUShare/UI'
     
     # 集成新浪微博
     pod 'UMengUShare/Social/Sina'
     
     # 集成微信
     pod 'UMengUShare/Social/WeChat'
     
     # 集成QQ
     pod 'UMengUShare/Social/QQ'
     //打开调试日志
     [[UMSocialManager defaultManager] openLog:YES];
     
     //设置友盟appkey
     [[UMSocialManager defaultManager] setUmSocialAppkey:@"57b432afe0f55a9832001a0a"];
     
     // 获取友盟social版本号
     //NSLog(@"UMeng social version: %@", [UMSocialGlobal umSocialSDKVersion]);
     
     //设置微信的appKey和appSecret
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
     
     
     //设置分享到QQ互联的appKey和appSecret
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"100424468"  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
     
     //设置新浪的appKey和appSecret
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
     
     //支付宝的appKey
     [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
     
     //设置易信的appKey
     [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
     
     //设置点点虫（原来往）的appKey和appSecret
     [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
     
     //设置领英的appKey和appSecret
     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
     */
//    58330b17717c194faf00069c
}
@end
