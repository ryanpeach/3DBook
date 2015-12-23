from 3dimg.py import *

# Read source text
with open('source.txt','r') as f:
    source_text = f.read()
    print(source_text)

# Read parameters
with open('params.txt','r') as f:
    params_text = f.read()
    print(params_text)

# Gets the number within a string
def get_num(x):
    return float(''.join(ele for ele in x if ele.isdigit() or ele == '.'))

# Gets the bool value within a string (default is false)
def get_bool(x):
    return x.find("true")!=-1 or x.find("True")!=-1 or x.find("T")!=-1 or x.find("t")!=-1

# Find the necessary Parameters
pgsize, txtsz, lmargin, sigma, braille = None, None, None, None, None
params_list = params_text.split(";")
print(params_list)
for param in params_list:
    t = param.find("txtsz");
    if t != -1:
        eq = param.find("=",t) #find the next = sign
        sn1 = param[eq+1:len(param)]
        txtsz = float(get_num(param[eq:len(param)]))
        print(txtsz)
        
    t = param.find("lmargin");
    if t != -1:
        eq = param.find("=",t) #find the next = sign
        sn1 = param[eq+1:len(param)]
        lmargin = float(get_num(param[eq:len(param)]))
        print(lmargin)

    t = param.find("braille");
    if t != -1:
        eq = param.find("=",t) #find the next = sign
        sn1 = param[eq+1:len(param)]
        braille = float(get_bool(param[eq:len(param)]))
        print(braille)

    t = param.find("sigma");
    if t != -1:
        eq = param.find("=",t) #find the next = sign
        sn1 = param[eq+1:len(param)]
        sigma = float(get_num(param[eq:len(param)]))
        print(sigma)

    t = param.find("pgsize")
    if t != -1:
        b1 = param.find("[") #find the begin
        b2 = param.find("]",b1) #find the end bracket
        c = param.find(",",b1) #find the comma
        if b1!=-1 and b2!=-1 and c!=-1:
            sn1 = param[b1+1:c];
            sn2 = param[c+1:b2];
            pgsize = [get_num(sn1), get_num(sn2)]

# Test that the parameters were found, throw Exception otherwise
if pgsize == None or txtsz == None or sigma = None or lmargin == None or braille == None: #Future: check if get_num returns none as well
    raise Exception
else:
    pgsize[0] -= lmargin
    print("pgsize = %s" % str(pgsize))
    print("txtsz = %d" % txtsz)


# Calculate Lines
if(braille){CHARMAX = int(pgsize[0]/txtsz)}
else{CHARMAX = int(pgsize[0]/(txtsz/2))}
paragraphs = source_text.splitlines()
lines = []
for p in paragraphs:
    lineend = 0; n = 0;
    def end(a, b): return a+CHARMAX-b
    while end(lineend,n) < len(p):
        while p[end(lineend,n)]!=' ':
            n += 1
            if n == CHARMAX:
                n = 0
                print("Line Overflow: %d" % n)
                break
        line = p[lineend:end(lineend,n)]
        print("Line [%d : %d] (len=%d) -> %s" % (lineend, end(lineend,n), end(lineend,n)-lineend, p[lineend:end(lineend,n)]))
        lineend = end(lineend,n)+1
        lines.append(line)
        n = 0
    line = p[lineend:len(p)-1]
    lines.append(line)

# Calculate Pages
pages = []
if(braille) {LINEMAX = int(pgsize[1]/(txtsz))}
else {LINEMAX = int(pgsize[1]/(txtsz*1.5))}
lastpage = 0
for l in range(0,len(lines)):
    if l-lastpage==LINEMAX:
        pages.append(lines[lastpage:l])
        lastpage = l

# Create the text
textdata = "pages = %s" % str(pages)
textdata = textdata.replace("\'","\"")

# Write it
with open('.textdata','w') as f:
    f.write(textdata)

print("Done!")
