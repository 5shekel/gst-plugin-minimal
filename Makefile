CC=gcc
gst_path=/opt/gst/x64

all: libgstplugin.so
%.o: %.c
	$(CC) -I. -pthread \
	-I$(gst_path)/include/gstreamer-1.0 \
	-I/usr/include/orc-0.4 \
	-I/usr/include/glib-2.0 \
	-I/usr/lib/x86_64-linux-gnu/glib-2.0/include \
	-Wall -g -O2 -Wall -c $^ -fPIC -DPIC -o $@

#added call to pkg-config to find our libs
lib%.so: %.o
	$(CC) `pkg-config --cflags --libs gstreamer-1.0` -shared  -fPIC -DPIC $^ -lgstcontroller-1.0 -lgstaudio-1.0 -lgstbase-1.0 -lgobject-2.0 -lglib-2.0  -pthread -g -O2  -pthread -Wl,-soname -Wl,$@ -o $@
