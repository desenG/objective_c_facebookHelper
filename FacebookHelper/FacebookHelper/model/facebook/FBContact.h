//
//  FBContact.h
//
//

@interface FBContact : NSObject<NSSecureCoding>
@property (nonatomic,strong) NSString *isSelected;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *name;
@end
