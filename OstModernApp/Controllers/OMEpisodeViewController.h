//
//  OMEpisodeViewController.h
//  OstModernApp
//
//  Created by Guowei Mo on 11/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMSetDataProtocol.h"

@interface OMEpisodeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (void)retrieveEpisodeDataFromURL:(NSString *)url;
- (instancetype)initWithCellItem:(NSInteger)item;

@property (nonatomic, assign) NSInteger setItem;
@property (weak) id<OMSetDataDelegate> delegate;

@end
