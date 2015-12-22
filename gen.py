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

# Find the necessary Parameters
pgsize = None; txtsz = None;
params_list = params_text.split(";")
print(params_list)
for param in params_list:
    t = param.find("txtsz");
    if t != -1:
        eq = param.find("=",t) #find the next = sign
        sn1 = param[eq+1:len(param)]
        txtsz = float(get_num(param[eq:len(param)]))
        print(txtsz)

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
if pgsize == None or txtsz == None or pgsize == [0,0] or txtsz == 0:
    raise Exception
else:
    print("pgsize = %s" % str(pgsize))
    print("txtsz = %d" % txtsz)


# Calculate Lines
CHARMAX = int(pgsize[0]/txtsz)
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
LINEMAX = int(pgsize[1]/txtsz)
lastpage = 0
for l in range(0,len(lines)):
    if l-lastpage==LINEMAX:
        pages.append(lines[lastpage:l])
        lastpage = l

# Create the text
textdata = "pages = %s" % str(pages)
textdata = textdata.replace("\'","\"")

# Write it
with open('textdata.txt','w') as f:
    f.write(textdata)

print("Done!")
