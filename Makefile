all:
	mkdir uploadnewip
	fakeroot -u cp -r --no-preserve=ownership DEBIAN etc usr var uploadnewip
	dpkg-deb --build uploadnewip
	fakeroot -u rm -r uploadnewip

clean:
	fakeroot -u rm -r uploadnewip*

install:
	apt install ./uploadnewip.deb
