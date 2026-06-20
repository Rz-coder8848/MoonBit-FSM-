import os
import re

for root, _, files in os.walk('.'):
    for file in files:
        if file.endswith('.mbt'):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # fix inspect quotes
            content = re.sub(r'content="\\"(.*?)\\""', r'content="\1"', content)
            
            # fix builder new signature
            content = re.sub(r'pub fn\[S : Hash \+ Eq, E : Hash \+ Eq, Ctx\] Builder::new\(\)',
                             r'pub fn[S, E, Ctx] Builder::new()', content)
            
            with open(path, 'w', encoding='utf-8') as f:
                f.write(content)
