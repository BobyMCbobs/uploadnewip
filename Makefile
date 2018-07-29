PREFIX ?= /usr
COMPLETIONDIR ?= $(PREFIX)/share/bash-completion/completions

install:
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@mkdir -p $(DESTDIR)$(COMPLETIONDIR)
	@mkdir -p $(DESTDIR)/var/log
	@mkdir -p $(DESTDIR)/etc/uploadnewip
	@cp -p uploadnewip $(DESTDIR)$(PREFIX)/bin
	@cp -p uploadnewip.completion $(DESTDIR)$(COMPLETIONDIR)/uploadnewip
	@cp uploadnewip-blank.conf $(DESTDIR)/etc/uploadnewip
	@cp uploadnewip-settings.conf $(DESTDIR)/etc/uploadnewip
	@touch $(DESTDIR)/var/log/uploadnewip.log
	@chmod 755 $(DESTDIR)$(PREFIX)/bin/uploadnewip
	@chmod 755 $(DESTDIR)$(COMPLETIONDIR)/uploadnewip
	@mkdir -p $(DESTDIR)/etc/uploadnewip/units
	@mkdir -p $(DESTDIR)/var/cache/uploadnewip/temp
	@if [ -z $(NOSYSTEMD) ]; then \
	mkdir -p $(DESTDIR)/etc/systemd/system; \
	cp uploadnewip.service $(DESTDIR)/etc/systemd/system; fi;

uninstall:
	@rm -rf $(DESTDIR)$(PREFIX)/bin/uploadnewip
	@rm -rf $(DESTDIR)$(COMPLETIONDIR)/uploadnewip
	@rm -rf $(DESTDIR)/etc/uploadnewip
	@rm -rf $(DESTDIR)/var/cache/uploadnewip
	@rm -rf $(DESTDIR)/var/log/uploadnewip.log
	if [ -z $(NOSYSTEMD) ]; then \
	rm -rf $(DESTDIR)/etc/systemd/systemd/uploadnewip.service; fi;

prep-deb:
	@mkdir -p build/uploadnewip
	@cp -r support/debian build/uploadnewip/debian
	@mkdir build/uploadnewip/debian/uploadnewip
	@make DESTDIR=build/uploadnewip/debian/uploadnewip install
	@if [ ! -z $(NOSYSTEMD) ]; then \
	rm build/uploadnewip/debian/postinst; \
	rm build/uploadnewip/debian/prerm; fi;

deb-pkg: prep-deb
	@cd build/uploadnewip && debuild -b

deb-src: prep-deb
	@cd build/uploadnewip && debuild -S

clean:
	@rm -r build

help:
	@echo "Read 'README.md' for info on building."
