//
//  ViewController.m
//  UITableViewSnapshotTest
//
//  Created by a9188 on 16/2/2.
//  Copyright © 2016年 com.9188. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+ZFTableViewSnapshot.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    
    UILabel * tableHeaderView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    tableHeaderView.text = @"TableHeaderView";
    tableHeaderView.contentMode = UIViewContentModeCenter;
    tableHeaderView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = tableHeaderView;
    
    UILabel * tableFooterView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    tableFooterView.text = @"TableFooterView";
    tableFooterView.contentMode = UIViewContentModeCenter;
    tableFooterView.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = tableFooterView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Header In Section: %zi", section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Footer In Section: %zi", section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
	cell.imageView.image = [UIImage imageNamed:@"Credit_logo"];
    cell.textLabel.text = [NSString stringWithFormat:@"Section:%zi Row:%zi",indexPath.section, indexPath.row];
    
    return cell;
}

//全屏截图，仅获取已绘制部分
- (IBAction)screenSnapshotBtnClick:(id)sender {
	NSLog(@"----全屏截图---开始截图---------");

    UIImage * snapshotImg = [self screenshot];

	//保存相册
	UIImageWriteToSavedPhotosAlbum(snapshotImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

	NSLog(@"----全屏截图结束---------");
}

//列表截图
- (IBAction)snapshotBtn:(UIButton *)sender {
	NSLog(@"----列表截图---开始截图---------");
    UIImage * snapshotImg = [self.tableView zf_tableViewSnapshot];

	///结束之后滚动回顶部
	self.tableView.contentOffset = CGPointZero;

    //保存相册
    UIImageWriteToSavedPhotosAlbum(snapshotImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    NSLog(@"----列表截图结束---------");
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
	NSString *desc = @"";
    if (error == nil) {
		desc = @"保存相册成功";
    }else{
		desc = @"保存相册失败";
    }
	NSLog(@"-------%@---------", desc);

	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:desc delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
}

//普通系统截屏，仅获取绘制部分
- (UIImage *)screenshot{
    UIGraphicsBeginImageContextWithOptions(self.tableView.frame.size, NO, [UIScreen mainScreen].scale);
    CGRect tableViewFrame = self.tableView.frame;
    self.tableView.frame = CGRectMake(0.0, 0.0, self.tableView.frame.size.width, self.tableView.contentSize.height);
    [self.tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.tableView.frame = tableViewFrame;

    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
