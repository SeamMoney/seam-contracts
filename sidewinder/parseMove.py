# take the directory of the module

from psutil import OSX
import stransi
import os
import sys
import subprocess
compile_cmd = "aptos move test  --named-addresses seam=default"

def write_sources(move_map):
    os.chdir("../sidewinder")
    try:
        os.mkdir("move")
    except:
        pass

    os.chdir("move")
    for file in move_map.keys():
        with open(file, 'w+') as f:
            for line in move_map[file]:
                f.write(line)
            # file.close()


# def parse_info

# navigate to the directory of the module in seamDao
os.chdir("../SeamDAO")


# res = os.cmd(compile_cmd)
res = subprocess.getoutput(compile_cmd)
move_map = {}
warning_map = {}
warning_ls = []

if res != 0:
    res = res.split("warning")
    print(len(res),"warnings")

    for warning in res[1:]:
        warn_lines = warning.split("\n")
        warn_string = warn_lines[0]
        warn_file = warn_lines[1].split(":")[0].split("/")[-1]
        warn_line = warn_lines[1].split(":")[1]
        warn_info = warn_lines[2:]
        warn_type=""
        for line in warn_info:
            if "Consider" in line:
                warn_info = stransi.Ansi(line)
                escs = warn_info.instructions()
                for esc in escs:
                    if "Unused 'use'" in str(esc):
                        warn_info = esc
                        item_1 = warn_info.split("'")[3]
                        warn_type = "unused_use"

                        print("type 1",item_1)
                    if "Unused parameter" in str(esc):
                        # replace the parameter with _
                        warn_info = esc
                        item_1 = warn_info.split("'")[1]
                        warn_type = "unused_param"
                        print("UNUSED param found",item_1)
                    if "Unused assignment" in str(esc):
                        warn_info = esc
                        item_1 = warn_info.split("'")[1]
                        warn_type = "unused_assignment"
                        print("UNUSED assignment found",item_1)
                    
                # print("escapes",escs)
                break
        # var

            

        # print(warn_string)
        # print(warn_line)
        # print(warn_file)
        # print(warn_info)
        # print("next Line:",warn_lines[2])
        
        w = {"file":warn_file,"line":warn_line,"string":warn_string,"info":warn_info,"type":warn_type,"item_1":item_1}
        print(w)
        warning_ls.append(w)
        warning_map[(warn_file,warn_line)] = w


    # open all of the .move files in the directory
    os.chdir("sources")
    print(os.getcwd())
    for file in os.listdir():
        if file.endswith(".move"):
            with open(file, 'r') as f:
                print("opening",file)
                lines = f.readlines()
                i=0
                
                for line in lines:
                    if (file,str(i)) in warning_map.keys():
                        print("found")
                        w = warning_map[(file,str(i))]
                        if w["type"] == "unused_use":
                            lines[i-1] = '//'+lines[i-1]
                        if w["type"] == "unused_param":
                            index = lines[i-1].find(w["item_1"])
                            lines[i-1] = lines[i-1][:index] + "_"+item_1 + lines[i-1][index+len(w["item_1"]):]
                            # lines[i] = lines[i].replace(w["info"].split("'")[1],"_")
                        if w["type"] == "unused_assignment":
                            index = lines[i-1].find(w["item_1"])
                            lines[i-1] = lines[i-1][:index] + "_" + lines[i-1][index+len(w["item_1"]):]

                        # break
                    i+=1
                move_map[file] = lines
                print("opened", file)

    write_sources(move_map)



# def prefix_param():

# def write_warning_fix():


# print(res)
