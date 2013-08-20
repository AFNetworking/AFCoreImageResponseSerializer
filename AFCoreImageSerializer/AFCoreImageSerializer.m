// AFCoreImageSerializer.m
// 
// Copyright (c) 2013 AFNetworking (http://afnetworking.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

@interface AFCoreImageSerializer ()
@property (readwrite, nonatomic, strong) CIContext *context;
@property (readwrite, nonatomic, strong) NSDictionary *options;
@property (readwrite, nonatomic, strong) NSArray *filters;
@end

@implementation AFCoreImageSerializer

+ (instancetype)serializerWithFilters:(NSArray *)filters {
    return [self serializerWithFilters:filters options:nil];
}

+ (instancetype)serializerWithFilters:(NSArray *)filters
                              options:(NSDictionary *)options
{
    AFCoreImageSerializer *serializer = [[self alloc] init];
    serializer.filters = filters;
    if (options) {
        serializer.options = options;
    }

    return serializer;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.options = @{ kCIImageColorSpace: [NSNull null] };

    return self;
}

- (CIContext *)context {
    @synchronized(self) {
        if (!_context) {
            self.context = [CIContext contextWithOptions:self.options];
        }

        return _context;
    }
}

#pragma mark - AFURLResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    id responseObject = [super responseObjectForResponse:response data:data error:error];
    if (!responseObject) {
        return nil;
    }

    CIImage *image = [[CIImage alloc] initWithCGImage:[responseObject CGImage]];
    for (CIFilter *filter in self.filters) {
        [filter setValue:image forKey:kCIInputImageKey];
        image = filter.outputImage;
    }

    return [UIImage imageWithCGImage:[self.context createCGImage:image fromRect:image.extent]];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }

    self.options = [aDecoder decodeObjectForKey:@"options"];
    self.filters = [aDecoder decodeObjectForKey:@"filters"];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];

    [aCoder encodeObject:self.options forKey:@"options"];
    [aCoder encodeObject:self.filters forKey:@"filters"];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
    return [[self class] serializerWithFilters:self.filters options:self.options];
}

@end
