PREFIX ?= /usr
COMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(COMPLETIONDIR)
	@mkdir -p $(DESTDIR)/var/log
	@cp -p uploadnewip $(DESTDIR)$(PREFIX)/bin
	@cp -p uploadnewip.completion $(DESTDIR)$(COMPLETIONDIR)/uploadnewip
	@cp -r -p etc/. $(DESTDIR)/etc
	@touch $(DESTDIR)/var/log/uploadnewip.log
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/uploadnewip
	@chmod 755 $(DESTDIR)$(COMPLETIONDIR)/uploadnewip
	@mkdir -p $(DESTDIR)/etc/uploadnewip/units
	@mkdir -p $(DESTDIR)/var/cache/uploadnewip/temp

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/uploadnewip
	@rm -rf $(DESTDIR)$(COMPLETIONDIR)/uploadnewip
	@rm -rf $(DESTDIR)/etc/uploadnewip
	@rm -rf $(DESTDIR)/var/cache/uploadnewip
	@rm -rf $(DESTDIR)/etc/systemd/systemd/uploadnewip.service
	@rm -rf $(DESTDIR)/var/log/uploadnewip.log

prep-deb:
	@mkdir -p build/uploadnewip
	@cp -r support/debian build/uploadnewip/debian
	@mkdir build/uploadnewip/debian/uploadnewip
	@make DESTDIR=build/uploadnewip/debian/uploadnewip install

deb-pkg: prep-deb
	@cd build/uploadnewip && debuild -b

deb-src: prep-deb
	@cd build/uploadnewip && debuild -S

clean:
	@rm -r build

help:
	@echo "Read 'README.md' for info on building."
