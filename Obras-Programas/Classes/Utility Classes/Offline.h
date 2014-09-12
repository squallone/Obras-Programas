
// Programador: Abdiel Soto, Pedro Contreras
// Origen: Edicomex
// Fecha inicio: Septiemnre 2014
// Fecha ultima modificación: 23/08/2014
// Descripción:
// Dependencias:

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface Offline : NSObject

@property BOOL hideStartActivityIndicator;
@property BOOL hideEndActivityIndicator;

- (NSString *)applicationDocumentsDirectory;
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

-(void)CloseDB;
-(void)OpenDB;
-(BOOL)AutoExecute:(NSString *)strSQL;
-(BOOL)ExecuteSQL:(NSString *)strSQL;
-(NSArray *)Consulta:(NSString *)strSQL;
-(NSArray *)AutoConsulta:(NSString *)strSQL;

@end
