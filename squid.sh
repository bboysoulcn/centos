wget http://www.squid-cache.org/Versions/v4/squid-4.5.tar.gz
tar -zxvf squid-4.5.tar.gz
./configure --prefix=/usr/local/squid
make 
make install