#!/usr/bin/ksh

sh BUILD/cleanup
find $PWD -name CMakeFiles -exec rm -rf {} \;
find $PWD -name CMakeCache.txt -exec rm -rf {} \;


export APPATH="/usr/local/itsvbuild/64"
export INSTPATH="/usr/local/mariadb"

print "testing C++ compiler..."

xlC_r -o /root/hello /root/hello.cpp >/dev/null 2>&1
if  [ $? -ne 0 ]; then
print "C++ compiler not working, probably license expired. This can not be solved in a "passing by" fashioned way, so consider your task canceled and take this opportunity to start thinking about the real me
aning of life, read a book, scratch your balls or do whatever you prefer."
exit 1
else
print "C++ compiler OK"
fi

export PATH="$APPATH/bin:$PATH"
export LIBPATH="$APPATH/lib:/usr/lib:/lib:/opt/freeware/lib64:/opt/freeware/lib"
export LD_LIBRARY_PATH="$APPATH/lib:/opt/freeware/lib64:/opt/freeware/lib:/usr/lib:/lib"
export OBJECT_MODE=64
export CC="xlc_r"
export CFLAGS="-q64 -qmaxmem=-1 -qstaticinline -qcpluscmt -DNDEBUG -DSYSV -D_AIX -D_AIX64 -D_AIX41 -D_AIX43 -D_AIX51 -D_AIX52 -D_AIX53 -D_AIX61 -D_AIX71 -D_ALL_SOURCE -DUNIX \
-DFUNCPROTO=15 -O2" 
#-I$APPATH/include -I/opt/freeware/include" 
export CXX="xlC_r"
export CXXFLAGS=$CFLAGS
export LDFLAGS="-L$APPATH/lib -L/opt/freeware/lib64 -L/opt/freeware/lib -Wl,-blibpath:$INSTPATH/lib:$APPATH/lib:/usr/lib:/lib -Wl,-bmaxdata:0x80000000 -Wl,-b64 -Wl,-bexpall \
-Wl,-bexpfull -Wl,-bnoipath -Wl,-bbigtoc"


gmake clean
cmake . -DCMAKE_INSTALL_PREFIX=$INSTPATH -DWITH_UNIT_TESTS=OFF -DWITH_JEMALLOC=NO -DWITH_EXTRA_CHARSETS=complex -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_SSL=bundled
#gmake
