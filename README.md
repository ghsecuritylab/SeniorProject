# README #
### Framework ###

##### General #####
* The framework make commands ONLY work in Linux. If you have a windows computer. Please install a VM of Linux using VM Workstation. If your computer is not fast enough for a VM then you will have to dual boot. Also, for VM's, make sure you use a 32 bit version of Linux.

##### Hierarchy #####
* Projects - The folder where all sub-systems module is placed in.
* Projects/Subsystem - Contains the main file,Makefile,documentation folder, and source folder.
* Projects/Subsystem/Source -subsystem function library and other ultility library. 
* Projects/Subsystem/Documentation - Contain all document related to software and hardware component of the current subsystem.
* Projects/Subsystem/Test - Contains the unit testing files for the current subsystem.

##### Setting the Subsystem folder #####
1. Create a new project folder in the **Projects directory** by copying the Protolobe folder with a different name.
2. Place your methods in Source.c and Source.h, and your tasks in RTOS_Tasks.cpp and RTOS_Tasks.h.
3. Open up the Structure.h in **Source directory** and change the enum name and send variable and read variable size as neccessary. Below is an example of how I would change the structure.h for the Arm Subsystem.

```C
#ifndef STRUCTURE_INCLUDED
#define STRUCTURE_INCLUDED
#ifdef _cplusplus
extern "C"{
#endif
#define SEND_ITEM_SIZE 2
#define READ_ITEM_SIZE 3
typedef enum {
    //section for data to be send to mission control
    current=0,
    voltage=1,
    //section for data to be read from mission control
    shoulder=0,
    elbow=1,
    claw=3
};
typedef struct{
    int data[SEND_ITEM_SIZE]; //set array size as number of send data item
}Send_Data;

typedef struct {
    int data[READ_ITEM_SIZE]; //set array size as number of read data item
}Read_Data;

extern Send_Data send_data;
extern Read_Data read_data;

#ifdef _cplusplus
}
#endif
#endif /* Wifi */
```
* Now, go into Structure.c and change the following char array for  :
```C
const char* send_data_label[] = {"send_data_name_1","send_data_name_2"};
```
* to (if the arrays do not compile correctly, put SEND_ITEM_SIZE in the brackets)
```C
const char* send_data_label[] = {"current","voltage"};
```
* to write voltage value do the following 
```C
send_data.data[voltage]=20;
```
* to print out shoulder value do the following
```C
printf("%i",read_data.data[shoulder]);
```
* Look in the the Protolobe.cpp and RTOS_tasks.cpp file,these have a example functions that show how to read and write to data in the Structure.h . Remember that only variable in struct send_data{} will be send to Mission Control and all data from mission control will be stored in struct read_data{}.

##### Setting Up WI-FI Access Point Name and IP Address #####

1. To set your ESP's access point name, use the following function :
```C
set_wifi_ap("<name>", <name_size>);
```
2. To set your ESP's IP address, use the following function:
```C
set_static_ip("<IP_address>");
```
3. The AP (access point) name and IP address must be set during initialization. i.e. in your subsystem's init function.
##### Sending and Receiving data #####

1. To send data to Mission Control use the following function : 
```C
void send_data_wifi(int item_size)
```
* Convert all data in struct send_data{} to a string and send over to mission control
* param int item_size: pass in the number of how many item in send_data
* to use this function, call it exactly as follow 
```C
send_data_wifi(SEND_ITEM_SIZE);
```
2. To read data from Mission Control use the following function : 
```C
void read_data_wifi(int item_size)
```
* Convert string from Mission Control to integer value and store them in read_data
* param int item_size: pass in the number of how many item in read_data
* to use this function call it exactly as follow
```C
read_data_wifi(READ_ITEM_SIZE);
```

### Unit Testing ###

##### Basics #####
* TBD

##### Suites #####
* TBD

##### Tests #####
* TBD

##### Stubs #####
* TBD

### Setting Up ESP Loader ###

##### For Linux #####

1. Install the required package to compile with esp-idf.  
Terminal command: sudo apt-get install git wget make libncurses-dev flex bison gperf python python-serial  

2. Set your PATH variables in .profile to add paths to the esp-idf and the xtensa toolchain. The .profile file is hidden in the Home directory and can be found by pressing ctrl+h when in Home. Once you update the paths, you must either restart your bash or your system in order for the changes to take effect. 
**The lines to add are:**  
export PATH=$PATH:$(directory path to controlsystems2018)/controlsystems2018/esp-idf/xtensa-esp32-elf/bin    
export IDF_PATH=(directory path to controlsystems2018)/controlsystems2018/esp-idf  
**Example lines:**  
export PATH=$PATH:$HOME/Documents/2017-2018/controlsystems2018/esp-idf/xtensa-esp32-elf/bin  
export IDF_PATH=~/Documents/2017-2018/controlsystems2018/esp-idf   

### Make Commands ###

* `make menuconfig PROJECT_NAME=<Subsystem name>` - Open the config menu for the ESP32 toolchain.
* `make app-flash PROJECT_NAME=<Subsystem folder name>` - Flash your program onto the ESP32.
* `make app PROJECT_NAME=<Subsystem folder name>` - Build your program.
* `make monitor PROJECT_NAME=<Subsystem folder name>` - Creates all serial monitor with ESP32.

### Make Process ###
1. After coding your project, perform a `make menuconfig PROJECT_NAME=<Subsystem name>` to access the SDK configuration menu.
2. Navigate to and select Serial Flash Config and make sure the serial port setting is the port that the ESP32 is connected to.
3. Save the settings and exit.
4. Perform a `make app-flash PROJECT_NAME=<Subsystem folder name>` to build and upload your program to the ESP32.
	* if you only want to build the program, then perform `make app PROJECT_NAME=<Subsystem folder name>` 
