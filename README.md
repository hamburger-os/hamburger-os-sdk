# The Applications of HamburgerOS #

## 初始化仓库 ##

第一次克隆本仓库需要执行初始化操作，本仓库源代码使用git submodule分别管理，克隆本仓库需使用如下命令：

```
git clone --recursive https://github.com/hamburger-os/hamburger-os-sdk.git
```

## 创建应用 ##

在此目录创建应用的文件夹，参照例子的形式编写应用代码，然后使用build.bat脚本对代码进行编译。需要使用env从此目录启动，然后输入如下所示的代码：

    build.bat app app/hello

上述命令编译了hello文件夹下的应用代码，编译结果为hello.mo，或者输入如下所示的代码：

    build.bat lib lib/lib_func

上述命令以lib的形式编译了lib文件夹下的应用代码，编译结果为lib_func.so

将编译结果拷贝至硬件的文件系统当中，可通过命令行直接运行或者加载。

## 根文件系统 ##

模仿Linux编写了根文件系统，可在rootfs文件夹下找到根文件系统的示例。

同Linux一致，在etc文件夹下存在rc.d文件，此文件指定了开机启动的应用程序，或者需要加载的库文件，在bsp中开启了此功能之后，文件中指定的应用或者库，即可在开机时自动得到执行。

通过输入如下所示的代码，可以将已编译的app和lib自动地复制到rootfs完成打包：

    mkrootfs.bat

## Introduction ##

The user application is the application layer of RT-Thread RTOS. The developer can 
develop his/her application out of RT-Thread RTOS firmware environment.

There are two mode for RT-Thread Applications, 

* Standalone Application 
* Shared Library

The standalone application has a main() function as the program entry. It more like 
a program in the PC/Linux. 

The shared library is compose of functions, and provide these APIs to other programs.

## Build Application ##

First of all, these programs must base on RT-Thread RTOS environment, and run inside. 
In the RT-Thread RTOS, the module option must be enable in rtconfig.h File:

    #define RT_USING_MODULE

And provide the flags for Application building in rtconfig.py file (since RT-Thread 2.1.x, 
these flags will be gradually added to each BSP): 

* M_CFLAGS - User Application C/C++ compiler flags
* M_LFLAGS - User Application link flags

And Provide the ENV variable `BSP_ROOT` which points to your board support package 
directory. 

Windows:

    set BSP_ROOT=your_bsp_directory

Linux:

    export BSP_ROOT=your_bsp_directory

And to run the command under your BSP directory:

    scons --target=ua -s

To generate the information for User Application, such as the header file search path, 
the macro defined in the RT-Thread RTOS etc. 

Finally, you can build the user application in `rtthread-apps` directory, for example:

    scons --app=hello

To build `hello` program. 

    scons --lib=libtar

To build a shared library. 

## A Simple Application ##

This is a simple application of `Hello World`:

    #include <stdio.h>
    
    int main(int argc, char **argv)
    {
        printf("Hello World!\n");
        return 0;
    }

It's just like the `Hello World` program in the PC/Linux. Beside that, the user 
application can use the most of APIs of RT-Thread, for example:

    #include <rtthread.h>
    
    void my_thread_entry(void* parameter)
    {
        int index;
        
        while (1)
        {
            rt_kprintf("index => %d\n", index ++);
            rt_thread_delay(RT_TICK_PER_SECOND);
        }
    }
    
    int my_thread_init(void)
    {
        rt_thread_t tid;
        
        tid = rt_thread_create("tMyTask', my_thread_entry, RT_NULL, 
            2048, 20, 20);
        if (tid != RT_NULL) rt_thread_startup(tid);
        
        return 0;
    }

This example will create a sub-thread, which named as 'tMyTask'. 

## Build the POSIX application in the host ##

If you didn't set RTT_ROOT/BSP_ROOT, The command ```scons --app=hello``` will 
build the program in host environment, for example, build it as a Linux program. 

Therefore, only POSIX application can be built like that. 

## License ##

All of user application are standalone program, if there is no special explanation, 
the license of these program is [GPLv2](LICENSE). While the license of RT-Thread RTOS is GPLv2+. 
