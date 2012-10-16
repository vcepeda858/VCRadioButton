//
//  VCRadioButton.h
//  VCRadioButton
//
//  Created by Vincent Cepeda.
//

#import <UIKit/UIKit.h>
@class VCRadioButton;
typedef void (^RadioButtonControlSelectionBlock)(VCRadioButton *radioButton);

@interface VCRadioButton : UIControl
@property (copy, nonatomic) RadioButtonControlSelectionBlock selectionBlock;
@property (copy, nonatomic) NSString *groupName;
@property (strong, nonatomic) UIColor *controlColor;
@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) id selectedValue;

- (id)selectedValueForGroup;
@end
