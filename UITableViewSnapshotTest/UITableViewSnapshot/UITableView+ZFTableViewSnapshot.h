//
//  UITableView+ZFTableViewSnapshot.h
//  TableViewShotsTest
//
//  Created by a9188 on 15/12/24.
//  Copyright © 2015年 com.9188. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+ZFImageFromArrayUtils.h"

@interface UITableView (ZFTableViewSnapshot)

/**
 *  最后截图快照
 */
- (UIImage *)zf_tableViewSnapshot;

@end
