//
//  SNCustomCell.h
//  SampleCollectionView
//
//  Created by shahid on 27/08/14.
//  Copyright (c) 2014 SourceN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNCustomCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *insideView;
@property (weak, nonatomic) IBOutlet UILabel *textLbl;

@end
