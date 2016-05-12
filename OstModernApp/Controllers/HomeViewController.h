//
//  ViewController.h
//  OstModernApp
//
//  Created by Guowei Mo on 06/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMSetDataProtocol.h"

@interface HomeViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, OMSetDataDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

