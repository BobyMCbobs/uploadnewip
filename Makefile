all:
	mkdir uploadnewip
	sudo cp -r --no-preserve=ownership DEBIAN etc usr var uploadnewip
	dpkg-deb --build uploadnewip
	sudo rm -r uploadnewip

clean:
	sudo rm -r uploadnewip*
