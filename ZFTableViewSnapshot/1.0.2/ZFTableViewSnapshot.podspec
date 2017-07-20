
Pod::Spec.new do |s|
  
  s.name         = "ZFTableViewSnapshot"
  s.version      = "1.0.2"
  s.summary      = "ZFTableViewSnapshot - 类似于高德地图路线截取tableView长图的功能"
  s.description  = "类似于高德地图路线截取tableView长图的功能。主要功能： 调用单个方法获取整个tableView长图，类似于高德地图路线截取长图的功能；使用方法：1.将Demo中UITableViewSnapshot文件夹拖进项目；2.在使用的文件中导入#import UITableView+ZFTableViewSnapshot.h头文件；3.调用[self.tableView screenshot]即可方法获取整个tableView长图，返回对象为UIImage类型。"
  s.homepage     = "https://github.com/ZFBest/UITableViewSnapshot"
  s.license      = { :type => 'MIT'}
  s.author             = { "任占飞" => "renzhanfei@youyuwo.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ZFBest/UITableViewSnapshot.git", :tag => "#{s.version}" }
  s.source_files  = "ZFTableViewSnapshot", "UITableViewSnapshotTest/UITableViewSnapshot/*.{h,m}"

end
