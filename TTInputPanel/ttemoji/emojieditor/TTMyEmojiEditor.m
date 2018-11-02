//
//  TTMyEmojiEditor.m
//  TT
//
//  Created by simp on 2018/10/20.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTMyEmojiEditor.h"
#import <Masonry/Masonry.h>
#import "TTMyEmojiEditorCell.h"


#import "TTInputCustomPage.h"
#import "TTCustomEmojiPackage.h"
#import "TTInputMyEmojiEditCell.h"
#import "TTInputMyEmojiEditItem.h"
#import "TTInputCusEditItem.h"
#import "UIColor+TTColor_Generated.h"
#import "TTMyEmojiEditorToolBar.h"
#import "UIColor+Extension.h"
#import "TTInputMyEmojiAddCell.h"

@interface TTMyEmojiEditor ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TTMyEmojiEditorToolBarProtocol,TTMyEmojiEditorCellProtocol,TTCustomEmojiPackageProtocol>

@property (nonatomic, strong) UICollectionView * collection;

@property (nonatomic, strong) NSArray * emojis;

@property (nonatomic, strong) TTCustomEmojiPackage * customPackage;

@property (nonatomic, strong) NSMutableDictionary * emojisItems;

@property (nonatomic, assign) BOOL isEditorMode;

@property (nonatomic, strong) TTMyEmojiEditorToolBar * bar;

@property (nonatomic, strong) NSMutableArray * selectedArray;

@property (nonatomic, strong) NSMutableArray * unselectedArray;

/**全选按钮被选中*/
@property (nonatomic, assign) BOOL deleteAll;

@property (nonatomic, strong) UIColor * navigationTint;

@property (nonatomic, strong) UIButton * rightNavButton;

@end

@implementation TTMyEmojiEditor

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialData];
    [self initialUI];
}

- (void)setCustomPackage:(TTCustomEmojiPackage *)customPackage {
    _customPackage = customPackage;
    customPackage.delegate = self;
}

- (void)initialData {
    

    self.navigationTint = self.navigationController.navigationBar.tintColor;
   
    __weak typeof(self)wself = self;
//    [GET_SERVICE(EmojiService) getCustomEmojiPackageList:^(NSArray<TTCustomEmojiPackage *> *list) {
//        for (TTCustomEmojiPackage *packge in list) {
//            if ([packge isMyEmoji]) {
//                wself.customPackage = packge;
//            }
//        }
//        [wself.collection reloadData];
//    }];
    
//    self.emojisItems = [NSMutableDictionary dictionary];
//    
//    NSMutableArray * array = [NSMutableArray array];
//    TTInputMyEmojiEditItem *editItem = [[TTInputMyEmojiEditItem alloc] init];
//    editItem.name = @"添加";
//    editItem.itemImg = [UIImage imageNamed:@"ic_emoji_add"];
//    [array addObject:editItem];
//    
//    [self.emojisItems setObject:editItem forKey:@(0)];
}

- (void)initialUI {
    [self initialNavigation];
    [self initialCollection];
    [self initialBar];
}

- (void)initialBar {
    self.bar = [[TTMyEmojiEditorToolBar alloc] init];
    [self.bar addToView:self.view];
    self.bar.delegate  = self;
}

- (void)initialNavigation {

    [self refreshTitle];
    
    UIButton * rightButton = [[UIButton alloc] init];
    [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    UIBarButtonItem *rightcust = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.rightNavButton = rightButton;
    [rightButton addTarget:self action:@selector(toEditorMode) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:[UIColor TTGray2] forState:UIControlStateNormal];
    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toEditorMode)];
    self.navigationItem.rightBarButtonItem = rightcust;
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navbar_icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(toBack)]; 
    self.navigationItem.leftBarButtonItem = left;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.tintColor = [UIColor TTGray2];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)refreshTitle {
    self.title = [NSString stringWithFormat:@"我的表情（%u）",self.customPackage.totalCount];
}

- (void)toBack {
    if (self.rereshBlock) {
        self.rereshBlock();
    }
    self.navigationController.navigationController.navigationBar.tintColor = self.navigationTint;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)toEditorMode {
    self.isEditorMode = !self.isEditorMode;
    
}

- (void)setIsEditorMode:(BOOL)isEditorMode{
    _isEditorMode = isEditorMode;
    if (isEditorMode) {
        self.selectedArray = [NSMutableArray array];
        self.unselectedArray = [NSMutableArray array];
        [self.rightNavButton setTitle:@"取消" forState:UIControlStateNormal];
//        [self.navigationItem.rightBarButtonItem setTitle:@"取消"];
        [self.bar show];
    }else {
        self.selectedArray = nil;
        self.unselectedArray = nil;
//        [self.navigationItem.rightBarButtonItem setTitle:@"编辑"];
        [self.rightNavButton setTitle:@"编辑" forState:UIControlStateNormal];
        self.deleteAll = NO;
        [self barToSelectAll:NO];
        [self.bar dissmiss];
    }
    [self.collection reloadData];
}

- (void)initialCollection {
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    self.collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
    [self.view addSubview:self.collection];
    
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[TTMyEmojiEditorCell class] forCellWithReuseIdentifier:@"1"];
    [self.collection registerClass:[TTInputMyEmojiAddCell class] forCellWithReuseIdentifier:@"2"];
    self.collection.backgroundColor = [UIColor TTWhite1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collection

- (TTInputSourceItem *)itemAtIndex:(NSInteger)index {
    TTInputSourceItem *item = [self.emojisItems objectForKey:@(index)];
    
    if (!item) {
        if (index != 0) {
            TTInputCusEditItem *citem =  [[TTInputCusEditItem alloc] init];
            [self.emojisItems setObject:citem forKey:@(index)];
            citem.index = index-1;
            citem.package = self.customPackage;
            [citem loadConfig];
            if (self.deleteAll) {//如果全选按钮是选中的状态
                citem.selected = YES;
            }
            return citem;
        }
    }
    return item;
}

- (void)packageItem:(TTCustomEmoji *)emoji loadedAtIndex:(NSInteger)index {
    TTInputCusEditItem * item = [self.emojisItems objectForKey:@(index+1)];
    item.emoji = emoji;
    [item loadThumb];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTInputSourceItem * item  = [self itemAtIndex:indexPath.row];
    if (indexPath.row == 0) {
        TTInputMyEmojiAddCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"2" forIndexPath:indexPath];
        cell.item = item;
        cell.contentView.backgroundColor = [UIColor ARGB:0xF8F8F8];
        cell.contentView.layer.borderWidth = 0;
        cell.contentView.layer.cornerRadius = 0;
        return cell;
    }else {
        TTMyEmojiEditorCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"1" forIndexPath:indexPath];
        cell.delegate = self;
        TTInputCusEditItem *citem = item;
        [cell setItem:item];
        [citem loadThumb];
        [cell setItem:item];
        return cell;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1 + self.customPackage.totalCount;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.isEditorMode) {
            self.isEditorMode = NO;
        }
        [self toAddEmoji];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = CGRectGetWidth(self.view.bounds)-1;
    return CGSizeMake(width/4, width/4);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.001f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.001f;
}

#pragma mark 上传相关的逻辑

- (void)toAddEmoji {
//    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
//    actionSheet.configuration.maxSelectCount = 20;
//    actionSheet.sender = self;
//    if ([GET_SERVICE(LabService) proxyConfiguration] != Proxy_Test) {
//        actionSheet.configuration.maxSelectCount = 1;
//        actionSheet.configuration.allowEditImage = NO;
//    }
//
//    [actionSheet setSelectImageModelBlock:^(NSArray<ZLPhotoModel *> * _Nullable images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
//        for (ZLPhotoModel *model in images) {
//            if (model.finnalImage) {
//                UIImage *image =[ImageUtil generateIMThumbImage:model.finnalImage];
//                NSData *data = UIImageJPEGRepresentation(image, IM_IMAGE_COMPRESS_QUALITY);
//                [self uploadEmojiWithData:data];
//            }else if (model.finnalData) {
//                [self uploadEmojiWithData:model.finnalData];
//            }
//            if (model.finnalImage || model.finnalData) {
//
//            }
//        }
//    }];
    
//    [actionSheet showPhotoLibrary];
}

- (void)uploadEmojiWithData:(NSData *)data {
//    __weak typeof(self)wself = self;
//    SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:data];
//    NSString *max = @"2M";
//    NSInteger maxlen = 1024 * 2 * 1024;
//    if (imageFormat != SDImageFormatGIF) {
//        max = @"512KB";
//        maxlen = 1024 * 512;
//    }
//    if (data.length > maxlen) {
//        dispatch_async(dispatch_get_main_queue(), ^{//这里是为了 房间那个hind view 需要拿到key window
//            TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"所选的图片过大添加的图片应该小于%@",max]];
//            [alertView addButtonWithTitle:@"确定" block:nil];
//            [alertView show];
//        });
//        return;
//    }
//
//    [UIUtil showLoading];
//    [GET_SERVICE(EmojiService) saveCustomEmoji:SaveCustomEmojiModeEmojiToEmoji emojiId:nil message:nil imageData:data callback:^(TTCustomEmoji *emoji, NSError *error) {
//        [UIUtil dismissLoading];
//        if (error) {
//            [UIUtil showError:error];
//        }else {
//            [wself reloadpackage];
//            [wself refreshTitle];
//            [UIUtil showHint:@"已添加"];
//        }
//    }];
}

- (void)reloadpackage {
    __weak typeof(self)wself = self;
//    [GET_SERVICE(EmojiService) getCustomEmojiPackageList:^(NSArray<TTCustomEmojiPackage *> *list) {
//        for (TTCustomEmojiPackage *packge in list) {
////            if (self.rereshBlock) {
////                self.rereshBlock();
////            }
//            if ([packge isMyEmoji]) {
//                wself.customPackage = packge;
//                [wself.collection reloadData];
//            }
//        }
//    }];
    
}


#pragma mark - bar 的事件

- (void)barToSelectAll:(BOOL)select {
    self.deleteAll = select;
//    if (select) {
//        if (self.emojisItems.count != self.customPackage.totalCount+1) {//如果没有全部拉取 那么就全部拉
//            __weak typeof(self)wself = self;
//            [GET_SERVICE(EmojiService) getCustomEmojiList:self.customPackage.packageId index:0 count:self.customPackage.totalCount callback:^(NSArray<TTCustomEmoji *> *list) {
//                [UIUtil dismissLoading];
//                for (int i = 0; i < self.customPackage.totalCount; i ++) {
//                    [wself itemAtIndex:i + 1];
//                }
//                [wself.selectedArray removeAllObjects];
//                for (TTInputCusEditItem *item in [self.emojisItems allValues]) {
//                    if ([item isKindOfClass:[TTInputCusEditItem class]]) {
//                        item.selected = YES;
//                        [wself.selectedArray addObject:item];
//                    }
//                }
//                [wself.collection reloadData];
//            }];
//        }else {
//            [self.selectedArray removeAllObjects];
//            for (TTInputCusEditItem *item in [self.emojisItems allValues]) {
//                if ([item isKindOfClass:[TTInputCusEditItem class]]) {
//                    item.selected = YES;
//                    [self.selectedArray addObject:item];
//                }
//            }
//            [self.collection reloadData];
//        }
//
//    }else {
//        [self.selectedArray removeAllObjects];
//        for (TTInputCusEditItem *item in [self.emojisItems allValues]) {
//            if ([item isKindOfClass:[TTInputCusEditItem class]]) {
//                item.selected = NO;
//            }
//        }
//
//    }
    
//    [self.unselectedArray removeAllObjects];//这个时候需要清空所有的
//    [self itemSeletedStateChanged:nil];
//    [self.collection reloadData];
}


- (void)itemSeletedStateChanged:(TTInputCusEditItem *)item {
    
    if (item) {
        if (item.selected) {
            if ([self shoulRecordByCaculate]) {//全选的状态下需要记录哪些
                if ([self.unselectedArray containsObject:item]) {
                    [self.unselectedArray removeObject:item];
                }
            }
            if (![self.selectedArray containsObject:item]) {
                [self.selectedArray addObject:item];
            }
        }else {
            if ([self.selectedArray containsObject:item]) {
                [self.selectedArray removeObject:item];
            }
            if ([self shoulRecordByCaculate]) {
                if (![self.unselectedArray containsObject:item]) {
                    [self.unselectedArray addObject:item];
                }
            }
        }
    }
   
    
    if (self.customPackage.totalCount == self.emojisItems.count-1) {//如果所有表情都已经拉回来了
        if (self.selectedArray.count == self.customPackage.totalCount && self.selectedArray.count != 0) {
            self.bar.allselect = YES;
        }else {
            self.bar.allselect = NO;
        }
        [self.bar setDeleteCount:self.selectedArray.count];
    }else {//还有表情没拉回来
        if (self.deleteAll) {//如果处于全部删除的状态下
            if (self.selectedArray.count == self.emojisItems.count && self.selectedArray.count != 0) {
                self.bar.allselect = YES;
            }else {
                self.bar.allselect = NO;
            }
            [self.bar setDeleteCount:self.customPackage.totalCount - self.unselectedArray.count];
        }else {
            self.bar.allselect = NO;
            [self.bar setDeleteCount:self.selectedArray.count];
        }
    }
}

/**是否需要记录- 由于远端没有全部拉下来的关系*/
- (BOOL)shoulRecordByCaculate {
    return (self.customPackage.totalCount != self.emojisItems.count-1)&&self.deleteAll;
}

- (void)barToDelete {
    NSMutableArray *ides = [NSMutableArray array];
//    for (TTInputCusEditItem * item in self.selectedArray) {
//        if (item.emoji.emojiId.length != 0) {
//            [ides addObject:item.emoji.emojiId];
//        }
//    }
//    [UIUtil showLoading];
//    __weak typeof(self)wself = self;
//    [GET_SERVICE(EmojiService) deleteCustomEmoji:self.customPackage.packageId emojiIdList:ides callback:^(NSError *error) {
//        [UIUtil dismissLoading];
//
//        if (!error) {
//            [wself reload];
//            [UIUtil showHint:@"已删除"];
//        }else {
//             [UIUtil showError:error];
//        }
//        wself.isEditorMode  = NO;
//    }];
}

- (void)reload {
    __weak typeof(self)wself = self;
    NSObject *ob = [self.emojisItems objectForKey:@(0)];
    [self.emojisItems removeAllObjects];
//    [self.emojisItems setObject:ob forKey:@(0)];
//    [GET_SERVICE(EmojiService) getCustomEmojiPackageList:^(NSArray<TTCustomEmojiPackage *> *list) {//这里拉取不到数据
////        if (self.rereshBlock) {
////            self.rereshBlock();
////        }
//        for (TTCustomEmojiPackage *packge in list) {
//            if ([packge isMyEmoji]) {
//                wself.customPackage = packge;
//            }
//        }
//        [wself.collection reloadData];
//        [wself refreshTitle];
//    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
