#!/usr/bin/python3
# -*- coding: UTF-8 -*-
import os
import re

class PathObject(object):
	"""docstring for PathObject"""
	def __init__(self,line,file):
		super(PathObject, self).__init__()

		path = re.findall(r"[(](.*)[)]",line)[0]
		cls = re.findall(r"[)](.*)[:]",line)[0]

		self.path = path.strip()
		self.cls = cls.strip()
		self.file = file
		self.key = self.path.replace('/','_')

list = []
		
def read():
    for root,dirs,files in os.walk('./'):
    	pass
    	for file in files:
    		pass
    		if file.endswith('.h'):
    			_file = open(root + '/' + file, 'r')

    			try:
    				line = _file.readline()
    				while line:
    					pass
    					if line.startswith('@Router'):
    						pass
    						list.append(PathObject(line,file))

	    				line = _file.readline()
    					
    			finally:
    				pass
    				_file.close()


def write():
	try:
		pass
		file_h = open('./RouterDemo/Other/HiRouterPath.h','w')
		file_m = open('./RouterDemo/Other/HiRouterPath.m','w')
		method = ''
		try:
			file_h.write('#import <UIKit/UIKit.h>\n')
			file_m.write('#import "HiRouterPath.h"\n#import "HiRouter.h"\n')
		finally:
			pass

		for object in list:
			pass
			tml_h = '\n/** in %s */\nextern NSString *const %s;\n'
			tml_m = '\nNSString *const %s = @"%s";'
			try:
				file_h.write(tml_h % (object.file,object.key))
				file_m.write(tml_m % (object.key,object.path))
				method += '\t%s.hi_class = NSClassFromString(@"%s");\n' % (object.key,object.cls)
			finally:
				pass

	finally:
		pass
		file_h.write("\n@interface HiRouterPath : NSObject\n\n+ (void)loadData;\n\n@end")
		file_h.close()
		file_m.write('\n@implementation HiRouterPath\n\n+ (void)loadData {\n%s}\n\n@end' % (method))
		file_m.close()
	

if __name__ == '__main__':
	pass
	read()
	write()