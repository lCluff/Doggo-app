//
//  LECImageCollectionViewCell.h
//  DoggoApp-objC
//
//  Created by Leah Cluff on 5/23/19.
//  Copyright © 2019 Leah Cluff. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LECImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) NSURL * imageUrl;

@end



NS_ASSUME_NONNULL_END
