import re, sys

report     = re.compile(r'@SEPREPORT')
sep        = re.compile(r'organization={SEP}')
volume     = re.compile(r'volume={(\d+)')
underscore = re.compile(r'([^\\])\_')
url        = re.compile(r'url=')

def convert():
    while True:
        line = sys.stdin.readline()
        if not line:
            sys.exit(0)
        line = report.sub('@incollection',line)
        line = sep.sub('publisher={Stanford Exploration Project}',line)
        line = volume.sub(r'booktitle={SEP-\1',line)
        #        line = underscore.sub(r'\1\_',line)
        line = url.sub('web=',line)
        sys.stdout.write(line)
        
if __name__ == '__main__':
    convert()
