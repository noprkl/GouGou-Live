//
//  SuggestViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SuggestViewController.h"
#import "SuggestButtonView.h"

#import "ExperienceProblem.h"

#import "MerhantComplaint.h"

#import "AddUpdataImagesView.h"
#import "NSString+CertificateImage.h"

#define ImgCount 1

@interface SuggestViewController ()
/** 顶部按钮 */
@property (strong,nonatomic) SuggestButtonView *topButtonView;
/** 问题 */
@property (strong,nonatomic) ExperienceProblem *experienceView;
/** 投诉 */
@property (strong,nonatomic) MerhantComplaint *complaint;
/** 选中的按钮 */
@property (strong,nonatomic) UIButton *selectedButton;


@end

@implementation SuggestViewController
#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
    [self makeConstraints];
}

- (void)initUI {
    [self.view addSubview:self.topButtonView];
    [self.view addSubview:self.experienceView];
    [self.view addSubview:self.complaint];
}

- (void)makeConstraints {
    
    [_topButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(44);
    }];
    [_experienceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButtonView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo(SCREEN_HEIGHT-64 - 44);
    }];
    [_complaint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButtonView.bottom);
        make.left.equalTo(self.view.right);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-64 - 44));
    }];
}
#pragma mark - 懒加载
- (SuggestButtonView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[SuggestButtonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) title:@[@"体验问题",@"商品、商家投诉"]];
        _topButtonView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        __weak typeof(self) weakSelf = self;
        _topButtonView.difFuncBlock = ^(UIButton * button) {
            weakSelf.selectedButton = button;
            if (button.tag == 500) {
                if (button.selected) {
                    button.enabled = YES;
                    [weakSelf changeTableFrame:button];
                }
            } else if (button.tag == 501) {
                if (button.selected) {
                    button.enabled = YES;
                    [weakSelf changeTableFrame:button];
                }
            }
        };
    }
    return _topButtonView;
}

- (ExperienceProblem *)experienceView {
    if (!_experienceView) {
        _experienceView = [[ExperienceProblem alloc] init];
        _experienceView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
         __weak typeof(self) weakSelf = self;
       __block NSInteger type = 0;
        _experienceView.problemBlock = ^(NSString *problem){
            if ([problem isEqualToString:@"功能问题"]) {
                type = 1;
            }
            if ([problem isEqualToString:@"购买遇到问题"]) {
                type = 2;
            }
            if ([problem isEqualToString:@"性能问题"]) {
                type = 3;
            }
            if ([problem isEqualToString:@"其他"]) {
                type = 4;
            }
        };
         __block CGFloat W = 0;
         if (ImgCount <= kMaxImgCount) {
             W = (SCREEN_WIDTH - (ImgCount + 1) * 10) / 2;
         }else{
             W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / 2;
         }

         AddUpdataImagesView *addImag = [[AddUpdataImagesView alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH - 20, W + 20)];
        
        addImag.layer.cornerRadius = 5;
        addImag.layer.masksToBounds = YES;
        addImag.maxCount = ImgCount;
        __weak typeof(addImag) weakAdd = addImag;

         addImag.addBlock = ^(){
         
         TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
         imagePickerVc.sortAscendingByModificationDate = NO;
         
         [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
         [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
             if (flag) {
                 [weakAdd.dataArr addObject:photos[0]];
                 
                 [weakAdd.collectionView reloadData];
                 CGFloat row = weakAdd.dataArr.count / kMaxImgCount;
                 CGRect rect = weakAdd.frame;
                 rect.size.height = (row + 1) * (W + 10) + 10;
                 weakAdd.frame = rect;
             }else{
                 DLog(@"出错了");
             }
         }];
         };
         [_experienceView addSubview:addImag];
        
        _experienceView.handinBlock = ^(UIButton * button) {
            
            NSString *textStr = weakSelf.experienceView.textViewText;
            if (type == 0) {
                [weakSelf showAlert:@"请选择反馈问题"];
            }else{
                if (textStr.length == 0) {
                    [weakSelf showAlert:@"问题描述不能为空"];
                } else {
                    if (addImag.dataArr.count != 0) { //有图
                        NSString *base64 = [NSString imageBase64WithDataURL:addImag.dataArr[0] withSize:CGSizeMake(SCREEN_WIDTH / 2, SCREEN_WIDTH / 2)];
                        NSDictionary *dict = @{
                                               @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                               @"img":base64
                                               };
                        [weakSelf postRequestWithPath:API_UploadImg params:dict success:^(id successJson) {
                            if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                                NSString *str = successJson[@"data"];
                                NSDictionary *dict2 = @{
                                                        @"type":@(type),
                                                        @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                                        @"conent":textStr,
                                                        @"img":str
                                                        };
                                [weakSelf postRequestWithPath:API_Add_system_msg params:dict2 success:^(id successJson) {
                                    DLog(@"%@", successJson);
                                    [self showAlert:successJson[@"message"]];
                                } error:^(NSError *error) {
                                    DLog(@"%@", error);
                                }];
                                DLog(@"%@", str);
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    } else {  // 无图
                        NSDictionary *dict2 = @{
                                                @"type":@(type),
                                                @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                                @"conent":textStr
                                                };
                        [weakSelf postRequestWithPath:API_Add_system_msg params:dict2 success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }
                }
            }
        };
    }
    return _experienceView;
}

- (void)clickHandinButtonWithPhoto {
    
   
}
- (void)clickHandinButtonWithNonePhoto {
    
    
}
- (MerhantComplaint *)complaint {
    
    if (!_complaint) {
        _complaint = [[MerhantComplaint alloc] init];
        _complaint.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _complaint;
}
// 改变View的frame
- (void)changeTableFrame:(UIButton *)button {
    if (button.tag == 500) {
        button.selected = YES;
        self.selectedButton.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
           
            CGRect tableRect1 = self.experienceView.frame;
            tableRect1.origin.x = 0;
            self.experienceView.frame = tableRect1;

            CGRect tableRect2 = self.complaint.frame;
            tableRect2.origin.x = SCREEN_WIDTH;
            self.complaint.frame = tableRect2;
        }];
        
    }else if (button.tag == 501){
        button.selected = YES;
        self.selectedButton.selected = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tableRect1 = self.complaint.frame;
            tableRect1.origin.x = 0;
            self.complaint.frame = tableRect1;
            
            CGRect tableRect2 = self.experienceView.frame;
            tableRect2.origin.x = -SCREEN_WIDTH;
            self.experienceView.frame = tableRect2;
            
        }];
    }
    
}
- (void)test {
    
    
}
@end
