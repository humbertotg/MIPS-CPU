from selenium import webdriver
import requests
import urllib.request
from selenium.webdriver.common.keys import Keys


def getTranslation(mipsInstruction, instructionNumber):
    instructionField.send_keys(mipsInstruction)
    convertButton.click()
    paragraphs = browser.find_elements_by_xpath("//h3")
    instructionField.clear()
    return "arr(" + str(instructionNumber) + ") <= \"" + paragraphs[0].text[8::] + "\";"


#please change this path to where your driver is installed, in my case it is chromedriver.exe
browser = webdriver.Chrome(executable_path=r'D:\chromedriver_win3279\chromedriver.exe')

browser.get('https://www.eg.bucknell.edu/~csci320/mips_web/')
instructionField = browser.find_element_by_id("instruction")
convertButton = browser.find_element_by_id("convert")
testIstr = "add $r8, $r0, $r0"
testIstr2 = "add $r8, $r0, $r2"

saltos = {}
pasada1 = 0
pasada2 = 0
f = open("archivo.txt", "r")
for x in f:
    
    if(x.count('j') and x.count('jr') == 0):
        saltos[x.replace('j',' ').strip()] = 0
    if(x.count(':')):
        saltos[x[0:x.find(":")-1]] = pasada1
    pasada1 += 1
f.close()

f = open("archivo.txt", "r")
vacio = ""
for x in f:
    
    if(x.count('j') and x.count('jr') == 0):
        x = saltos[x.replace('j',' ').strip()]
        x = "j 0x"+str(x)
    elif(x.count(':')):
        x = x[x.find(':')+1::].strip()
    
    elif(x.lower().count('beq')):
        x = x[0:x.rfind(',')+2] + "0x" + str(saltos[x[x.rfind(',')+1::].strip()])
    vacio += getTranslation(x,pasada2)+"\n"
    print(getTranslation(x,pasada2))
    pasada2+=1
out = open("o.txt","w")
out.write(vacio)

for i in range(pasada2,32):
    out.write("arr(" + str(i) + ") <= \"00000000000000000000000000000000\";\n")
    print("arr(" + str(i) + ") <= \"00000000000000000000000000000000\";")
        
f.close()
print(saltos)

