//
//  UITableView+ZFTableViewSnapshot.m
//  TableViewShotsTest
//
//  Created by a9188 on 15/12/24.
//  Copyright © 2015年 com.9188. All rights reserved.
//

#import "UITableView+ZFTableViewSnapshot.h"

@implementation UITableView (ZFTableViewSnapshot)

/**
 *  最后截图快照
 */
- (UIImage *)zf_tableViewSnapshot {
    NSMutableArray *screenshots = [NSMutableArray array];
    //表头快照
    UIImage *headerScreenshot = [self screenshotOfHeaderView];
    
    if (headerScreenshot) [screenshots addObject:headerScreenshot];
    
    for (int section=0; section<self.numberOfSections; section++) {
        //区头快照
        UIImage *headerScreenshot = [self screenshotOfHeaderViewAtSection:section];
        if (headerScreenshot) [screenshots addObject:headerScreenshot];
        
        //cell
        for (int row=0; row<[self numberOfRowsInSection:section]; row++) {
            NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:row inSection:section];
            UIImage *cellScreenshot = [self screenshotOfCellAtIndexPath:cellIndexPath];
            if (cellScreenshot) [screenshots addObject:cellScreenshot];
        }
        
        //区尾
        UIImage *footerScreenshot = [self screenshotOfFooterViewAtSection:section];
        if (footerScreenshot) [screenshots addObject:footerScreenshot];
    }
    //表尾
    UIImage *footerScreenshot = [self screenshotOfFooterView];
    if (footerScreenshot) [screenshots addObject:footerScreenshot];
    
    return [UIImage verticalImageFromArray:screenshots];
}

/**
 *  截取表头
 */
-(UIImage *)screenshotOfHeaderView {
	self.contentOffset = CGPointZero;
    return [self screenShotWithShotView:self.tableHeaderView];
}

/**
 *  截取表尾
 */
-(UIImage *)screenshotOfFooterView {
    return [self screenShotWithShotView:self.tableFooterView];
}

/**
 *  截取区头
 */
-(UIImage *)screenshotOfHeaderViewAtSection:(NSInteger)section {
    return [self screenShotWithShotView:[self headerViewForSection:section]];
}

/**
 *  截取区尾
 */
-(UIImage *)screenshotOfFooterViewAtSection:(NSInteger)section {
    return [self screenShotWithShotView:[self footerViewForSection:section]];
}

/**
 *  截取cell
 */
-(UIImage *)screenshotOfCellAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    [self beginUpdates];
    [self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self endUpdates];
    
    return [self screenShotWithShotView:cell];
}

/**
 *  截图
 *
 *  @param shotView 需截图view
 */
-(UIImage *)screenShotWithShotView:(UIView *)shotView {
    UIGraphicsBeginImageContextWithOptions(shotView.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [shotView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
