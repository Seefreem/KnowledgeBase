# file = open("pannning_log.txt")
file = open("log/decision_log.txt")
targtet_file = open("obj.log", "w")
for line in file:
    # if " Recv_Lidar_Obj 141]" in line :
    if  "VehicleGearControl" in line :
        
        targtet_file.write(line)

    
file.close()
targtet_file.close()