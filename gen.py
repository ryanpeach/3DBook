# Read source text
with open('source.txt','r') as f:
    source_text = f.read()

# Read parameters
with open('params.txt','r') as f:
    params_text = f.read()

# Find the necessary Parameters
params_list = params_text.split(str=";")
for param in params_list:
    t = params_text.find("txtsz")
    if t != -1:
        eq = params_text.find("=",beg=t) #find the next = sign
        sn1 = param[eq+1:len(param)]
        if sn1.isdecimal():
            txtsz = toDouble(sn1)

    t = params_text.find("pgsize")
    if t != -1:
        b1 = param.find("[",beg=b1) #find the begin
        b2 = param.find("]",beg=b1) #find the end bracket
        c = param.find(",",beg=b1) #find the comma
        if b1!=-1 and b2!=-1 and c!=-1:
            sn1 = param[b1+1:c-1];
            sn2 = param[c+1:b2-1];
            if sn1.isdecimal() and sn2.isdecimal():
                pgsize = [toDouble(sn1), toDouble(sn2)]

# Test that the parameters were found, throw Exception otherwise
if pgsize == None or txtsize == None or pgsize == [0,0] or txtsize == 0:
    raise Exception
else:
    print("pgsize = %s" % str(pgsize))
    print("txtsize = %d" % txtsize)


# Calculate Lines
CHARMAX = floor(pgsize[0]/txtsz)
paragraphs = source_text.splitlines()
lines = []
for p in paragraphs:
    lineend = 0; n = 0;
    end = lambda a, b: return a+CHARMAX-b
    while end(lineend,n) < len(p) :
        while p[end(linened,n)]!=' ':
            n += 1
            if n == CHARMAX:
                n = 0
                break
        line = p[lineend:end(linened,n)]
        lineend = end(linened,n)
        lines.append(line)
    line = p[lineend:len(p)-1]
    lines.append(line)

# Calculate Pages
pages = []
LINEMAX = floor(pgsize[1]/txtsz)
lastpage = 0
for l in [0:len(lines)]:
    if l-lastpage==LINEMAX:
        pages.append(lines[lastpage:l])
        lastpage = l

# Create the text
textdata = "pages = %s" % str(pages)

# Write it
with open('.textdata','rw') as f:
    f.write(textdata)

print("Done!")
