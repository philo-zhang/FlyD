//
//  GimbalMode.m
//  FlyDJI
//
//  Created by zhangzhe on 20/10/2016.
//  Copyright © 2016 zhangzhe. All rights reserved.
//

#import "GimbalMode.h"

@interface GimbalMode() <UITableViewDataSource, UITableViewDelegate> {
    NSArray *gimbalModes;
}

@end

@implementation GimbalMode

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView reloadData];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    
    self.view = tableView;
    gimbalModes = [[NSArray alloc] initWithObjects: NSLocalizedString(@"Free Mode", @""), NSLocalizedString(@"FPV Mode", @""), NSLocalizedString(@"Yaw Follow Mode", @""), nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.delegate setGimbalModeValue:self.index];
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [gimbalModes objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if (indexPath.row == self.index)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.index == indexPath.row)
        return;
    else {
        NSIndexPath *oldIndexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:oldIndexPath];
        if (oldCell.accessoryType == UITableViewCellAccessoryCheckmark) {
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        if (newCell.accessoryType == UITableViewCellAccessoryNone) {
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        self.index = indexPath.row;
    }
}

@end

