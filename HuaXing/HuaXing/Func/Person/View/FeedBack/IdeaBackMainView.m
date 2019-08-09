//
//  IdeaBackMainView.m
//  hinabian
//
//  Created by 何松泽 on 2017/9/18.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "IdeaBackMainView.h"
#import "IdeaBackSuccessView.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "LxGridViewFlowLayout.h"
#import <TZImagePickerController/TZImagePickerController.h>

#define ITEM_LEADING_GAP  (11.0* [UIAdapter Scale47Width])
#define LIMITED_PHOTO_NUM   4
#define kCloseViewHeight (53.0f* [UIAdapter Scale47Width])

@interface IdeaBackMainView() <UITextViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,TZImagePickerControllerDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
// 传图进度条
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UILabel *alertLabel;
// 用于滚动
@property (nonatomic, strong) UIScrollView *pagingView;
@property (nonatomic, strong) UILabel *photoLabel;
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, strong) UIView *completeView;
@property (nonatomic, strong) IdeaBackSuccessView *successView;
@property (nonatomic, weak) UIViewController *superController;
@property (nonatomic, strong) NSMutableArray *imageArry;
@property (nonatomic, assign) int photoNum;
// 已传图片的数量
@property (nonatomic, assign) int postedPhotoNum;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, strong) NSMutableArray *imageNameArr;
// 保存所有上传
@property (nonatomic, strong) NSMutableArray *allImageArr;
@property (nonatomic, strong) NSMutableArray *cellArr;
// 是否允许上传原图
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
// 是否上传了重复的照片
@property (nonatomic, assign) BOOL isRepeat;
// 是否正在上传图片
@property (nonatomic, assign) BOOL isUploading;
@property (nonatomic, assign) CGFloat itemWH;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, strong) LxGridViewFlowLayout *layout;

@end

@implementation IdeaBackMainView

- (instancetype)initWithFrame:(CGRect)frame superController:(UIViewController *)superController {
    self = [super initWithFrame:frame];
    if (self) {
        self.superController = superController;
        [self loadViewWithFame:frame];
    }
    return self;
}

- (void)loadViewWithFame:(CGRect)frame {
    self.pagingView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    self.pagingView.backgroundColor = [UIColor colorWithR:153.0 G:153.0 B:153.0 A:0.1f];
    self.pagingView.delegate = self;
    self.pagingView.pagingEnabled = true;
    self.pagingView.scrollEnabled = FALSE;
    self.pagingView.showsHorizontalScrollIndicator = false;
    self.pagingView.contentSize = CGSizeMake(CGRectGetWidth(frame) * 3,  CGRectGetHeight(frame));
    
    self.describeTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], 150.0 * [UIAdapter Scale47Width])];
    self.describeTextView.delegate = self;
    self.describeTextView.font = [UIAdapter font15];
    self.describeTextView.backgroundColor = [UIColor clearColor];
    self.describeTextView.returnKeyType = UIReturnKeyDone;
    
    self.placeHoldTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIAdapter deviceWidth], 150.0 * [UIAdapter Scale47Width])];
    self.placeHoldTextView.backgroundColor = [UIColor whiteColor];
    self.placeHoldTextView.textColor = [UIAdapter lightTintGray];
    self.placeHoldTextView.text = @" 请简要描述您要反馈的问题和意见";
    self.placeHoldTextView.font = [UIFont systemFontOfSize:13];
    
    self.photoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(self.placeHoldTextView.frame), [UIAdapter deviceWidth] , 38)];
    self.photoLabel.text = [NSString stringWithFormat:@"   问题截图（选填，最多%d张）",LIMITED_PHOTO_NUM];
    self.photoLabel.textColor = [UIColor blackColor];
    self.photoLabel.textAlignment = NSTextAlignmentLeft;
    self.photoLabel.font = [UIFont boldSystemFontOfSize:14.0];
    self.photoLabel.backgroundColor = [UIAdapter lineGray];
    
    CGRect statusFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rect = CGRectZero;
    /*完成*/
    rect.origin.x = 0;
    if ([UIAdapter device5_5Inch] || [UIAdapter device5_8Inch] || [UIAdapter device6_1Inch] || [UIAdapter device6_5Inch]) {
        rect.origin.y = [UIAdapter deviceHeight] - statusFrame.size.height - [UIAdapter normalNavBarHeight] - kCloseViewHeight - [UIAdapter suitHeightForX_Device];
    } else {
        rect.origin.y = [UIAdapter deviceHeight] - statusFrame.size.height - [UIAdapter normalNavBarHeight] - kCloseViewHeight;
    }
    rect.size.width = [UIAdapter deviceWidth];
    rect.size.height = kCloseViewHeight;
    self.completeView = [[UIView alloc]initWithFrame:rect];
    self.completeView.backgroundColor = [UIColor whiteColor];
    self.completeView.layer.borderColor = [UIAdapter lineGray].CGColor;
    self.completeView.layer.borderWidth = 0.5f;
    
    rect.origin.x = ITEM_LEADING_GAP;
    rect.origin.y = 7.0 * [UIAdapter Scale47Width];
    rect.size.width = [UIAdapter deviceWidth] - ITEM_LEADING_GAP * 2;
    rect.size.height = kCloseViewHeight - rect.origin.y * 2;
    self.completeBtn = [[UIButton alloc]initWithFrame:rect];
    [self.completeBtn setTitle:@"提交反馈" forState:UIControlStateNormal];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    self.completeBtn.titleLabel.textColor = [UIColor whiteColor];
    self.completeBtn.layer.cornerRadius = 4.0;
    self.completeBtn.enabled = FALSE;
    self.completeBtn.backgroundColor = [UIAdapter mainBlueWithAlpha:0.6f];
    self.completeBtn.layer.borderColor = [UIAdapter mainBlueWithAlpha:0.6f].CGColor;
    [self.completeBtn addTarget:self action:@selector(completeEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.completeView addSubview:self.completeBtn];
    [self addSubview:self.pagingView];
    [self.pagingView addSubview:self.placeHoldTextView];
    [self.pagingView addSubview:self.describeTextView];
    [self.pagingView addSubview:self.photoLabel];
    [self.pagingView addSubview:self.completeView];
    [self configCollectionView];
}

//WX版图片选择器
- (void)configCollectionView {
    self.layout = [[LxGridViewFlowLayout alloc] init];
    self.margin = 4;
    self.itemWH = (self.frame.size.width - 2 * self.margin - 4) / 4 - self.margin;
    self.layout.itemSize = CGSizeMake(self.itemWH, self.itemWH);
    self.layout.minimumInteritemSpacing = self.margin;
    self.layout.minimumLineSpacing = self.margin;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.photoLabel.frame), self.frame.size.width, self.layout.itemSize.height + 20) collectionViewLayout:self.layout];
    self.collectionView.alwaysBounceHorizontal = NO;
    self.collectionView.alwaysBounceVertical = NO;
    
    CGFloat rgb = 255 / 255.0;
    self.collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    self.collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    /*AlertLabel提醒剩余照片数量标签*/
    self.alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.collectionView.frame), [UIAdapter deviceWidth], 30)];
    self.alertLabel.backgroundColor = [UIColor whiteColor];
    self.alertLabel.textAlignment = NSTextAlignmentCenter;
    self.alertLabel.textColor = [UIAdapter lightTintGray];
    self.alertLabel.text = [NSString stringWithFormat:@"已选择0张,还可添加%d张",LIMITED_PHOTO_NUM];
    self.alertLabel.font = [UIFont systemFontOfSize:16.0f];
    
    /*进度条*/
    self.progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.alertLabel.frame), [UIAdapter deviceWidth], 5)];
    self.progressView.tintColor = [UIAdapter mainBlue];
    self.progressView.progress = 0.f;
    self.progressView.hidden = YES;
    
    [self.pagingView addSubview:self.collectionView];
    [self.pagingView addSubview:self.alertLabel];
    [self.pagingView addSubview:self.progressView];
}

//给UILabel设置行间距和字间距
-(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font withLineSpacing:(float)lineSpacing {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentCenter;
    paraStyle.lineSpacing = lineSpacing; //设置行间距
    //设置字间距 NSKernAttributeName:@1.f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.selectedPhotos.count >= LIMITED_PHOTO_NUM) {
        return self.selectedPhotos.count;
    }
    return self.selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == self.selectedPhotos.count) {
        cell.layer.borderWidth = 1.0f;
        cell.layer.borderColor = [UIAdapter lineGray].CGColor;
        cell.clipsToBounds = NO;
        cell.imageView.image = [UIImage imageNamed:@"feedback_add_image"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.layer.borderWidth = 1.f;
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.clipsToBounds = YES;
        cell.imageView.image = self.selectedPhotos[indexPath.row];
        cell.asset = self.selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isUploading) {
        [[HXToast shareManager] toastWithOnView:nil msg:@"正在上传图片，请稍后操作" afterDelay:0.5 style:HXToastHudFailure];
        return;
    }
    if (indexPath.row == self.selectedPhotos.count) {
        //直接进入相册再选择拍照
        [self pushImagePickerController];
    } else {
        // 预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:self.selectedAssets selectedPhotos:self.selectedPhotos index:indexPath.row];
        imagePickerVc.allowPickingOriginalPhoto = NO;
        imagePickerVc.isSelectOriginalPhoto = self.isSelectOriginalPhoto;
        __weak typeof(self) weakSelf = self;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            NSMutableArray *tempAssets = [NSMutableArray arrayWithArray:weakSelf.selectedAssets];
            [tempAssets removeObjectsInArray:assets];
            for (id tmpImageAsset in tempAssets) {
                NSString *filename;
                if ([tmpImageAsset isKindOfClass:[PHAsset class]]) {
                    filename = [tmpImageAsset valueForKey:@"filename"];
                }
                NSMutableArray *tempName = [NSMutableArray arrayWithArray:weakSelf.imageNameArr];
                for (int i = 0; i < tempName.count; i++) {
                    if ([filename isEqualToString:tempName[i]]) {
                        weakSelf.postedPhotoNum --;  //除去删除的照片
                        [weakSelf.imageNameArr removeObjectAtIndex:i];
                        [weakSelf.imageArry removeObjectAtIndex:i];
                        break;
                    }
                }
            }
            weakSelf.selectedPhotos = [NSMutableArray arrayWithArray:photos];
            weakSelf.selectedAssets = [NSMutableArray arrayWithArray:assets];
            weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
            weakSelf.layout.itemCount = weakSelf.selectedAssets.count;
            [weakSelf.collectionView reloadData];
            [weakSelf changeLabelPhotoNum];
        }];
        [self.superController presentViewController:imagePickerVc animated:YES completion:nil];
    }
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.item >= self.selectedPhotos.count || destinationIndexPath.item >= self.selectedPhotos.count) return;
    UIImage *image = self.selectedPhotos[sourceIndexPath.item];
    if (image) {
        [self.selectedPhotos exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [self.selectedAssets exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
        [self.collectionView reloadData];
        [self changeLabelPhotoNum];
    }
}

- (void)saveImage:(UIImage *)image Name:(NSString*) imageName asset:(id)asset photo:(id)photo {
    UIImage *selfPhoto = image;//读取图片文件
    if (self.allImageArr.count != 0) {
        for (int i = 0 ; i < self.allImageArr.count ; i++) {
            if ([[self.allImageArr[i]valueForKey:@"name"] isEqualToString:imageName]) {
                [self.imageArry addObject:[self.allImageArr[i]valueForKey:@"url"]];
                [self.imageNameArr addObject:[self.allImageArr[i]valueForKey:@"name"]];
                self.isRepeat = YES;
                break;
            }
        }
        if (self.isRepeat) {
            [self changePostProgress];
            self.isRepeat = NO;
        } else {
            [self uploadImage:selfPhoto name:imageName];
        }
    } else {
        [self uploadImage:selfPhoto name:imageName];
    }
}

- (void)uploadImage:(UIImage *)img name:(NSString *)imageName {

    self.isUploading = YES;
//    __weak typeof(self) weakSelf = self;
//    [DataFetcher updatePostImage:selfPhoto WithSucceedHandler:^(id JSON) {
//        int errCode = [[JSON valueForKey:@"state"] intValue];
//        if (errCode == 0) {
//            id json1 = [JSON valueForKey:@"data"];
//            NSString * tmpString = [json1 valueForKey:@"real_url"];
//            [self.imageArry addObject:tmpString];
//            [weakSelf.imageNameArr addObject:imageName];
//            [weakSelf.allImageArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:imageName,@"name",tmpString,@"url", nil]];
//            [weakSelf changePostProgress];
//        } else {
//            [weakSelf postImageFailWithAsset:asset photo:photo];
//        }
//    } withFailHandler:^(NSError *error) {
//        [weakSelf postImageFailWithAsset:asset photo:photo];
//    }];
    [self moniUploadImage];
}

-(void)postImageFailWithAsset:(id)asset photo:(id)photo {
    [self.selectedAssets removeObject:asset];
    [self.selectedPhotos removeObject:photo];
    self.layout.itemCount = self.selectedAssets.count;
    [self.collectionView reloadData];
    if (self.postedPhotoNum == self.selectedPhotos.count) {
        self.isUploading = NO;
        self.progressView.hidden = YES;
        [self changeLabelPhotoNum];
    }
}

-(void)changePostProgress {
    self.postedPhotoNum ++;
    if (self.postedPhotoNum == self.selectedPhotos.count) {
        self.isUploading = NO;
        self.progressView.hidden = YES;
        [self changeLabelPhotoNum];
    } else {
        self.progressView.hidden = NO;
        float progressValue = (float)self.postedPhotoNum/(float)self.selectedPhotos.count;
        [self.progressView setProgress:progressValue];
        self.alertLabel.text = [NSString stringWithFormat:@"已上传%lu/%lu",(unsigned long)self.postedPhotoNum,(unsigned long)self.selectedPhotos.count];
    }
}

//更改提醒Label中已选择的照片数目
-(void)changeLabelPhotoNum {
    self.alertLabel.text = [NSString stringWithFormat:@"已选择%lu张,还可添加%lu张",(unsigned long)self.selectedPhotos.count,LIMITED_PHOTO_NUM -self.selectedPhotos.count];
}

#pragma mark -- HNBImagePickerController
- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 delegate:self];
    // 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = self.isSelectOriginalPhoto;
    // 如果需要将拍照按钮放在外面，不要传这个参数
    imagePickerVc.selectedAssets = self.selectedAssets; // optional, 可选的
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    // 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    // 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    __weak typeof(self) weakSelf = self;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        weakSelf.selectedAssets = [NSMutableArray arrayWithArray:assets];
    }];
    [self.superController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    self.selectedPhotos = [NSMutableArray arrayWithArray:photos];
    self.selectedAssets = [NSMutableArray arrayWithArray:assets];
    self.isSelectOriginalPhoto = isSelectOriginalPhoto;
    self.layout.itemCount = self.selectedPhotos.count;
    
    //保存图片至服务器
    self.imageArry = [NSMutableArray array];
    self.imageNameArr = [NSMutableArray array];
    self.postedPhotoNum = 0;
    self.progressView.hidden = NO;
    float progressValue = (float)self.postedPhotoNum/(float)self.selectedPhotos.count;
    [self.progressView setProgress:progressValue];
    self.alertLabel.text = [NSString stringWithFormat:@"已上传%lu/%lu",(unsigned long)self.postedPhotoNum,(unsigned long)self.selectedPhotos.count];
    for (int i = 0;i<assets.count; i++) {
        id tmpImageAsset = assets[i];
        id tmpImagePhoto = photos[i];
        NSString* filename;
        PHAsset *phAsset;
        if ([tmpImageAsset isKindOfClass:[PHAsset class]]){
            phAsset = tmpImageAsset;
            filename =[phAsset valueForKey:@"filename"];
            PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.synchronous = YES;
            __weak typeof(self) weakSelf = self;
            [[PHImageManager defaultManager] requestImageDataForAsset: phAsset options: options resultHandler: ^(NSData * imageData, NSString * dataUTI, UIImageOrientation orientation, NSDictionary * info) {
                [weakSelf saveImage:[UIImage imageWithData:imageData] Name:filename asset:tmpImageAsset photo:tmpImagePhoto];
            }];
        }
    }
    [self.collectionView reloadData];
}

#pragma mark ------ click event

- (void)completeEvent {
    [self endEditing:TRUE];
    if (self.isUploading) {
        [[HXToast shareManager] toastWithOnView:nil msg:@"正在上传图片，请稍后操作" afterDelay:0.5 style:HXToastHudFailure];
        return;
    }
    
//    HXWeakSelf
//    [DataFetcher doIdeaBackWithContent:self.describeTextView.text ImageList:self.imageArry withSucceedHandler:^(id JSON) {
//        int errCode = [[JSON valueForKey:@"state"] intValue];
//        if (errCode == 0) {
//            //清空描述的全部内容，否则成功后点击返回会弹框
//            weakSelf.describeTextView.text = @"";
//            [weakSelf nextOperation];
//        }
//    } withFailHandler:nil];
    // 模拟提交过程
    [self moniUploadData];
    
}

//点击删除按钮
- (void)deleteBtnClik:(UIButton *)sender {
    if (self.isUploading) {
        //正在传图，不可删除
        [[HXToast shareManager] toastWithOnView:nil msg:@"正在上传图片，请稍后操作" afterDelay:1.0 style:HXToastHudFailure];
        return;
    }else{
        self.postedPhotoNum --;
        self.layout.itemCount = self.selectedAssets.count;
        int tag = 0;
        id tmpImageAsset = self.selectedAssets[sender.tag];
        PHAsset *phAsset;
        if ([tmpImageAsset isKindOfClass:[PHAsset class]]){
            phAsset = tmpImageAsset;
            if (phAsset.mediaType == PHAssetMediaTypeImage) {
                for (int i = 0; i < self.imageNameArr.count; i++) {
                    if ([[phAsset valueForKey:@"filename"] isEqualToString:self.imageNameArr[i]]) {
                        tag = i;
                        break;
                    }
                }
            }
        }
        [self.selectedPhotos removeObjectAtIndex:sender.tag];
        [self.selectedAssets removeObjectAtIndex:sender.tag];
        [self.imageNameArr removeObjectAtIndex:tag];
        [self.imageArry removeObjectAtIndex:tag];
        [self.collectionView reloadData];
        [self changeLabelPhotoNum];
    }
}

/*滚动到反馈成功页*/
- (void)nextOperation {
    self.pagingView.backgroundColor = [UIColor whiteColor];
    self.successView = [[IdeaBackSuccessView alloc]initWithFrame:CGRectMake([UIAdapter deviceWidth], 0, [UIAdapter deviceWidth], [UIAdapter deviceHeight]) superController:self.superController];
    [self.pagingView addSubview:self.successView];
    [self.pagingView endEditing:YES];
    CGPoint pt = self.pagingView.contentOffset;
    if (pt.x == [UIAdapter deviceWidth] * 2) {
        [self.pagingView setContentOffset:CGPointMake(0, 0)];
        [self.pagingView scrollRectToVisible:CGRectMake(0,0,[UIAdapter deviceWidth],[UIAdapter deviceHeight]) animated:YES];
    } else {
        pt.x += [UIAdapter deviceWidth];
        [self.pagingView setContentOffset:pt animated:YES];
    }
}

#pragma mark ------ TextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView == self.describeTextView) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }else {
            if (![text isEqualToString:@""]) {
                [self.placeHoldTextView setHidden:YES];
                self.describeTextView.backgroundColor = [UIColor whiteColor];
            }
            if ([text isEqualToString:@""] && range.length==1 && range.location==0) {
                [self.placeHoldTextView setHidden:NO];
                self.describeTextView.backgroundColor = [UIColor clearColor];
            }
            if (1 == range.length) {//按下回格键
                return YES;
            }
            if ([textView.text length] < 500) {//判断字符个数
                return YES;
            }
        }
    }
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.describeTextView.text.length > 0) {
        self.completeBtn.enabled = TRUE;
        self.completeBtn.backgroundColor = [UIAdapter mainBlueWithAlpha:1.0];
        self.completeBtn.layer.borderColor = [UIAdapter mainBlueWithAlpha:1.0].CGColor;
    } else {
        self.completeBtn.enabled = FALSE;
        self.completeBtn.backgroundColor = [UIAdapter mainBlueWithAlpha:0.6f];
        self.completeBtn.layer.borderColor = [UIAdapter mainBlueWithAlpha:0.6f].CGColor;
    }
}



#pragma mark --- 模拟网络过程

- (void)moniUploadData {
    HXWeakSelf
    [[HXToast shareManager] toastWithOnView:nil msg:@"正在提交" afterDelay:0.f style:HXToastHudWaiting];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HXToast shareManager] dismiss];
        //清空描述的全部内容，否则成功后点击返回会弹框
        weakSelf.describeTextView.text = @"";
        [weakSelf nextOperation];
    });
}

- (void)moniUploadImage {
    HXWeakSelf
    [[HXToast shareManager] toastWithOnView:nil msg:@"正在提交" afterDelay:0.f style:HXToastHudWaiting];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HXToast shareManager] dismiss];
        NSString *real_img_url = @"";
        [weakSelf.imageArry addObject:real_img_url];
        [weakSelf.imageNameArr addObject:@"imageName"];
        [weakSelf.allImageArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"imageName",@"name",real_img_url,@"url", nil]];
        [weakSelf changePostProgress];
    });
}

@end
