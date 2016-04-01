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
    
    UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    lable1.text = @"表头";
    lable1.contentMode = UIViewContentModeCenter;
    lable1.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = lable1;
    
    UILabel * lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    lable2.text = @"表尾";
    lable2.contentMode = UIViewContentModeCenter;
    lable2.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = lable2;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"区头:%ld",section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"区尾:%ld",section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"UITableViewCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.imageView.image = [UIImage imageNamed:@"Credit_logo"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section:%ld Row:%ld",indexPath.section, indexPath.row];
    
    return cell;
}

- (IBAction)snapshotBtn:(UIButton *)sender
{
    //截图
    UIImage * snapshotImg = [self.tableView screenshot];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    //仅获取绘制部分
//    UIImage * snapshotImg = [self screenshot];

    //保存相册
    UIImageWriteToSavedPhotosAlbum(snapshotImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    NSLog(@"-------保存相册---------");
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error == nil) {
        NSLog(@"-------保存成功---------");
        
    }else{
        NSLog(@"-------保存失败---------");
    }
}

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContext(self.tableView.frame.size);
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
