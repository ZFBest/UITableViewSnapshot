//
//  UIImage+ZFImageFromArrayUtils.h
//  TableViewShotsTest
//
//  Created by a9188 on 15/12/24.
//  Copyright © 2015年 com.9188. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZFImageFromArrayUtils)

/**
 *  拼接图片
 *
 *  @param imagesArray 截图数组
 */
+ (UIImage *)verticalImageFromArray:(NSArray *)imagesArray;

/**
 *  获取全部图片拼接后size(高总和)
 *
 *  @param imagesArray 截图数组
 */
+ (CGSize)verticalAppendedTotalImageSizeFromImagesArray:(NSArray *)imagesArray;

@end
