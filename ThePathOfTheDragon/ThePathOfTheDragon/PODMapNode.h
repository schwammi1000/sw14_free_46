//

#import <SpriteKit/SpriteKit.h>

#import "PODCastleNode.h"
#import "PODRiverNode.h"
#import "PODCoinNode.h"

@interface PODMapNode : SKSpriteNode

@property SKNode *background;
@property SKNode *castles;
@property SKNode *rivers;
@property SKNode *coins;

@property SKTextureAtlas *atlas;
@property NSString *textureName;

+(instancetype)createMapWithSize:(CGSize)mapSize Tilesize:(CGSize)tileSize Texture:(NSString *)name;

-(void)addCastle:(PODCastleNode *)castle At:(CGPoint)position;

-(void)addRiver:(PODRiverNode *)river At:(CGPoint)position;

-(void)addCoin:(PODCoinNode *)coin At:(CGPoint)position;

-(void)add:(int)numberCoins CoinsWithStartValue:(int)start;

@end
