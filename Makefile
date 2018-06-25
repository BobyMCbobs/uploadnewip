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

deb:
	@mkdir build
	@make DESTDIR=build install
	@cp -r support/debian build/DEBIAN
	@sudo chown -R root:root build
	@dpkg-deb --build build
	@sudo chown -R $$(whoami):$$(whoami) build
	@mv build.deb uploadnewip.deb

clean:
	@rm -r build uploadnewip.deb

help:
	@echo "Read 'README.md' for info on building."
